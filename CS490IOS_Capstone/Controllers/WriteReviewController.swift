//
//  WriteReviewController.swift
//  CS490IOS_Capstone
//
//  Created by Aysu Saglam on 4/4/25.
//

import UIKit

class WriteReviewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Properties/Variables
    
    var restaurant: Restaurant?
    var currentRating: Int = 0
    
    var isRatingSelected = false
    var isTextEntered = false
    var isPhotoSelected = false
    
    // Outlets
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet var starButtons: [UIButton]!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var submitReviewButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI() //UI Set-up
        setupTap() //Tap gesture - for users to indicate they are done writing in the text box
    }
    
    
    func setupUI() {
        // Initializing text, ratings
        restaurantNameLabel.text = restaurant?.name
        updateStarSelection(rating: 0)
        ratingLabel.text = " "
        
        // Review text intialization + formatting stuff
        reviewTextView.delegate = self
        reviewTextView.text = "Write your review here..."
        reviewTextView.textColor = .lightGray
        reviewTextView.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        reviewTextView.layer.borderWidth = 1.0
        reviewTextView.layer.cornerRadius = 8.0
        reviewTextView.clipsToBounds = true
        
        // Submit button becomes available after fields have been completed
        submitReviewButton.isHidden = true
    }
    
    func setupTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @IBAction func starButtonTapped(_ sender: UIButton) {
        guard let index = starButtons.firstIndex(of: sender) else { return }
        currentRating = index + 1
        updateStarSelection(rating: currentRating)
        ratingLabel.text = "Rating: \(currentRating) / 5 Stars"
        
        isRatingSelected = currentRating > 0
        checkIfReadyToSubmit()
    }
    
    @IBAction func uploadButtonTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        guard let restaurant = restaurant else { return }
        
        let restaurantName = restaurant.name
        let cuisine = restaurant.cuisine ?? "Unknown Cuisine"
        let location = restaurant.location
        let score = currentRating
        let reviewText = reviewTextView.text ?? ""
        let photoSelected = selectedImage.image != nil
        
        print("Review Submitted:")
        print("----------------------------")
        print("Restaurant Name: \(restaurantName)")
        print("Cuisine: \(cuisine)")
        print("Location: \(location)")
        print("Score: \(score)/5")
        print("Review Text: \(reviewText)")
        print("Photo Selected: \(photoSelected ? "Yes" : "No")")
        print("----------------------------")
        
        dismiss(animated: true, completion: nil)
    }
    
    
    // Helper functions
    
    // Updates fill of the stars based on which star has been clicked
    func updateStarSelection(rating: Int) {
        for (index, button) in starButtons.enumerated() {
            let imageName = index < rating ? "star.fill" : "star"
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    // Checks if required fields have been completed
    func checkIfReadyToSubmit() {
        if isRatingSelected && isTextEntered {
            submitReviewButton.isHidden = false
        } else {
            submitReviewButton.isHidden = true
        }
    }
    

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
        isTextEntered = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "Write your review here..."
            textView.textColor = .lightGray
            isTextEntered = false
        } else {
            isTextEntered = true
        }
        checkIfReadyToSubmit()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        isTextEntered = !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        checkIfReadyToSubmit()
    }
    
    // UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage.image = originalImage
        }
        
        isPhotoSelected = selectedImage.image != nil
        checkIfReadyToSubmit()
    }
    

}
