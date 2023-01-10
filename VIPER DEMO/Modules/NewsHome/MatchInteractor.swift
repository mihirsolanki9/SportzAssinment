//
//  NewsInteractor.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import Foundation

protocol MatchInteractorProtocol: AnyObject {
    func fetchNewsApi(completion: @escaping (MatchModel?) -> ())
}

class MatchInteractor: MatchInteractorProtocol{
    func fetchNewsApi(completion: @escaping (MatchModel?) -> ()) {
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
