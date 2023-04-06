//
//  MovieViewModel.swift
//  MovieApp-MVVM-Programmatic
//
//  Created by Ismail Tever on 1.04.2023.
//

import Foundation

protocol MovieHomeProtocol{
    func searchMovie(searchMovieName: String, completion: @escaping ([Search]?) -> Void)
    func getMovieDetail(movieImdbId: String, completion: @escaping (DetailResults?) -> Void)
    var delegate: MovieOutput? { get set }
}


final class MovieHomeViewModel: MovieHomeProtocol {
    var delegate: MovieOutput?
    private var service: MovieServiceProtocols
    
    init(service: MovieServiceProtocols) {
        self.service = service
    }
  
}

extension MovieHomeViewModel {
    func searchMovie(searchMovieName: String, completion: @escaping ([Search]?) -> Void) {
        service.searchMovie(searchMovieName: searchMovieName) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
    
    func getMovieDetail(movieImdbId: String, completion: @escaping (DetailResults?) -> Void) {
        service.getMovieDetail(movieImdbId: movieImdbId) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
        
    
}
