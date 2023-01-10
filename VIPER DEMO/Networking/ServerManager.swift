//
//  ServerManager.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import UIKit
import Foundation
import Alamofire

class ServerDataManager: NSObject {
    
    //1 Managers and variables to be used in the calls
    private var defaultManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.urlCache = URLCache.shared
        configuration.urlCache = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: "URLCACHE")
        let afManager = Alamofire.SessionManager(configuration: configuration)
        return afManager
    }()
    
    let networkReachabilityManager = NetworkReachabilityManager(host: "www.apple.com")
    
    class func shared() -> ServerDataManager {
        struct Static {
            //Singleton instance. Initializing Data manager.
            static let sharedInstance = ServerDataManager()
        }
        /** @return Returns the default singleton instance. */
        return Static.sharedInstance
    }
    
    
    func getHeaders(method: APIMETHOD, cachePolicy: Bool = true) -> HTTPHeaders {
        switch method {
        case .POST:
            return ["Content-Type": "application/json","Accept": "*/*","x-access-auth-token" : authToken ,
                    "update": String(1), "token": String(CreateTokenManager.shared.createTokenData?.token ?? ""), "version":"V3"
            ]
            
        case .GET:
            if cachePolicy{
                return ["Content-Type": "application/json","Accept": "*/*","x-access-auth-token" : authToken]
            } else{
                return ["Content-Type": "application/json","cache-control":"no-cache","Accept": "*/*","x-access-auth-token" : authToken]
            }
        }
    }
    
    
    func postRequest(params: Parameters?, apiPath: String, closure: @escaping (ApiResults<Data, ServerError>) -> Void) {
        if !(networkReachabilityManager?.isReachable)! {
            closure(ApiResults.failure(ServerError.noInternetConnection(message: "Oops...looks like your internet connection is taking a break.", statusCode: 000)))
            return
        }else{
            
            let requestHeaders = getHeaders(method: .POST)
            self.defaultManager.request(apiPath, method: .post, parameters: params, encoding: JSONEncoding.default, headers: requestHeaders).responseJSON { (response) in
                print(requestHeaders)
                print("Request status code====>>>>")
                print(response.response?.statusCode as Any)
                switch response.result {
                case .success:
                    //let resJson = JSON(response.result.value!)
                    print("😊😊😊😊Data received Successfully of POST Request😊😊😊😊")
                    print("APIUrl===",(apiPath))
                    print("Parameters===",(params) as Any)
                    //print(resJson)
                    closure(ApiResults.success(response.data!))
                case .failure(let error):
                    print("😭😭😭😭Error Occurred😭😭😭😭")
                    print(error.localizedDescription)
                    print("================\(apiPath)=====================")
                    //                print("😭😭😭😭\")
                    if error._code == NSURLErrorTimedOut {
                        closure(ApiResults.failure(ServerError.requestTimeOut(message: "Request Time Out")))
                    }else {
                        closure(ApiResults.failure(ServerError.unknownError(message: error.localizedDescription, statusCode: 000)))
                    }
                }
            }
        }
    }
    
    func getRequest(params: Parameters?, apiPath: String, cachePolicy: Bool = true,closure: @escaping (ApiResults<Data, ServerError>) -> Void) {
        if !(networkReachabilityManager?.isReachable)! {
            closure(ApiResults.failure(ServerError.noInternetConnection(message: "Oops...looks like your internet connection is taking a break.", statusCode: 000)))
            return
        }
        let requestHeaders = getHeaders(method: .GET,cachePolicy: cachePolicy)
        
        self.defaultManager.request(apiPath, method: .get, parameters: params, encoding: JSONEncoding.default, headers: requestHeaders).responseData { (response) in
            //print(response.response?.statusCode)
            switch response.result {
            case .success:
                //let responseJson = JSON(response.result.value!)
                print("😊😊😊😊Data received Successfully of GET Request😊😊😊😊")
                print("==============\(apiPath)=================")
                //print(responseJson)
                if let statusCode = response.response?.statusCode, statusCode == 404 {
                    closure(ApiResults.failure(ServerError.unknownError(message: "Request Time Out", statusCode: 404)))
                } else {
                    closure(ApiResults.success(response.data!))
                }
            case .failure(let error):
                print("😭😭😭😭Error Occurred😭😭😭😭")
                print("==============\(apiPath)=================")
                if error._code == NSURLErrorTimedOut {
                    closure(ApiResults.failure(ServerError.requestTimeOut(message: "Request Time Out")))
                }else {
                    closure(ApiResults.failure(ServerError.unknownError(message: error.localizedDescription, statusCode: 000)))
                }
            }
        }
    }
}


enum ApiResults<ValueType, ErrorType> {
    case success(ValueType)
    case failure(ErrorType)
}


enum ServerError {
    case noError
    case noInternetConnection(message: String, statusCode: Int)
    case unknownError(message: String, statusCode: Int)
    case requestTimeOut(message: String)
    case noDataAvailable(message: String)
    case wrongOtp(message: String)
    case forceLogoutUser(message: String)
    case SomethingWentWrong(message: String)
    case sessionInvalidated(message: String, statuscode: Int)
    
    func getErrorMessage() -> String {
        switch self {
        case .noInternetConnection(let message, _): return message
        case .unknownError(let message, _): return message
        case .requestTimeOut(let message): return message
        case .noDataAvailable(let message): return message
        case .noError:
            break
        case .wrongOtp(let message): return message
        case .forceLogoutUser(let message): return message
        case .SomethingWentWrong(let message): return message
        case .sessionInvalidated(let message,_): return message
        }
        return ""
    }
    
    func getStatuscode() -> Int{
        switch self {
        case .sessionInvalidated(_, let code):
            return code
        default:
            return 0
        }
    }
}


enum APIMETHOD: String {
    case POST
    case GET
}

enum ResultSet<ValueType, ErrorType> {
    case success(ValueType)
    case failure(ErrorType)
}

