//
//  NewsDataManager.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import Foundation
import Alamofire

class NewsDataManager {
    static let shared = NewsDataManager()
    
    var contentDetails: ((MatchModel) -> ())?
    
    func NewsFeedManager(completion: @escaping(ResultSet<MatchModel ,ServerError>) -> Void){
        
        ServerDataManager.shared().getRequest(params: nil, apiPath: NEWS_URL) { result in
            switch result{
            case.success(let data):
                do{
                    let rootModel = try JSONDecoder().decode(MatchModel.self, from: data)
                    completion(.success(rootModel))
                }catch{
                    print(error.localizedDescription)
                }
            case.failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
}
