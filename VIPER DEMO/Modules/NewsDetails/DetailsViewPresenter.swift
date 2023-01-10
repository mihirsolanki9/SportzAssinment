//
//  DetailsNewsPresenter.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import Foundation

protocol DetailsNewsPresenterProtocol: AnyObject {
    func getPlayerApiData()
}

class DetailsViewPresenter{
    weak var view: DetailsViewProtocol?
    let interactor: DetailsInteractorProtocol?
    let router: DetailsRouterProtocol?
    
    init(view: DetailsViewProtocol, interactor: DetailsInteractorProtocol, router: DetailsRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension DetailsViewPresenter: DetailsNewsPresenterProtocol{
    func getPlayerApiData() {
        print("Data Loaded")
        interactor?.fetchPlayersApi(completion: { result in
            guard let responseData = result else {return}
            self.view?.getPlayerFeed(data: responseData)
        })
    }
}


