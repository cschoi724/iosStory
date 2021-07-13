//
//  RESTManager.swift
//  iosStory
//
//  Created by cschoi724 on 2021/07/10.
//

import Foundation
import Alamofire

class RESTManager : NSObject{
    
    class var sharedInstance : RESTManager {
        struct Static {
            static let instance : RESTManager = RESTManager()
        }
        return Static.instance
    }
    
    
    func request(_ path: String,
                 method: HTTPMethod = .get,
                 paramters: [String:String]? = nil,
                 result : ((_ response: Any?) ->Void)? = nil){
        
        let encoding : ParameterEncoding = (method == .post) ?
            JSONEncoding.default : URLEncoding.queryString
        
        AF.request(path,
                   method: method,
                   parameters: paramters,
                   encoding: encoding)
            .responseJSON { response in
                let completionHandler = result ?? {_ in}
                switch response.result {
                case .success(let res):
                    print(res)
                    completionHandler(res)
                case .failure(let error):
                    print(error)
                    completionHandler(nil)
                }
            }
    }
    //public var sessionManager: Alamofire.SessionManager
    
}
