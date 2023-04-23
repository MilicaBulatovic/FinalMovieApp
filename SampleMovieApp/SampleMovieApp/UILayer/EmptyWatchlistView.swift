//
//  EmptyWatchlistView.swift
//  SampleMovieApp
//
//  Created by obuke on 12/04/2023.
//

import SwiftUI

struct EmptyWatchlistView: View {
    var body: some View {
        VStack{
            Image("emptybox")
            
            Text("There Is No Movie Yet!")
                .font(.title3)
            Text("Find your movie by Type title, categories,years, etc.")
                .font(.footnote)
            
        }
        
    }
}

struct EmptyWatchlistView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyWatchlistView()
        
    }
}
