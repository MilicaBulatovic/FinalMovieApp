//
//  MovieNavigationView.swift
//  SampleMovieApp
//
//  Created by obuke on 12/04/2023.
//

import SwiftUI

struct MovieNavigationView: View {
    var body: some View {
        NavigationView{
            HStack{
                //Spacer()
                // NavigationLink(
                //    destination: NowPlayingView(dependencies: AppDependenciesContainer() as! NowPlayingViewModelDependencies),
                // label: {
                Text("Now Playing")
                //  })
                Spacer()
                NavigationLink(
                    destination: UpcomingMoviesView(),
                    label: {
                        Text("Upcoming")
                    })
                Spacer()
                NavigationLink(
                    destination: TopRatedMoviesView(),
                    label: {
                        Text("Top rated")
                    })
                Spacer()
                NavigationLink(
                    destination: PopularMoviesView(),
                    label: {
                        Text("Popular")
                    })
                
            }
        }
    }
}

struct MovieNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MovieNavigationView()
    }
}
