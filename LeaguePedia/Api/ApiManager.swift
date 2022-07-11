//
//  ApiManager.swift
//  LeaguePedia
//
//  Created by Ivan Voloshchuk on 11/07/22.
//

import Foundation

struct ApiManager{

    func fetchAPI<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping(Result<T,NetworkError>) -> Void) {
        
        guard let url = url else {
            let error = NetworkError.badUrl
            completion(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response as? HTTPURLResponse,!(200...299).contains(response.statusCode) {
                completion(Result.failure(NetworkError.response(statusCode: response.statusCode)))
            } else if let error = error as? URLError {
                completion(Result.failure(NetworkError.urlSession(error)))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(type, from: data)
                    completion(Result.success(result))
                }catch {
                    completion(Result.failure(NetworkError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
}
