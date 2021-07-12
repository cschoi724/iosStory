//
//  StoryModel.swift
//  iosClubRadio
//
//  Created by cschoi724 on 2020/07/01.
//  Copyright © 2020 Inforex. All rights reserved.
//

import Foundation


struct StoryModel {
    var from : User
    var regNo : Int
    var read : Bool
    var contents : String
    var date : String
    var moreAction : ((StoryModel)->Void)?
    
    
}
