//
//  SearchMoviesView.swift
//  SampleMovieApp
//
//  Created by obuke on 12/04/2023.
//

import SwiftUI

struct SearchMoviesView: View {
    var body: some View {
        VStack{
            HStack(alignment: .top){
                
                Image(systemName: "chevron.backward")
                Spacer()
                Text("Search")
                    .bold()
                Spacer()
                Image(systemName: "exclamationmark.circle")
                
            }
            .padding(.horizontal)
            // Spacer()
            HStack{
                SearchBarView()
            }
            .padding(.horizontal)
            Spacer()
        }
    }
}

struct SearchMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchMoviesView()
    }
}
