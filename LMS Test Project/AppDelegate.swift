//
//  AppDelegate.swift
//  LMS Test Project
//
//  Created by Abdul Motalab Rakib on 20/1/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var refereenceTime = 10
    var counter = 0
    var countdownTimer = Timer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UITabBar.appearance().tintColor = UIColor(hex: "#0C3539")
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().unselectedItemTintColor = UIColor(hex: "#008977")
        
        if UserDefaults.standard.bool(forKey: "isLogedIn") {
            loadHomeScene()
        } else {
            loadLoginScene()
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

    func loadLoginScene(){
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            
            let story = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = story.instantiateViewController(withIdentifier: "LoginViewController")
            
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                // Set the tab bar controller as the root
                window.rootViewController = loginVC
                window.makeKeyAndVisible()
            }, completion: nil)
        }
    }
    
    func loadHomeScene(onCompletion completion: (()-> Void)? = nil){
        let story = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = story.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        let homeNav = story.instantiateViewController(withIdentifier: "HomeViewNav") as! UINavigationController
        let profileVC = story.instantiateViewController(withIdentifier: "ProfileViewController")
        let MyMlsVC = story.instantiateViewController(withIdentifier: "MyLMSViewController")
        let shop = story.instantiateViewController(withIdentifier: "ShopViewController")
        let moreVC = story.instantiateViewController(withIdentifier: "MoreViewController")
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            
            tabbar.viewControllers = [homeNav, profileVC, MyMlsVC, shop, moreVC]
            
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
                // Set the tab bar controller as the root
                window.rootViewController = tabbar
                window.makeKeyAndVisible()
            }, completion: nil)
        }
    }
    

}

