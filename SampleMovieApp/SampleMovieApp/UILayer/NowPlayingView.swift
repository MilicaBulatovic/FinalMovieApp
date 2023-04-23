//
//  NowPlayingView.swift
//  SampleMovieApp
//
//  Created by obuke on 10/04/2023.
//

import SwiftUI
import Combine

struct NowPlayingView: View {
    //iz kog posmatram
    @ObservedObject var viewModel1: ViewModel
    
    init(dependencies: NowPlayingViewModelDependencies){
        viewModel1 = ViewModel(dependencies: dependencies)
    }
    var body: some View {
        Group {
            switch viewModel1.viewState{
            case .initial:
                SplashScreenView()
                    .onAppear{viewModel1.loadNowPlayingData()}
            case .loading:
                SplashScreenView()
            case . error:
                EmptyWatchlistView()
            case .finished:
                presentationView
            }
        }
    }
    
    var presentationView: some View{
        VStack{
            HStack {
                Image(systemName: "chevron.backward")
                Spacer()
                Text("Now Playing")
                    .bold()
                
            }
            .padding(.horizontal)
            Spacer()
            HStack{
                
                //AsyncImage(url: URL(string:  "\(viewModel1.nowPlayingData?.moviePoster ?? backdropPoster ?? "")"))
                
                if let posterUrl = URL(string: "\(viewModel1.nowPlayingData[1] )") {
                    
                    RemoteImage(url: posterUrl)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                } else {
                    Image(systemName: "film")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 100)
                }
            }
            
        }
    }
    struct RemoteImage: View {
        let url: URL
        
        @StateObject private var imageLoader = ImageLoader()
        
        var body: some View {
            Image(uiImage: imageLoader.image ?? UIImage(systemName: "film")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onAppear {
                    imageLoader.loadImage(url: url)
                }
        }
    }
    
    class ImageLoader: ObservableObject {
        @Published var image: UIImage?
        
        func loadImage(url: URL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Failed to load image: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    struct nowPlayingCell: View  {
        let data: NowPlayingData
        
        var body: some View {
            HStack{
                Text(data.posterPath ?? data.backdropPoster ?? "kkk")
            }
        }
    }
}


struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView(dependencies: AppDependenciesContainer() as! NowPlayingViewModelDependencies)
    }
}
protocol NowPlayingViewModelDependencies {
    //var detailMovieUseCase: DetailMovieUseCase { get }
    var nowPlayingUseCase: NowPlayingUseCase { get }
}

extension NowPlayingView {
    final class ViewModel: ObservableObject {
        //obj koji posmatram logicno
        let dependencies: NowPlayingViewModelDependencies
        
        @Published var viewState: ViewState = .initial
        
        //@Published var nowPlayingData: DetailMovieResponse? = nil
        @Published var nowPlayingData = [NowPlayingData]()
        private var subscriptions = Set<AnyCancellable>()
        
        
        
        init(dependencies: NowPlayingViewModelDependencies){
            self.dependencies = dependencies
        }
        
        enum ViewState {
            case initial
            case loading
            case error
            case finished
        }
        
        
        
        func loadNowPlayingData() {
            viewState = .finished
            dependencies.nowPlayingUseCase.fetchNowPlayingData()
                .sink { completion in
                    switch completion {
                    case .failure:
                        self.viewState = .error
                    case .finished:
                        self.viewState = .finished
                    }
                } receiveValue: { nowPlayingData in
                    self.nowPlayingData = nowPlayingData
                    self.viewState = .finished
                }
                .store(in: &subscriptions)
        }
        
        
    }
}
