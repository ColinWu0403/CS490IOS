//
//  AddReviewViewController.swift
//  CS490IOS_Capstone
//
//  Created by Aysu Saglam on 4/1/25.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class AddReviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var restaurantSearchBar: UISearchBar!
    @IBOutlet weak var locationSearchBar: UISearchBar!
    
    let db = Firestore.firestore()
    var restaurantResults: [Restaurant] = []
    var filteredRestaurants: [Restaurant] = []
    var isFiltering: Bool = false

    
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
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        
        restaurantSearchBar.delegate = self
        locationSearchBar.delegate = self
        
        // Row height dimension
        resultsTableView.rowHeight = 70
        
        // Currently loading in all sample data at once
        restaurantResults = Restaurant.sampleData
        resultsTableView.reloadData()
    }
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredRestaurants.count : restaurantResults.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as? RestaurantTableViewCell else {
            fatalError("ERROR")
        }
        
        let restaurant = isFiltering ? filteredRestaurants[indexPath.row] : restaurantResults[indexPath.row]

        cell.nameLabel.text = restaurant.name
        cell.locationLabel.text = restaurant.location
        
        // Associating each "+" button with its cell/restaurant
        cell.addButton.tag = indexPath.row
        
        return cell
    }
    
    // When button is tapped - WriteReviewController will come up
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWriteReview" {
            if let destinationVC = segue.destination as? WriteReviewController,
               let button = sender as? UIButton {
                // Previously assigned tag to ID restaurant
                let selectedRestaurant = isFiltering ? filteredRestaurants[button.tag] : restaurantResults[button.tag]
                destinationVC.restaurant = selectedRestaurant
            }
        }
    }
    
    func filterRestaurants() {
        let nameQuery = restaurantSearchBar.text?.lowercased() ?? ""
        let locationQuery = locationSearchBar.text?.lowercased() ?? ""
        
        if nameQuery.isEmpty && locationQuery.isEmpty {
            isFiltering = false
            filteredRestaurants = []
        } else {
            isFiltering = true
            filteredRestaurants = Restaurant.sampleData.filter { restaurant in
                let matchesName = restaurant.name.lowercased().contains(nameQuery)
                let matchesLocation = restaurant.location.lowercased().contains(locationQuery)
                return matchesName || matchesLocation
            }
        }
        
        resultsTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterRestaurants()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }


}
