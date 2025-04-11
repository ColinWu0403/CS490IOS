//
//  AppConfig.swift
//  CS490IOS_Capstone
//
//  Created by Dhruv Srivastava on 4/15/25.
//

import Foundation

class AppConfig {
    static let shared = AppConfig()
    let googlePlacesAPIKey: String

    private init() {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_PLACES_API_KEY") as? String else {
            fatalError("❌ GOOGLE_PLACES_API_KEY is missing from Info.plist")
        }
        googlePlacesAPIKey = key
    }
}
