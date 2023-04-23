//
//  MovieProvider.swift
//  SampleMovieApp
//
//  Created by obuke on 12/04/2023.
//

import Foundation
import Combine

final class MovieProvider: DetailMovieUseCase {
    let webService: WebService
    
    init(webService: WebService){
        self.webService = webService
    }
    func fetchMovieDetails(id: Int) -> AnyPublisher<DetailMovieResponse, Error> {
        let request = APIRequest(endpoint: .movieDetails(id))
        
        guard let urlRequest =  try? request.getURLRequest() else {
            return Fail(error: URLError.urlMalformed)
                .eraseToAnyPublisher()
        }
        return Just(urlRequest)
            .flatMap { request -> AnyPublisher<MovieDetailDTO, Error> in
                self.webService.execute(request)
            }
            .map { dto in
                dto.detailMovieResponse
            }
            .eraseToAnyPublisher()
        
    }
}

struct MovieDetailDTO: Decodable,Identifiable {
    let id: Int
    let title: String
    let moviePoster : String?
    let backdropPoster: String?
    let overview: String
    let voteAverage : Double
    let voteCount: Int
    let popularity: Double
    let releaseDate: String
    let runtime : Int?
    
    let genre: [GenreDTO]
    
    var posterUrl: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(moviePoster ?? backdropPoster ?? "")")!
    }
    var voteAveragePercent: String {
        return "\(Int(voteAverage * 10))% "
    }
    
    // let moviePosterUrl: URL {
    //    return URL(string: "https://image.tmdb.org/t/pw500\(moviePoster ?? backdropPoster ?? "")")!
    
    // }
    
    
    enum CodingKeys: String, CodingKey {
        case id, popularity, runtime, overview
        case moviePoster = "poster_path"
        case backdropPoster = "backdrop_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case title = "original_title"
        case releaseDate = "release_date"
        case genre = "genres"
        
    }
    
    var detailMovieResponse: DetailMovieResponse {
        DetailMovieResponse(id: id,
                            title: title,
                            moviePoster: moviePoster ?? backdropPoster ?? "",
                            backdropPoster: backdropPoster ?? "" ,
                            overview: overview,
                            voteAverage: voteAverage,
                            voteCount: voteCount,
                            popularity: popularity,
                            releaseDate: releaseDate,
                            runtime: runtime ?? 0,
                            genre: genre.first?.name ?? ""
        )
    }
    
    struct GenreDTO: Decodable {
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case name
        }
    }
    
}




