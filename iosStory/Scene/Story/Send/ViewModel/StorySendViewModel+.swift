//
//  StorySendViewModel+.swift
//  iosStory
//
//  Created by cschoi724 on 2021/07/11.
//

import Foundation
import SwiftyJSON

extension StorySendViewModel {
    
    func setUp(_ initData: JSON){
        let fromUser = User(name: "석찬",
                            no: 4781,
                            id: "cschoi724",
                            gender: "m",
                            thumbnailUrl: "")
        self.model.fromUser.onNext(fromUser)
        
        let toUser = User(name: "unheyi",
                          no: 4782,
                          id: "unheyi93",
                          gender: "f",
                          thumbnailUrl: "")
        self.model.toUser.onNext(toUser)
        
        
    }
   
    func send(_ from: User, to: User, text: String, completion: ((Bool)->Void)? = nil){
        let completion = completion ?? {_ in}
        let path = "http://pida83.gabia.io/api/story"
        let params : [String:String] = [
            "send_mem_gender": from.gender,
            "send_mem_no" : "\(from.no)",
            "send_chat_name":from.name,
            "send_mem_photo":from.thumbnailUrl,
            "story_conts":text,
            "bj_id" : from.id
        ]
        
        print(params)
        RESTManager.sharedInstance.request(path, method: .post, paramters: params){ reponse in
            guard let res = reponse else{
                completion(false)
                return
            }
            let json = JSON(res)
            print(json)
            completion(true)
        }
    }
    
    func editing(_ begin: Bool){
        self.model.editing.accept(begin)
    }
    
    func limiter() -> (max:Int,min:Int){
        return (self.model.maxTextCount.value, self.model.minTextCount.value)
    }
    
}
