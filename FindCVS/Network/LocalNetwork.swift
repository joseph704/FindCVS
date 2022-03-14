//
//  LocalNetwork.swift
//  FindCVS
//
//  Created by Joseph Cha on 2022/03/14.
//

import RxSwift

class LocalNetwork {
    private let session: URLSession
    let api = LocalAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getLocation(by mapPoint: MTMapPoint) -> Single<Result<LocationData, URLError>> {
        guard let url = api.getLocation(by: mapPoint).url else {
            return .just(.failure(URLError(.badURL)))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        // httpHeader로 명시되어야함
        request.setValue("KakaoAK 9d8eace7171d1ae36aac2935c16e8ce2", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let locationData = try JSONDecoder().decode(LocationData.self, from: data)
                    return .success(locationData)
                } catch {
                    return .failure(URLError(.cannotParseResponse))
                }
            }
            .catch { _ in .just(Result.failure(URLError(.cannotLoadFromNetwork)))}
            .asSingle()
    }
}
