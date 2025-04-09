//
//  ListViewController.swift
//  CS490IOS_Capstone
//
//  Created by Aysu Saglam on 4/1/25.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Outlets
    @IBOutlet weak var reviewTableView: UITableView!
    
    // Properties/Variables
    var reviews: [Review] = []
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        reviewTableView.delegate = self
        reviewTableView.dataSource = self
                
        fetchReviews()
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
    
    func fetchReviews() {
            db.collection("Reviews").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching reviews: \(error)")
                return
            }
                
            guard let documents = snapshot?.documents else { return }
            
            var fetchedReviews = [Review]()
                
            for doc in documents {
                do {
                    let review = try doc.data(as: Review.self)
                    fetchedReviews.append(review)
                } catch {
                    print("Error decoding review: \(error)")
                }
            }
                
            self.reviews = fetchedReviews
            DispatchQueue.main.async {
                self.reviewTableView.reloadData()
            }
        }
    }
    
    // TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as? ReviewCell else {
                    fatalError("Error")
        }
                
        let review = reviews[indexPath.row]
            
        // Populate cell fields
        cell.restaurantNameLabel.text = review.restaurantName
        cell.cuisineLabel.text = review.cuisine
        cell.locationLabel.text = review.location
        cell.scoreLabel.text = String(format: "%.1f", review.score)
                
        return cell
    }
    
    var selectedReview: Review?

    // User tapped a cell - bring up Restaurant Detail
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedReview = reviews[indexPath.row]
        performSegue(withIdentifier: "showRestaurantDetail", sender: self)
    }
    
    // Preparing review information for new view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? RestaurantDetailViewController {
            destinationVC.review = selectedReview
        }
        
    }
    
    

}
