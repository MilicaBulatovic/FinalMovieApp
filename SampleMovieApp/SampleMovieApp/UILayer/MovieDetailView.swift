//
//  MovieDetailView.swift
//  SampleMovieApp
//
//  Created by obuke on 10/04/2023.
//

import SwiftUI
import Combine
import SwURL

struct MovieDetailView: View {
    //iz kog posmatram
    @ObservedObject var viewModel: ViewModel
    // @State private var isLoading = false
    
    init(dependencies: MovieDetailViewModelDependencies){
        viewModel = ViewModel(dependencies: dependencies)
        
    }
    var body: some View {
        Group {
            switch viewModel.viewState{
            case .initial:
                SplashScreenView()
                    .onAppear{viewModel.loadMoviesData()}
            case .loading:
                SplashScreenView()
            case . error:
                EmptyWatchlistView()
            case .finished:
                presentationView
            }
        }
    }
    var MovieNavigation: some View{
        
        NavigationView {
            HStack{
                NavigationLink(destination: Text("\(viewModel.movieData?.overview ?? "")")) {
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
    
    var presentationView: some View{
        VStack{
            HStack {
                Image(systemName: "chevron.backward")
                    .frame(maxWidth: 20, maxHeight: 20)
                Spacer()
                Text("Detail")
                    .bold()
                    .frame(maxWidth: 49, maxHeight: 20)
                Spacer()
                Image(systemName: "bookmark.fill")
                    .frame(maxWidth: 18, maxHeight: 24)
                
            }
            .padding(.horizontal)
            ZStack{
                MovieBackdropCard()
                    .frame(maxWidth: 375, maxHeight: 210.94)
                HStack{
                    if let posterUrl = URL(string: "\(viewModel.movieData?.moviePoster ?? viewModel.movieData?.backdropPoster ??  "")") {
                        
                        RemoteImage(url: posterUrl)
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 95, maxHeight: 120)
                    } else {
                        Image(systemName: "film")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 100)
                    }
                    
                    
                }
                .offset(x:-120, y: 100)
                Text("\(viewModel.movieData?.title ?? "" )")
                    .bold()
                    .frame(maxWidth: 210, maxHeight: 48)
                    .offset(x:10, y: 150)
                Text("★\(String(format: "%.1f", viewModel.movieData?.popularity ?? 0))")
                    .offset(x: 155, y:90)
                    .foregroundColor(.orange)
                
            }
            Spacer()
            HStack{
                //AsyncImage(url: URL(string:  "\(viewModel.movieData?.moviePoster ?? backdropPoster ?? "")"))
                //  RemoteImageView(url: URL(string: "\(viewModel.movieData?.moviePoster ?? viewModel.movieData?.)"))
                
                Image(systemName: "calendar")
                    .foregroundColor(.gray)
                Text("\(viewModel.movieData?.releaseDate ?? "")".prefix(4))
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Text("|")
                Image(systemName: "clock")
                    .foregroundColor(.gray)
                Text("\(viewModel.movieData?.runtime ?? 0) Minutes")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                Text("|")
                Image(systemName: "ticket")
                    .foregroundColor(.gray)
                Text("\(viewModel.movieData?.genre ?? "")")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                
            }
            .padding(.horizontal)
            Spacer()
            MovieNavigation
                .frame(width: 300, height: 250, alignment: .leading)
            Spacer()
        }
        .foregroundColor(.white)
        //.navigationBarBackButtonHidden(true)
        //.background(Color(red: 0, green: 0, blue: 0.5).edgesIgnoringSafeArea(.all))
        //Color 1E1E1E
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




struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(dependencies: AppDependenciesContainer())
            .preferredColorScheme(.dark)
    }
}
protocol MovieDetailViewModelDependencies {
    var detailMovieUseCase: DetailMovieUseCase { get }
    
}

extension MovieDetailView {
    final class ViewModel: ObservableObject {
        //obj koji posmatram logicno
        let dependencies: MovieDetailViewModelDependencies
        
        @Published var viewState: ViewState = .initial
        
        @Published var movieData: DetailMovieResponse? = nil
        
        private var subscriptions = Set<AnyCancellable>()
        
        
        
        init(dependencies: MovieDetailViewModelDependencies){
            self.dependencies = dependencies
        }
        
        enum ViewState {
            case initial
            case loading
            case error
            case finished
        }
        
        func loadMoviesData() {
            viewState = .finished
            
            
            dependencies.detailMovieUseCase.fetchMovieDetails(id: movieData?.id ?? 711)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        self.viewState = .error
                    case .finished:
                        self.viewState = .finished
                    }
                    
                }, receiveValue: {
                    movieData in
                    self.movieData = movieData
                }
                )
                .store(in: &subscriptions)
            
        }
    }
}

