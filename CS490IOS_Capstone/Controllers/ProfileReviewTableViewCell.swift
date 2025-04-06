//
//  ProfileReviewTableViewCell.swift
//  CS490IOS_Capstone
//
//  Created by colin wu on 06/04/2025.
//

import Foundation
import UIKit

class ProfileReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var reviewText: UILabel!
    @IBOutlet weak var reviewImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
