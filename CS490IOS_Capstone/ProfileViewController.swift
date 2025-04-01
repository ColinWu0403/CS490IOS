//
//  ProfileViewController.swift
//  CS490IOS_Capstone
//
//  Created by Aysu Saglam on 4/1/25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dummy data
        usernameLabel.text = "foodie7"
        profilePicture.image = UIImage(named: "profilePlaceholder")
    }
}
