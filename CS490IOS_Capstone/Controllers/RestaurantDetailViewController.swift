//
//  RestaurantDetailViewController.swift
//  CS490IOS_Capstone
//
//  Created by Aysu Saglam on 4/9/25.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var personalReview: UILabel!
    @IBOutlet weak var scoreLabel: UIStackView!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    
    // Incoming review
    var review: Review?
      
    override func viewDidLoad() {
        super.viewDidLoad()
          
        // Do any additional setup after loading the view.
        setupUI()
    }
      
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
        // Clear all fields immediately
        restaurantNameLabel.text = ""
        cuisineLabel.text = ""
        locationLabel.text = ""
        personalReview.text = ""
        restaurantImageView.image = UIImage(named: "placeholder")
        updateStars(for: 0)
          
        guard let review = review else { return }
          
        // Populate fields with review data
        restaurantNameLabel.text = review.restaurantName
        cuisineLabel.text = review.cuisine
        locationLabel.text = "X Miles Away" // Replace with real distance later
        personalReview.text = review.reviewText
          
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
  }
