//
//  GooglePlacesServices.swift
//  CS490IOS_Capstone
//
//  Created by Dhruv Srivastava on 4/15/25.
//

import Foundation
import CoreLocation

class GooglePlacesServices {
    private let apiKey = AppConfig.shared.googlePlacesAPIKey
    
    /// Fetches nearby restaurants and maps them to `Review` objects to be used in ListViewController
    func fetchNearbyRestaurantsAsReviews(
        location: CLLocationCoordinate2D,
        radius: Int = 5000,
        completion: @escaping ([Review]) -> Void
    ) {
        let urlString = """
        https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(location.latitude),\(location.longitude)&radius=\(radius)&type=restaurant&key=\(apiKey)
        """
        
        guard let url = URL(string: urlString) else {
            print("Invalid Google Places URL")
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Google Places fetch error: \(error)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("No data from Places API")
                completion([])
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let results = json["results"] as? [[String: Any]] {
                    
                    let reviews: [Review] = results.compactMap { place in
                        guard
                            let name = place["name"] as? String,
                            let vicinity = place["vicinity"] as? String,
                            let rating = place["rating"] as? Double
                        else {
                            return nil
                        }
                        
                        let types = place["types"] as? [String]
                        let cuisine = types?.first?.capitalized ?? "Unknown"
                        
                        // Build photo URL if photo_reference exists
                        var photoURL: String = ""
                        if let photos = place["photos"] as? [[String: Any]],
                           let photoRef = photos.first?["photo_reference"] as? String {
                            photoURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(photoRef)&key=\(self.apiKey)"
                        }
                        
                        return Review(
                            restaurantName: name,
                            cuisine: cuisine,
                            location: vicinity,
                            score: rating,
                            reviewText: "⭐️ Rated \(rating) on Google", // Placeholder
                            photoURL: photoURL
                        )
                    }
                    
                    completion(reviews)
                    
                } else {
                    print("Failed to parse Places JSON")
                    completion([])
                }
            } catch {
                print("JSON decoding error: \(error)")
                completion([])
            }
        }.resume()
    }
}

