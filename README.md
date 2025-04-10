Deli
===

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

Deli is a food-ranking platform that helps users explore new dining options and document their experiences. It consolidates restaurant data from the user’s local area, allowing them to write reviews, upload photos, and rate their meals. The app offers a personalized experience where users can revisit their reviews and discover highly rated options nearby, making it a go-to solution for food lovers seeking convenience and variety.


### Description

The app is designed to simplify the dining experience by combining restaurant discovery and food review features in one place. Users can explore local restaurants near them and add their own reviews. By enabling users to upload photos and provide detailed feedback, the app creates a personal list of dining experiences that can be shared with others.

Beyond discovery, the app functions as a personal food diary. Users can revisit their profiles to see past reviews and photos, helping them remember their favorite restaurants and meals. The app’s intuitive interface, combined with real-time, location-based restaurant recommendations, ensures that users can quickly decide where to eat. Whether it’s for trying new cuisines or revisiting old favorites, this app makes dining out an enjoyable and organized experience.

### App Evaluation

- **Category:** Food
- **Mobile:** This app is useful on mobile because it provides a consolidated place for users to view all restaurants in their area, as well as write and view past reviews for the restaurants they have eaten at.
- **Story:** Allows users to try new food establishments and document their experiences for future reference. 
- **Market:** Anyone that eats out at restaurants would find this application useful. The ability to view restaurants in the users' area make it useful for anyone looking to try a new restaurant near them. The ability to write reviews and view them on a user's profile make the app useful for anyone looking to revisit an old restaurant that they rated highly.
- **Habit:** Users will check this application any time they are looking to eat food outside, which is frequent for most people. 
- **Scope:** This app will pull from all restaurants near a user, as well as any restaurants a user has manually add them. Then, it will display this data in a consolidated interface.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-Have Stories**

* Ability to view restaurants near them and write reviews for those restaurants.
* Ability to add unreviewed restaurants to the app or to add reviews to restaurants they haven't been to before. 
* Ability to look at recommendations for restaurants near them based on distance and prior reviews.

**Optional Nice-to-have Stories**

* Ability to log in as different users.


### 2. Screen Archetypes

- [x] Stream
* User can log a review for a new restaurant.
* User can look at restaurants near them that match their preferences.
* User can scroll through their account and previous reviews or visited restaurants. 

- [x] Search
* User can search for restaurants near them.

- [x] Detail
* User can look at a restaurant's details.
* User can look at a review of a restaurant.
* User can look at their account details (username, number of reviews, preferences, etc.)

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Restaurants List
* Add Review
* My Profile

**Flow Navigation** (Screen to Screen)

- Stream
    -> Navigate restaurants near you
    -> Add review
    -> Check profile
- Navigate restaurants near you
    -> Detail page for individual restaurant with info and reviews
- Add review
    -> Confirm review

## Wireframes


![Wireframe](https://hackmd.io/_uploads/rycKuBXp1l.png)

## Schema 

User
- ID
- name
- photo
- Review[]

Review
- ID
- restaurantName
- cuisine
- location
- score
- reviewText
- photoURL

### Models

[Add table of models]

### Networking

- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
