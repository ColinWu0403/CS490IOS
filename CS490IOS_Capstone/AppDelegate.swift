//
//  AppDelegate.swift
//  CS490IOS_Capstone
//
//  Created by colin wu on 25/03/2025.
//

import UIKit
import Firebase
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Fetch the API key from environment variable
        if let apiKey = ProcessInfo.processInfo.environment["GOOGLE_API_KEY"] {
            // Create FirebaseOptions with the API key
            let options = FirebaseOptions(googleAppID: "1:317179960404:ios:39aa7a74699e92cc1321c1", gcmSenderID: "317179960404")
            options.apiKey = apiKey
            options.projectID = "cs490ios"
            
            // Configure Firebase with the options
            FirebaseApp.configure(options: options)
        } else {
            print("Error: API key is missing.")
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

