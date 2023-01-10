//
//  DetailsNewsModuleBuilder.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import Foundation
import UIKit

class DetailsModuleBuilder {
    static func build(factory:NavigationFactory, newsUrl:String) -> UIViewController{
        let view = DetailsVC()
        let interactor = DetailsInteractor()
        let router = DetailsRouter.init(view: view)
        let presenter = DetailsViewPresenter.init(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        view.newsUrl = newsUrl
        return view
    }
}

