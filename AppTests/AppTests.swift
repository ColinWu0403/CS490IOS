//
//  AppTests.swift
//  AppTests
//
//  Created by colin wu on 28/03/2025.
//

import XCTest
@testable import CS490IOS_Capstone
import FirebaseFirestore
import Firebase

class AppTests: XCTestCase {
    var db: Firestore!

    override func setUp() {
        super.setUp()
//        FirebaseApp.configure()
        db = Firestore.firestore()
    }

    func testAddReview() {
        let expectation = self.expectation(description: "AddReview")

        let reviewData: [String: Any] = [
            "restaurantName": "Test Restaurant",
            "cuisine": "Test Cuisine",
            "location": "Test Location",
            "score": 9.3,
            "reviewText": "Excellent!",
            "photoURL": "https://en.wikipedia.org/wiki/File:Image_created_with_a_mobile_phone.png"
        ]

        db.collection("Reviews").addDocument(data: reviewData) { error in
            XCTAssertNil(error, "Error adding document: \(error?.localizedDescription ?? "")")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}

