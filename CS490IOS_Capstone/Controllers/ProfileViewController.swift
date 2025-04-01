//
//  ProfileViewController.swift
//  CS490IOS_Capstone
//
//  Created by Aysu Saglam on 4/1/25.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class ProfileViewController: UIViewController {
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        printReviews()
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


}
