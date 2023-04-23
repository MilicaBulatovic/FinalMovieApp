//
//  SampleMovieAppApp.swift
//  SampleMovieApp
//
//  Created by obuke on 12/04/2023.
//

import SwiftUI

@main
struct SampleMovieAppApp: App {
    let dependencyContainer = AppDependenciesContainer()
    
    var body: some Scene {
        WindowGroup {
            MovieDetailView(dependencies: dependencyContainer)
        }
    }
}
