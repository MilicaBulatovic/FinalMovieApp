//
//  NowPlayingUseCase.swift
//  SampleMovieApp
//
//  Created by obuke on 13/04/2023.
//

import Foundation
import Combine

protocol NowPlayingUseCase {
    func fetchNowPlayingData() -> AnyPublisher<[NowPlayingData], Error>
}

struct NowPlayingData: Identifiable {
    let id : Int
    let posterPath: String?
    let backdropPoster: String?
}
