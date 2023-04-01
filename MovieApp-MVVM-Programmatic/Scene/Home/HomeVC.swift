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
final class HomeVC: UIViewController {

    //MARK: - UI Elements
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    //MARK: - Properties
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        configure()
        makeTableView()
    }
    
    //MARK: - Functions
    
    private func configure() {
        drawDesign()
        addElementSubviews()
    }
    
    private func drawDesign() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieHomeCell.self, forCellReuseIdentifier: MovieHomeCell.cellIdentifier.custom.rawValue)
    }
    
    private func addElementSubviews() {
        view.addSubview(tableView)
        
    }
    
    //MARK: - Actions
    
}

//MARK: - TableView Extansions

extension HomeVC: ConfigureTableView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MovieHomeCell = tableView.dequeueReusableCell(withIdentifier: MovieHomeCell.cellIdentifier.custom.rawValue) as? MovieHomeCell else { return UITableViewCell() }
        return cell
    }//casting yapaken ! kullanmadık çünkü guard let ile yaptık. casting yaparak diğer tarafa ulaştık.
    
}

extension HomeVC {
    private func makeTableView() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

