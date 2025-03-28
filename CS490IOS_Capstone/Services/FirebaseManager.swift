//
//  FirebaseManager.swift
//  CS490IOS_Capstone
//
//  Created by colin wu on 28/03/2025.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseFirestore
import Firebase

class FirebaseManager {
    static let shared = FirebaseManager()
    let firestore = Firestore.firestore()
    let storage = Storage.storage()

    private init() {
    }

    func uploadImage(_ image: UIImage, completion: @escaping (String?) -> Void) {
        let imageID = UUID().uuidString
        let storageRef = storage.reference().child("review_images/\(imageID).jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(nil)
            return
        }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageRef.putData(imageData, metadata: metadata) { (_, error) in
            if let error = error {
                print("Upload error: \(error.localizedDescription)")
                completion(nil)
            } else {
                storageRef.downloadURL { (url, error) in
                    if let url = url {
                        completion(url.absoluteString)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    }

    func createReview(reviewData: [String: Any], completion: ((Error?) -> Void)? = nil) {
        firestore.collection("Reviews").addDocument(data: reviewData) { error in
            if let error = error {
                print("Error adding review: \(error.localizedDescription)")
            } else {
                print("Review successfully added!")
            }
            completion?(error)
        }
    }
}
