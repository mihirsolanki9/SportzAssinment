//
//  NewsVCPresenter.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import Foundation

protocol MatchPresenterProtocol: AnyObject {
    func getHomeApiData()
    func redirectToDetails()
}

class MatchPresenter{
    weak var view: MatchViewProtocol?
    let interactor: MatchInteractorProtocol?
    let router: MatchRouterProtocol?
    
    init(view: MatchViewProtocol, interactor: MatchInteractorProtocol, router: MatchRouterProtocol){
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension MatchPresenter: MatchPresenterProtocol{
    func redirectToDetails() {
        router?.redirectToWebPage()
    }
    
    func getHomeApiData() {
        print("Data Loaded")
        interactor?.fetchNewsApi(completion: { result in
            guard let responseData = result else {return}
            self.view?.getNewsFeed(data: responseData)
        })
    }
}

