//
//  APIClient.swift
//  GuessWhat
//
//  Created by Evgenii Kolgin on 08.09.2022.
//

import Foundation

enum NetworkError: Error {
    case badURL(String)
    case networkError(Error)
    case decodingError(Error)
}

class APIClient: NetworkService {
    
    func fetchHint(for answer: String, completion: @escaping (Result<[Response], NetworkError>) -> Void) {
        guard let url = URL(string: Constants.baseURL + answer) else { return completion(.failure(NetworkError.badURL("Something wrong with URL")))}
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            if let data = data {
                do {
                    let results = try JSONDecoder().decode([Response].self, from: data)
                    completion(.success(results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        dataTask.resume()
    }
}
