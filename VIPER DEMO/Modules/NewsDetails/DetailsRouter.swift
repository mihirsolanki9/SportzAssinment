//
//  DetailsNewsRouter.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import Foundation
import UIKit

protocol DetailsNewsRouterProtocol: AnyObject{
    func redirectToWebPage()
}

class DetailsRouter {
    var view: UIViewController
    init(view: UIViewController) {
        self.view = view
    }
}

extension DetailsRouter: DetailsNewsRouterProtocol{
    func redirectToWebPage() {
      print("Hello")
    }
}

