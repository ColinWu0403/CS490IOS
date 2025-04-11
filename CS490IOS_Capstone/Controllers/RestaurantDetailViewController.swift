//
//  RestaurantDetailViewController.swift
//  CS490IOS_Capstone
//
//  Created by Aysu Saglam on 4/9/25.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Outlets
    @IBOutlet weak var scoreLabel: UIStackView!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    
    // Selected review from ListViewController
    var review: Review?
    var googleReviews: [GoogleReview] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        reviewsCollectionView.delegate = self
        reviewsCollectionView.dataSource = self
        setupDummyReviews()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 187, height: 187)
    }
    
    // Function to fill stars based on review - currently only handles integer value
    // If needed - I can add semi filling for stars
    func updateStars(for rating: Double) {
        let fullStar = UIImage(systemName: "star.fill")
        let emptyStar = UIImage(systemName: "star")
          
        for (index, starView) in scoreLabel.arrangedSubviews.enumerated() {
            if let star = starView as? UIImageView {
                if Double(index) < rating {
                    star.image = fullStar
                } else {
                    star.image = emptyStar
                }
            }
        }
    }
      
    func setupUI() {
        guard let review = review else { return }
          
        // Populate fields with review data
        restaurantNameLabel.text = review.restaurantName
        cuisineLabel.text = review.cuisine
        locationLabel.text = "X Miles Away" // TODO: Replace with real distance later
          
        updateStars(for: review.score)
          
        // Load restaurant image asynchronously
        if let url = URL(string: review.photoURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url),
                    let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.restaurantImageView.image = image
                    }
                }
            }
        }
    }
    
    
    // UI COLLECTION VIEW FUNCS
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // current mock data
        return googleReviews.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoogleReviewCell", for: indexPath) as? GoogleReviewCell else {
            fatalError("Could not dequeue GoogleReviewCell")
        }
        
        let review = googleReviews[indexPath.item]
        
        // Populating cell fields
        cell.authorNameLabel.text = review.authorName
        cell.ratingLabel.text = String(format: "%.1f", review.rating)
        cell.reviewTextLabel.text = review.text
        
        return cell
    }
    
    // SET UP FOR MOCK GOOGLE REVIEWS
    struct GoogleReview {
        let authorName: String
        let rating: Double
        let text: String
    }
    
    func setupDummyReviews() {
        googleReviews = [
            GoogleReview(authorName: "Aysu S.", rating: 4.5, text: "Amazing service and delicious food!."),
            GoogleReview(authorName: "Asu S.", rating: 4.0, text: "Great atmosphere, good food, but a little pricey."),
            GoogleReview(authorName: "Ays S.", rating: 5.0, text: "Absolutely loved it! Will definitely come back."),
            GoogleReview(authorName: "Ysu S.", rating: 3.5, text: "Food was okay, service could be better."),
            GoogleReview(authorName: "Ayu S.", rating: 4.8, text: "Best dining experience I’ve had in a while!")
        ]
        
        reviewsCollectionView.reloadData()
    }
  }
