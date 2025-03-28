//
//  ViewController.swift
//  CS490IOS_Capstone
//
//  Created by colin wu on 25/03/2025.
//

import UIKit
import FirebaseFirestore

class ViewController: UIViewController {

    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a test review instance
        let testReview = Review(
            restaurantName: "Test Restaurant",
            cuisine: "Italian",
            location: "123 Test Street",
            score: 4.5,
            reviewText: "Great food and service!",
            photoURL: "http://example.com/photo.jpg"
        )
        
        // Call the addReview function with the test review
        addReview(testReview)
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


}

