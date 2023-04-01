//
//  WebService.swift
//  MovieApp-MVVM-Programmatic
//
//  Created by Ismail Tever on 1.04.2023.
//

import Foundation
import Alamofire

protocol ServiceProtocol {
    
    func fetchMovies(onSuccess: @escaping (Movies?) -> (), onError: @escaping (AFError) -> (Void) )

}

final class Service: ServiceProtocol {
    func fetchMovies(onSuccess: @escaping (Movies?) -> (), onError: @escaping (Alamofire.AFError) -> (Void)) {
        ServiceManager.shared.fetch(path: Constant.ServiceEndPoint.moviesServiceEndPoint()) { (response: Movies) in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }

    }
    
    
}

//protocol içinde göndeşer yazılmaz, sadece protokolün özelliği yazılır. protokolün ne yapıcağını class ya da struct içerisinde belirtiriz.
