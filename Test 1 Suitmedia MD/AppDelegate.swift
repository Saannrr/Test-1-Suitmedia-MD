//
//  AppDelegate.swift
//  Test 1 Suitmedia MD
//
//  Created by Ihsan on 14/08/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
