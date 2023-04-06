//
//  HomeVC.swift
//  MovieApp-MVVM-Programmatic
//
//  Created by Ismail Tever on 29.03.2023.
//
//final class çünkü alt classlar tarafından override edilemeyeceğini bu şekilde belirtiyoruz.
//uygulama performansını artırır.


import UIKit
import SnapKit


protocol MovieOutput {
    func selectedMovies(imdbID: String)
}

final class MovieHomeController: UIViewController {
    
    // MARK: - UI Elements
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private lazy var searchBar: UISearchController = {
        let search = UISearchController()
        return search
    }()
    
    private let service = Services()
    private var search = [Search]()
    private var viewModel: MovieHomeProtocol = MovieHomeViewModel(service: Services())
    let cellSpacingHeight: CGFloat = 5
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
         viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchBar.searchBar.text = nil
        searchBar.isActive = false
    }
    
    // MARK: - Functions
    
    private func configure() {
        addSubviews()
        drawDesign()
        makeTableView()
    }
    
    private func drawDesign() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieHomeTableViewCell.self, forCellReuseIdentifier: MovieHomeTableViewCell.Identifier.custom.rawValue)
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
        configureNavigationBar(largeTitleColor: .systemIndigo, backgoundColor: .white, tintColor: .black, title: "Top IMDB Movies", preferredLargeTitle: false)
        navigationItem.searchController = searchBar
        searchBar.searchResultsUpdater = self
        
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        
    }
    
}

// MARK: - Tableview Extension

extension MovieHomeController: ConfigureTableView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        search.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: MovieHomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieHomeTableViewCell.Identifier.custom.rawValue) as? MovieHomeTableViewCell else {
            return UITableViewCell()
        }
        cell.saveModel(model: search[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

         viewModel.delegate?.selectedMovies(imdbID: search[indexPath.row].imdbID)
    }
}

// MARK: - Snapkit Extension

extension MovieHomeController {
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().inset(15)
            
        }
    }
}

// MARK: - Search Controller Extension
extension MovieHomeController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let writtenText = searchController.searchBar.text else { return }
        let searchMovieName = writtenText.replacingOccurrences(of: " ", with: "%20")
        service.searchMovie(searchMovieName: searchMovieName, completion: {
            data in
            self.search = data ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
}

extension MovieHomeController: MovieOutput {
    func selectedMovies(imdbID: String) {
         viewModel.getMovieDetail(movieImdbId: imdbID) { data in
            guard let data = data else { return }
            self.navigationController?.pushViewController(MovieDetailScreen(detailResults: data), animated: true)
        }
        
    }
    
}
//MARK: - Navigation Controller Extension
extension MovieHomeController {

func configureNavigationBar(largeTitleColor: UIColor, backgoundColor: UIColor, tintColor: UIColor, title: String, preferredLargeTitle: Bool) {
    if #available(iOS 13.0, *) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.backgroundColor = backgoundColor
        navBarAppearance.shadowColor = nil

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance

        navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = tintColor
        navigationController?.navigationBar.topItem?.backButtonTitle = "100+ Popular Movie Search"
        navigationItem.title = title


    } else {
        // Fallback on earlier versions
        navigationController?.navigationBar.barTintColor = backgoundColor
        navigationController?.navigationBar.tintColor = tintColor
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = title
    }
}
}


