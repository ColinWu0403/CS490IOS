//
//  Review.swift
//  CS490IOS_Capstone
//
//  Created by colin wu on 28/03/2025.
//

import Foundation

struct Review: Codable {
    var restaurantName: String
    var cuisine: String
    var location: String
    var score: Double
    var reviewText: String
    var photoURL: String
}
