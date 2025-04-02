//
//  AddReviewViewController.swift
//  CS490IOS_Capstone
//
//  Created by Aysu Saglam on 4/1/25.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class AddReviewViewController: UIViewController {

    @IBOutlet weak var restaurantSearchBar: UISearchBar!
    @IBOutlet weak var locationSearchBar: UISearchBar!
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Change the second search bar icon to a location marker
        if let locationImage = UIImage(systemName: "mappin.and.ellipse") {
            locationSearchBar.setImage(locationImage, for: .search, state: .normal)
        }
        
        // Move the icon slightly to the right
        restaurantSearchBar.setPositionAdjustment(UIOffset(horizontal: 12, vertical: 0), for: .search)
        locationSearchBar.setPositionAdjustment(UIOffset(horizontal: 12, vertical: 0), for: .search)

        // Adjust text field properties
        if let textField = locationSearchBar.value(forKey: "searchField") as? UITextField {
            textField.leftView?.frame = CGRect(x: 10, y: 0, width: textField.leftView?.frame.width ?? 0, height: textField.leftView?.frame.height ?? 0)
        }

        if let textField = restaurantSearchBar.value(forKey: "searchField") as? UITextField {
            textField.leftView?.frame = CGRect(x: 10, y: 0, width: textField.leftView?.frame.width ?? 0, height: textField.leftView?.frame.height ?? 0)

        }
    }
}
