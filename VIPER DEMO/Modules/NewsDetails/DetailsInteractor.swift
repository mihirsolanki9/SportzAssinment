//
//  DetailsNewsInteractor.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import Foundation

protocol DetailsInteractorProtocol: AnyObject {
    func fetchNewsApi(completion: @escaping () -> ())
}

class DetailsInteractor: DetailsInteractorProtocol{
    func fetchNewsApi(completion: @escaping () -> ()) {
        //
    }
    
}
