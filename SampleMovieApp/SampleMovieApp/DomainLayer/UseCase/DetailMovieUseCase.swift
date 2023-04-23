//
//  DetailMovieUseCase.swift
//  SampleMovieApp
//
//  Created by obuke on 12/04/2023.
//

import Foundation
import Combine

protocol DetailMovieUseCase {
    func fetchMovieDetails(id: Int) -> AnyPublisher<DetailMovieResponse, Error>
}

struct DetailMovieResponse {
    let id: Int
    let title: String
    let moviePoster : String?
    let backdropPoster: String?
    let overview: String
    let voteAverage : Double
    let voteCount: Int
    let popularity: Double
    let releaseDate: String
    let runtime : Int?
    let genre : String
    
}
