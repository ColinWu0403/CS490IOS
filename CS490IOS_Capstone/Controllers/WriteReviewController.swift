//
//  WriteReviewController.swift
//  CS490IOS_Capstone
//
//  Created by Aysu Saglam on 4/4/25.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class WriteReviewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties/Variables
    
    var restaurant: Restaurant?
    var currentRating: Int = 0
    var isRatingSelected = false
    var isTextEntered = false
    var isPhotoSelected = false
    
    // MARK: Outlets
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet var starButtons: [UIButton]!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var submitReviewButton: UIButton!
    
    // MARK: Firestore and Storage references
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
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
        
        // Button Styling
        uploadButton.layer.cornerRadius = 8

        uploadButton.backgroundColor = UIColor.systemGreen
        uploadButton.setTitleColor(.white, for: .normal)
        uploadButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        uploadButton.layer.shadowColor = UIColor.black.cgColor
        uploadButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        uploadButton.layer.shadowRadius = 4
        uploadButton.layer.shadowOpacity = 0.2
        uploadButton.clipsToBounds = false  // Important to allow shadow to show


        submitReviewButton.layer.cornerRadius = 8

        submitReviewButton.backgroundColor = UIColor.systemGreen
        submitReviewButton.setTitleColor(.white, for: .normal)
        submitReviewButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        submitReviewButton.layer.shadowColor = UIColor.black.cgColor
        submitReviewButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        submitReviewButton.layer.shadowRadius = 4
        submitReviewButton.layer.shadowOpacity = 0.2
        submitReviewButton.clipsToBounds = false  // Important to allow shadow to show

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
        
        // If a photo is selected, upload it then create the review;
        // otherwise, create the review immediately.
        if photoSelected, let image = selectedImage.image {
            uploadImageForReview(image: image) { [weak self] photoURL in
                self?.createReview(photoURL: photoURL)
            }
        } else {
            createReview(photoURL: "")
        }
    }
    
    
    // MARK: Helper functions
    
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
    
    // MARK: - Review Submission Methods
    
    // Upload the selected image to Firebase Storage and return the download URL via a completion handler.
    func uploadImageForReview(image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion("")
            return
        }
        
        // Create a unique identifier for the review image
        let reviewID = UUID().uuidString
        let storageRef = storage.reference().child("reviews/\(reviewID).jpg")
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion("")
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    completion("")
                    return
                }
                
                guard let photoURL = url?.absoluteString else {
                    completion("")
                    return
                }
                completion(photoURL)
            }
        }
    }
    
    // Create the review object and add it to Firestore.
    func createReview(photoURL: String) {
        guard let restaurant = restaurant else { return }
        
        let review = Review(
            restaurantName: restaurant.name,
            cuisine: restaurant.cuisine ?? "Unknown Cuisine",
            location: restaurant.location,
            score: Double(currentRating),
            reviewText: reviewTextView.text,
            photoURL: photoURL
        )
        
        addReview(review)
        print("Review created sucessfully")
    }
    
    // Add the review data to Firestore.
    func addReview(_ review: Review) {
        let reviewData: [String: Any] = [
            "restaurantName": review.restaurantName,
            "cuisine": review.cuisine,
            "location": review.location,
            "score": review.score,
            "reviewText": review.reviewText,
            "photoURL": review.photoURL
        ]
        
        db.collection("Reviews").addDocument(data: reviewData) { error in
            if let error = error {
                print("Error adding review: \(error.localizedDescription)")
            } else {
                print("Review added successfully!")
                // Optionally, dismiss or navigate away after a successful submission.
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
