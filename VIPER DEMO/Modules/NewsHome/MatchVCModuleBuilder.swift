//
//  NewsVCModuleBuilder.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import Foundation
import UIKit

class NewsVcModuleBuilder {
    static func build(factory:NavigationFactory) -> UIViewController{
        let view = MatchVC()
        let interactor = MatchInteractor()
        let router = MatchRouter.init(view: view)
        let presenter = MatchPresenter.init(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        return view
    }
}

