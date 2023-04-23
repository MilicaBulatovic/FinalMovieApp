//
//  MovieAppUseCase.swift
//  SampleMovieApp
//
//  Created by obuke on 12/04/2023.
//

import Foundation
import Combine

protocol SearchMovieUseCase {
    func fetchSearchMovie(forMovie str: String) -> AnyPublisher<[SearchMovie], Error>
}

struct SearchMovie {
    let moviePoster: String
    let originalTitle: String
    let popularity: Double
    let releaseDate: String
    let runtime: Int
}
