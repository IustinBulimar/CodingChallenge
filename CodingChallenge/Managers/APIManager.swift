//
//  APIManager.swift
//  CodingChallenge
//
//  Created by Iustin Bulimar on 01/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import Foundation

struct APIManager {
    
    var baseUrl = "https://jsonplaceholder.typicode.com"
    
    func getActivities(completion: @escaping (Result<[Activity], APIError>) -> Void) {
        guard let url = URL(string: baseUrl + "/todos") else {
            completion(.failure(.badUrl))
            return
        }
        
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil else {
                    completion(.failure(.init(error: error!)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.badResponse))
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.badStatusCode(code: httpResponse.statusCode)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let quotes = try JSONDecoder().decode([Activity].self, from: data)
                    completion(.success(quotes))
                    return
                    
                } catch {
                    completion(.failure(.badParsing))
                    return
                }
                
            }.resume()
        }
        
    }
    
}
