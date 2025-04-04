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
                Restaurant(name: "Folie", location: "West Lafayette, IN", cuisine: "French", imageName: "folie")
    ]
}
