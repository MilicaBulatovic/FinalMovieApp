//
//  DetailNavigationView.swift
//  SampleMovieApp
//
//  Created by obuke on 23/04/2023.
//

import SwiftUI

struct DetailNavigationView: View {
    let movieDetail: MovieDetailView
    var body: some View {
        
        NavigationView {
            HStack{
                NavigationLink(destination: Text("\(movieDetail.viewModel.movieData?.overview ?? "")")) {
                    Text("About Movie")
                        .bold()
                        .frame(maxWidth: 92, maxHeight: 33)
                }
                NavigationLink(destination: Text("Second View")) {
                    Text("Reviews")
                        .bold()
                        .frame(maxWidth: 92, maxHeight: 33)
                }
                NavigationLink(destination: Text("Third View")) {
                    Text("Cast")
                        .bold()
                        .frame(maxWidth: 92, maxHeight: 33)
                }
            }
        }
    }
}


struct DetailNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNavigationView(movieDetail: MovieDetailView(dependencies: AppDependenciesContainer()))
    }
}
