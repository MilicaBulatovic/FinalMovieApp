//
//  ContentView.swift
//  SampleMovieApp
//
//  Created by obuke on 12/04/2023.
//

import SwiftUI

struct MovieAppView: View {

    var body: some View {
        
        VStack {
            HeaderMovieView()
            Spacer()
            SearchBarView()
            Spacer()
            //    MovieListView()
            Spacer()
            MovieNavigationView()
            Spacer()
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieAppView()
    }
}
