//
//  NavigationBuilder.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import Foundation
import UIKit

typealias NavigationFactory = (UIViewController) -> UINavigationController

class NavigationBuilder {
    static func build(viewController: UIViewController) -> UINavigationController{
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.view.backgroundColor = .clear
        navigationController.navigationBar.backgroundColor = .clear
        return navigationController
    }
}

