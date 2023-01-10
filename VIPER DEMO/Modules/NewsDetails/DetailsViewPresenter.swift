//
//  DetailsNewsPresenter.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import Foundation

protocol DetailsNewsPresenterProtocol: AnyObject {
   
}

class DetailsViewPresenter{
    weak var view: DetailsViewProtocol?
    let interactor: DetailsNewsInteractorProtocol?
    let router: DetailsNewsRouterProtocol?
    
    init(view: DetailsViewProtocol, interactor: DetailsNewsInteractorProtocol, router: DetailsNewsRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension DetailsViewPresenter: DetailsNewsPresenterProtocol{
    
}


