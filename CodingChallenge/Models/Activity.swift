//
//  Activity.swift
//  CodingChallenge
//
//  Created by Iustin Bulimar on 01/05/2020.
//  Copyright © 2020 Iustin Bulimar. All rights reserved.
//

import Foundation

struct Activity: Codable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}

