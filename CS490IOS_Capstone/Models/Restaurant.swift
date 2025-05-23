//
//  Restaurant.swift
//  CS490IOS_Capstone
//
//  Created by Aysu Saglam on 4/4/25.
//

import Foundation

struct Restaurant {
    let name: String
    let location: String
    let cuisine: String?
    let imageName: String?  // Optional image

    // sample data
    static let sampleData: [Restaurant] = [
            Restaurant(name: "Triple XXX Family Restaurant", location: "West Lafayette, IN", cuisine: "American", imageName: "triple_xxx"),
                Restaurant(name: "Maru Sushi", location: "West Lafayette, IN", cuisine: "Japanese", imageName: "maru_sushi"),
                Restaurant(name: "Fiesta Mexican Grill", location: "West Lafayette, IN", cuisine: "Mexican", imageName: "fiesta_mexican"),
                Restaurant(name: "La Scala Italian Restaurant", location: "Lafayette, IN", cuisine: "Italian", imageName: "la_scala"),
                Restaurant(name: "Taste of India", location: "West Lafayette, IN", cuisine: "Indian", imageName: "taste_of_india"),
                Restaurant(name: "Nine Irish Brothers", location: "West Lafayette, IN", cuisine: "Irish Pub", imageName: "nine_irish"),
                Restaurant(name: "Sichuan House", location: "Lafayette, IN", cuisine: "Chinese", imageName: "sichuan_house"),
                Restaurant(name: "Reveille Coffee Bar", location: "West Lafayette, IN", cuisine: "Cafe", imageName: "reveille_coffee"),
                Restaurant(name: "Bru Burger Bar", location: "Indianapolis, IN", cuisine: "Burgers", imageName: "bru_burger"),
                Restaurant(name: "Poké Hibachi", location: "West Lafayette, IN", cuisine: "Hawaiian", imageName: "poke_hibachi"),
                Restaurant(name: "Sharma’s Kitchen", location: "Lafayette, IN", cuisine: "Indian", imageName: "sharmas_kitchen"),
                Restaurant(name: "Egyptian Cafe and Hookah Bar", location: "West Lafayette, IN", cuisine: "Middle Eastern", imageName: "egyptian_cafe"),
                Restaurant(name: "Taco Rico", location: "West Lafayette, IN", cuisine: "Mexican", imageName: "taco_rico"),
                Restaurant(name: "The Whittaker Inn", location: "West Lafayette, IN", cuisine: "American Fine Dining", imageName: "whittaker_inn"),
                Restaurant(name: "Pizza Uncommon", location: "Lafayette, IN", cuisine: "Pizza", imageName: "pizza_uncommon"),
                Restaurant(name: "Green Leaf Vietnamese Cuisine", location: "West Lafayette, IN", cuisine: "Vietnamese", imageName: "green_leaf"),
                Restaurant(name: "Sushi Don", location: "West Lafayette, IN", cuisine: "Sushi", imageName: "sushi_don"),
                Restaurant(name: "The Bryant Food & Drink Co.", location: "Lafayette, IN", cuisine: "American", imageName: "bryant_food_drink"),
                Restaurant(name: "Red Seven", location: "Lafayette, IN", cuisine: "American", imageName: "red_seven"),
                Restaurant(name: "Folie", location: "West Lafayette, IN", cuisine: "French", imageName: "folie"),
                Restaurant(name: "Blue Cafe", location: "Chicago, IL", cuisine: "Pizza", imageName: "blue_cafe"),
                Restaurant(name: "Rustic Cafe", location: "San Francisco, CA", cuisine: "Vietnamese", imageName: "rustic_cafe"),
                Restaurant(name: "Magic Place", location: "Los Angeles, CA", cuisine: "Vegan", imageName: "magic_place"),
                Restaurant(name: "Rustic Fork", location: "San Francisco, CA", cuisine: "Seafood", imageName: "rustic_fork"),
                Restaurant(name: "Happy Grill", location: "Miami, FL", cuisine: "Latin American", imageName: "happy_grill"),
                Restaurant(name: "Golden Table", location: "Portland, OR", cuisine: "Thai", imageName: "golden_table"),
                Restaurant(name: "Golden Fork", location: "New York, NY", cuisine: "French", imageName: "golden_fork"),
                Restaurant(name: "Little House", location: "Seattle, WA", cuisine: "Coffee", imageName: "little_house"),
                Restaurant(name: "Big Place", location: "Austin, TX", cuisine: "Indian", imageName: "big_place"),
                Restaurant(name: "Happy Garden", location: "Seattle, WA", cuisine: "Seafood", imageName: "happy_garden"),
                Restaurant(name: "Magic Kitchen", location: "San Francisco, CA", cuisine: "Chinese", imageName: "magic_kitchen"),
                Restaurant(name: "Lucky Fork", location: "Denver, CO", cuisine: "Vegan", imageName: "lucky_fork"),
                Restaurant(name: "Urban Table", location: "Boston, MA", cuisine: "Japanese", imageName: "urban_table"),
                Restaurant(name: "Blue Kitchen", location: "Miami, FL", cuisine: "Colombian", imageName: "blue_kitchen"),
                Restaurant(name: "Spicy Bar", location: "Denver, CO", cuisine: "Mexican", imageName: "spicy_bar"),
                Restaurant(name: "Magic Garden", location: "San Francisco, CA", cuisine: "Italian", imageName: "magic_garden"),
                Restaurant(name: "Rustic Bar", location: "New York, NY", cuisine: "Italian", imageName: "rustic_bar"),
                Restaurant(name: "Urban Garden", location: "Los Angeles, CA", cuisine: "Korean", imageName: "urban_garden"),
                Restaurant(name: "Big Fork", location: "Chicago, IL", cuisine: "Steakhouse", imageName: "big_fork"),
                Restaurant(name: "Happy Place", location: "Seattle, WA", cuisine: "Japanese", imageName: "happy_place"),
                Restaurant(name: "Blue House", location: "Austin, TX", cuisine: "Tex-Mex", imageName: "blue_house"),
                Restaurant(name: "Rustic Grill", location: "Chicago, IL", cuisine: "Polish", imageName: "rustic_grill"),
                Restaurant(name: "Golden Bistro", location: "Miami, FL", cuisine: "Cuban", imageName: "golden_bistro"),
                Restaurant(name: "Big Garden", location: "Portland, OR", cuisine: "Vegan", imageName: "big_garden"),
                Restaurant(name: "Happy Table", location: "Boston, MA", cuisine: "Italian", imageName: "happy_table"),
                Restaurant(name: "Magic Cafe", location: "New York, NY", cuisine: "Indian", imageName: "magic_cafe"),
                Restaurant(name: "Spicy Grill", location: "Denver, CO", cuisine: "American", imageName: "spicy_grill"),
                Restaurant(name: "Urban Place", location: "San Francisco, CA", cuisine: "French", imageName: "urban_place"),
                Restaurant(name: "Rustic Kitchen", location: "Los Angeles, CA", cuisine: "Sushi", imageName: "rustic_kitchen"),
                Restaurant(name: "Golden Grill", location: "Austin, TX", cuisine: "BBQ", imageName: "golden_grill"),
                Restaurant(name: "Little Garden", location: "Seattle, WA", cuisine: "Vietnamese", imageName: "little_garden"),
                Restaurant(name: "Spicy Fork", location: "Chicago, IL", cuisine: "Mexican", imageName: "spicy_fork"),
                Restaurant(name: "Magic Bar", location: "Miami, FL", cuisine: "Seafood", imageName: "magic_bar"),
                Restaurant(name: "Happy Bistro", location: "Boston, MA", cuisine: "Irish Pub", imageName: "happy_bistro"),
                Restaurant(name: "Golden Place", location: "Portland, OR", cuisine: "Coffee", imageName: "golden_place"),
                Restaurant(name: "Rustic Table", location: "San Francisco, CA", cuisine: "Chinese", imageName: "rustic_table"),
                Restaurant(name: "Lucky Grill", location: "Austin, TX", cuisine: "American", imageName: "lucky_grill"),
                Restaurant(name: "Magic Fork", location: "Chicago, IL", cuisine: "Pizza", imageName: "magic_fork"),
                Restaurant(name: "Big Bar", location: "New York, NY", cuisine: "Greek", imageName: "big_bar"),
                Restaurant(name: "Spicy House", location: "Boston, MA", cuisine: "Seafood", imageName: "spicy_house"),
                Restaurant(name: "Urban Kitchen", location: "Los Angeles, CA", cuisine: "Vegan", imageName: "urban_kitchen"),
                Restaurant(name: "Golden Cafe", location: "San Francisco, CA", cuisine: "Vietnamese", imageName: "golden_cafe"),
                Restaurant(name: "Blue Table", location: "Denver, CO", cuisine: "Pizza", imageName: "blue_table"),
                Restaurant(name: "Happy Fork", location: "Miami, FL", cuisine: "Seafood", imageName: "happy_fork"),
                Restaurant(name: "Little Place", location: "New York, NY", cuisine: "American", imageName: "little_place"),
                Restaurant(name: "Urban Bar", location: "Austin, TX", cuisine: "Tex-Mex", imageName: "urban_bar"),
                Restaurant(name: "Lucky Table", location: "Chicago, IL", cuisine: "Burgers", imageName: "lucky_table"),
                Restaurant(name: "Golden House", location: "Portland, OR", cuisine: "Seafood", imageName: "golden_house"),
                Restaurant(name: "Rustic Bistro", location: "Boston, MA", cuisine: "Irish Pub", imageName: "rustic_bistro"),
                Restaurant(name: "Magic Table", location: "San Francisco, CA", cuisine: "French", imageName: "magic_table"),
                Restaurant(name: "Spicy Cafe", location: "Seattle, WA", cuisine: "Vietnamese", imageName: "spicy_cafe"),
                Restaurant(name: "Big Cafe", location: "Miami, FL", cuisine: "Colombian", imageName: "big_cafe"),
                Restaurant(name: "Urban Bistro", location: "Los Angeles, CA", cuisine: "Mexican", imageName: "urban_bistro"),
                Restaurant(name: "Lucky Garden", location: "Denver, CO", cuisine: "Steakhouse", imageName: "lucky_garden"),
                Restaurant(name: "Blue Bar", location: "New York, NY", cuisine: "Japanese", imageName: "blue_bar"),
                Restaurant(name: "Golden Garden", location: "Chicago, IL", cuisine: "Italian", imageName: "golden_garden"),
                Restaurant(name: "Happy Kitchen", location: "Boston, MA", cuisine: "Seafood", imageName: "happy_kitchen"),
                Restaurant(name: "Magic Grill", location: "Seattle, WA", cuisine: "Thai", imageName: "magic_grill"),
                Restaurant(name: "Rustic House", location: "Portland, OR", cuisine: "Coffee", imageName: "rustic_house"),
                Restaurant(name: "Spicy Bistro", location: "Austin, TX", cuisine: "BBQ", imageName: "spicy_bistro"),
                Restaurant(name: "Big Table", location: "San Francisco, CA", cuisine: "Italian", imageName: "big_table"),
                Restaurant(name: "Blue Garden", location: "Denver, CO", cuisine: "Pizza", imageName: "blue_garden"),
                Restaurant(name: "Happy Bar", location: "Miami, FL", cuisine: "Latin American", imageName: "happy_bar"),
                Restaurant(name: "Urban Fork", location: "New York, NY", cuisine: "Greek", imageName: "urban_fork"),
                Restaurant(name: "Golden Cafe", location: "Los Angeles, CA", cuisine: "Korean", imageName: "golden_cafe"),
                Restaurant(name: "Rustic Place", location: "Boston, MA", cuisine: "Japanese", imageName: "rustic_place"),
                Restaurant(name: "Lucky Bistro", location: "Chicago, IL", cuisine: "Steakhouse", imageName: "lucky_bistro"),
                Restaurant(name: "Magic House", location: "Seattle, WA", cuisine: "Coffee", imageName: "magic_house"),
                Restaurant(name: "Spicy Place", location: "Portland, OR", cuisine: "Thai", imageName: "spicy_place"),
                Restaurant(name: "Big Grill", location: "Austin, TX", cuisine: "BBQ", imageName: "big_grill"),
                Restaurant(name: "Blue Bistro", location: "Denver, CO", cuisine: "Mexican", imageName: "blue_bistro"),
                Restaurant(name: "Happy Cafe", location: "New York, NY", cuisine: "Italian", imageName: "happy_cafe"),
                Restaurant(name: "Urban Grill", location: "San Francisco, CA", cuisine: "Sushi", imageName: "urban_grill"),
                Restaurant(name: "Golden Bar", location: "Miami, FL", cuisine: "Cuban", imageName: "golden_bar"),
                Restaurant(name: "Rustic Garden", location: "Boston, MA", cuisine: "Seafood", imageName: "rustic_garden"),
                Restaurant(name: "Lucky Place", location: "Chicago, IL", cuisine: "American", imageName: "lucky_place"),
                Restaurant(name: "Magic Bistro", location: "Austin, TX", cuisine: "Tex-Mex", imageName: "magic_bistro"),
                Restaurant(name: "Spicy Kitchen", location: "Seattle, WA", cuisine: "Vietnamese", imageName: "spicy_kitchen"),
                Restaurant(name: "Big Kitchen", location: "Portland, OR", cuisine: "Vegan", imageName: "big_kitchen"),
                Restaurant(name: "Blue Fork", location: "Los Angeles, CA", cuisine: "Mexican", imageName: "blue_fork"),
                Restaurant(name: "Happy Garden", location: "Denver, CO", cuisine: "Steakhouse", imageName: "happy_garden")
            ]
}
