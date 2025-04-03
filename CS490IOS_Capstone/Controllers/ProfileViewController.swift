//
//  ProfileViewController.swift
//  CS490IOS_Capstone
//
//  Created by Aysu Saglam on 4/1/25.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Style the profile image view
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
        
        username.textAlignment = .center
        username.numberOfLines = 1
        username.adjustsFontSizeToFitWidth = true
        username.minimumScaleFactor = 0.5

        // Add tap gesture recognizer programmatically
        profileImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(promptForImageTapped(_:)))
        profileImage.addGestureRecognizer(tapGesture)
        
        fetchUserProfile()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
    
    @objc func promptForImageTapped(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }

    // Delegate method: called when an image is picked
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        // Prefer the edited image if available; otherwise use the original image
        if let editedImage = info[.editedImage] as? UIImage {
            profileImage.image = editedImage
            uploadImageToFirebase(image: editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImage.image = originalImage
            uploadImageToFirebase(image: originalImage)
        } else {
            print("No image was selected")
        }
    }
    
    // Delegate method: called if the user cancels the picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func uploadImageToFirebase(image: UIImage) {
        let userId = "test"
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        let storageRef = Storage.storage().reference().child("profile_images/\(userId).jpg")
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    return
                }
                
                if let downloadURL = url?.absoluteString {
                    self.updateUserProfileImageURL(downloadURL, userId: userId)
                }
            }
        }
    }
    
    func updateUserProfileImageURL(_ url: String, userId: String) {
        db.collection("Users").document(userId).setData([
            "profileImageURL": url
        ], merge: true) { error in
            if let error = error {
                print("Error updating user profile image URL: \(error.localizedDescription)")
            } else {
                print("Successfully updated profile image URL")
            }
        }
    }

    func fetchUserProfile() {
        let userId = "test"

        db.collection("Users").document(userId).getDocument { document, error in
            if let error = error {
                print("Error fetching user profile: \(error.localizedDescription)")
                return
            }

            guard let document = document, document.exists, let data = document.data() else {
                print("User document does not exist")
                return
            }

            let name = data["name"] as? String ?? "No Name"
            let username = "@" + (data["username"] as? String ?? "unknown_user")
            let profileImageURL = data["profileImageURL"] as? String ?? ""

            DispatchQueue.main.async {
                self.name.text = name
                self.username.text = username
                self.loadImage(from: profileImageURL)
            }
        }
    }

    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profileImage.image = image
                }
            }
        }
    }
}
