//
//  NewsVCRouter.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import Foundation
import UIKit

protocol MatchRouterProtocol: AnyObject{
    func redirectToWebPage()
}

class MatchRouter {
    var view: UIViewController
    init(view: UIViewController) {
        self.view = view
    }
}

extension MatchRouter: MatchRouterProtocol{
    func redirectToWebPage() {
        let vc = DetailsModuleBuilder.build()
        vc.modalPresentationStyle = .fullScreen
        self.view.present(vc, animated: true)
    }
}
