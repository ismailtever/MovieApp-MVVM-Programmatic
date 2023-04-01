//
//  ServiceConstant.swift
//  MovieApp-MVVM-Programmatic
//
//  Created by Ismail Tever on 1.04.2023.
//

import Foundation

extension Constant {
    
    enum ServiceEndPoint: String {
        
        case BASE_URL = "https://api.themoviedb.org/3/discover/movie?"
        case API_KEY = "api_key=59d1ea6d131e11d3a7f4921da8243138"
        
        static func moviesServiceEndPoint() -> String {
           return "\(BASE_URL.rawValue)\(API_KEY.rawValue)"
        }
    }
}
