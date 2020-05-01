//
//  APIError.swift
//  CodingChallenge
//
//  Created by Iustin Bulimar on 01/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import Foundation

enum APIError: Error {
    case generic(description: String)
    case badUrl
    case badParsing
    case noData
    case badResponse
    case badStatusCode(code: Int)
    
    init(error: Error) {
        self = .generic(description: error.localizedDescription)
    }
}
