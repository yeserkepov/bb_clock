//
//  AppDelegate.swift
//  bb_clock
//
//  Created by Даурен on 25.03.2022.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                self.showAuthVC()
            }
        }
        return true
    }
    
    private func showAuthVC() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
        vc.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
        
    }
}

