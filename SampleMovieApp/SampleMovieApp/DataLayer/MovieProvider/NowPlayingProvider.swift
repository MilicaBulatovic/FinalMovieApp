//
//  NowPlayingProvider.swift
//  SampleMovieApp
//
//  Created by obuke on 13/04/2023.
//

import Foundation
import Combine

final class NowPlayingProvider: NowPlayingUseCase {
    
    let webService: WebService
    
    init(webService: WebService){
        self.webService = webService
    }
    
    
    func fetchNowPlayingData() -> AnyPublisher<[NowPlayingData], Error> {
        
        let request = APIRequest(endpoint: .nowPlaying)
        
        guard let urlRequest =  try? request.getURLRequest() else {
            return Fail(error: URLError.urlMalformed)
                .eraseToAnyPublisher()
        }
        return Just(urlRequest)
            .flatMap { request -> AnyPublisher<NowPlayingDTO, Error> in
                self.webService.execute(request)
            }
            .map { dto in
                dto.entity
            }
            .eraseToAnyPublisher()
        
    }
}

fileprivate  struct NowPlayingDTO: Decodable {
    let results : [NowPlayingDataDTO]
    
    var entity: [NowPlayingData] {
        results.map { dto in
            NowPlayingData(
                id: dto.id,
                posterPath : dto.posterPath ?? "",
                backdropPoster: dto.backdropPoster ?? ""
                //genre : dto.first?.genre ?? 0
            )
        }
    }
    
    
    struct NowPlayingDataDTO: Decodable {
        let id : Int
        let posterPath : String?
        let backdropPoster: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case posterPath = "poster_path"
            case backdropPoster = "backdrop_path"
            //case genre = "genre_ids"
            
        }
    }
}


