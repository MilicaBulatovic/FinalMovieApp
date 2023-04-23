//
//  AppDependenciesContainer.swift
//  SampleMovieApp
//
//  Created by obuke on 12/04/2023.
//testability

import Foundation

final class AppDependenciesContainer: MovieDetailViewModelDependencies {
    
    let webService = NetworkService(networkSession: DataNetworkSession())
    
    lazy  var detailMovieUseCase: DetailMovieUseCase = MovieProvider(webService: webService)
    
    lazy   var nowPlayingUseCase: NowPlayingUseCase = NowPlayingProvider(webService: webService)
    
}
