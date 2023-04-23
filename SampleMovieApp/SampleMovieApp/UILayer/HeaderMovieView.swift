//
//  HeaderMovieView.swift
//  SampleMovieApp
//
//  Created by obuke on 12/04/2023.
//

import SwiftUI

struct HeaderMovieView: View {
    var body: some View {
        HStack{
            Text("What do you want to watch?")
                .bold()
                .multilineTextAlignment(.leading)
        }
    }
}

struct HeaderMovieView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderMovieView()
            .preferredColorScheme(.dark)
    }
}
