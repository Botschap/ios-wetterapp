//
//  ApiClient.swift
//  ios-wetterapp
//
//  Created by admin on 11.01.24.
//

import Foundation

class APIClient {
    
    static func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                let errorDescription = "Unexpected status code: \(statusCode)"
                let error = NSError(domain: "HTTP", code: statusCode, userInfo: [NSLocalizedDescriptionKey: errorDescription])
                completion(.failure(error))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
}
