//
//  AppDelegate.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        loadNewsVC()
        
        return true
    }

    
    private func loadNewsVC() {
        let news = NewsVcModuleBuilder.build(factory: NavigationBuilder.build(viewController:))
        window?.rootViewController = news
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .dark
        } else {
        }
        window?.makeKeyAndVisible()
    }
}

