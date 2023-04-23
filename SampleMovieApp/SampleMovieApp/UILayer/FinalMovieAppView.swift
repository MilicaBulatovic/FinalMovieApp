//
//  TabBarView.swift
//  SampleMovieApp
//
//  Created by obuke on 12/04/2023.
//

import SwiftUI

struct FinalMovieAppView: View {
    var body: some View {
        
        TabView {
            
            MovieAppView()
                .tabItem {
                    Label("Home" , systemImage: "house")
                }
            SearchMoviesView()
                .tabItem {
                    Label("Search" , systemImage: "magnifyingglass")
                }
            WatchListMoviesView()
                .tabItem {
                    Label("Watch list" , systemImage: "bookmark")
                }
            
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        FinalMovieAppView()
            .preferredColorScheme(.dark)
    }
}
