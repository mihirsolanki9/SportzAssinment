//
//  DetailsNewsInteractor.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import Foundation

protocol DetailsInteractorProtocol: AnyObject {
    func fetchPlayersApi(completion: @escaping (MatchModel?) -> ())
}

class DetailsInteractor: DetailsInteractorProtocol{
    func fetchPlayersApi(completion: @escaping (MatchModel?) -> ()) {
        NewsDataManager.shared.NewsFeedManager() { result in
            switch result {
            case.success(let data):
                completion(data)
            case.failure(_):
                completion(nil)
                break
            }
        }
    }
}
