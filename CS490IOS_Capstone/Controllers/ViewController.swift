//
//  ViewController.swift
//  CS490IOS_Capstone
//
//  Created by colin wu on 25/03/2025.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class ViewController: UIViewController {

    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        printReviews()
        print("Aasjkafjhgakhgklsadhgkjadj aljkgsghakgklafdkgkjads")
        super.viewDidLoad()
        seedReviewsFromSampleData()
        

        
        // Create a test review instance
//        let testReview = Review(
//            restaurantName: "Hillenbrand Dining Court",
//            cuisine: "Mid food",
//            location: "West Lafayette, IN",
//            score: 2.3,
//            reviewText: "I got food poisoninig there once",
//            photoURL: "https://en.wikipedia.org/wiki/File:Image_created_with_a_mobile_phone.png"
//        )
//        
//        // Call the addReview function with the test review
//        addReview(testReview)
    }

    
    func addReview(_ review: Review) {
        var ref: DocumentReference? = nil
        ref = db.collection("Reviews").addDocument(data: [
            "restaurantName": review.restaurantName,
            "cuisine": review.cuisine,
            "location": review.location,
            "score": review.score,
            "reviewText": review.reviewText,
            "photoURL": review.photoURL
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }

    func printReviews() {
        // Fetch the Reviews collection and print the contents
        db.collection("Reviews").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            for document in snapshot!.documents {
                do {
                    let data = document.data()
                    let review = try Firestore.Decoder().decode(Review.self, from: data)
                    print("Restaurant Name: \(review.restaurantName)")
                    print("Cuisine: \(review.cuisine)")
                    print("Location: \(review.location)")
                    print("Score: \(review.score)")
                    print("Review Text: \(review.reviewText)")
                    print("Photo URL: \(review.photoURL)")
                } catch {
                    print("Error decoding document: \(error)")
                }
            }
        }
    }
    
    func seedReviewsFromSampleData() {
        let db = Firestore.firestore()
        
        for restaurant in Restaurant.sampleData {
            let review = Review(
                restaurantName: restaurant.name,
                cuisine: restaurant.cuisine ?? "Unknown",
                location: restaurant.location,
                score: Double.random(in: 3.5...5.0),
                reviewText: "Great experience at \(restaurant.name)!",
                photoURL: "https://en.wikipedia.org/wiki/File:Image_created_with_a_mobile_phone.png" // placeholder image
            )
            
            let reviewData: [String: Any] = [
                "restaurantName": review.restaurantName,
                "cuisine": review.cuisine,
                "location": review.location,
                "score": review.score,
                "reviewText": review.reviewText,
                "photoURL": review.photoURL
            ]
            
            db.collection("Reviews").addDocument(data: reviewData)
        }

        print("🔥 Sample reviews seeded to Firestore")
    }


}

