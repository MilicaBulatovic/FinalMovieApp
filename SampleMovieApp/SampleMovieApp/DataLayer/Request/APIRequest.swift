//
//  APIRequest.swift
//  FinalAsigmentMovieApp
//
//  Created by obuke on 09/04/2023.
//

import Foundation

struct APIRequest {
    let API_KEY = "dc5c932b0f572b9794e3db0bb55124d0"
    let baseURL: String = "https://api.themoviedb.org"
    let endpoint: Endpoint
    
    func getURLRequest() throws -> URLRequest {
        let url = baseURL + "/" + endpoint.serverVersion + "/" +  endpoint.path  + endpoint.parameters  + "api_key=\(API_KEY)"
        
        guard let url1 = URL(string: url) else {
            throw URLError.urlMalformed
        }
        return URLRequest(url: url1)
    }
}


enum Endpoint {
    
    case nowPlaying
    case searchMovies(String)
    case movieDetails(Int)
    case upcoming
    case popular
    case topRated
    
    var serverVersion: String { //ne zavisi od endpointa?
        "3"
    }
    
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "movie/now_playing?"
        case .searchMovies:
            return "search/movie"
        case .movieDetails:
            return "movie/"
        case .upcoming:
            return "movie/upcoming?"
        case .popular:
            return "movie/popular?"
        case .topRated:
            return "movie/top_rated?"
        }
    }
    
    var parameters: String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .searchMovies(let str):
            return "\(str)?"
        case .movieDetails(let id):
            return "\(id)?"
        case .upcoming:
            return "Upcoming"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
            
        }
    }
    
}

enum URLError: Error {
    case urlMalformed
    
}
