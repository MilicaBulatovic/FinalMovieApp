//
//  SplashScreenView.swift
//  SampleMovieApp
//
//  Created by obuke on 12/04/2023.
//
import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        Image("popcorn")
            .resizable()
            .frame(width: 139.0, height: 139.0)
            .scaledToFit()
    }
    //fullScreenCover implementirati
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
            .preferredColorScheme(.dark)
    }
}

