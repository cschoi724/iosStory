//
//  BCStorySendModel.swift
//  iosClubRadio
//
//  Created by cschoi724 on 2020/07/01.
//  Copyright © 2020 Inforex. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift
import RxCocoa

class StorySendModel {

    var fromUser = PublishSubject<User>()
    var toUser = PublishSubject<User>()
    var text = BehaviorRelay<String>(value: "")
    var textCount = BehaviorRelay<Int>(value: 0)
    var editing = BehaviorRelay<Bool>(value: false)    
    var keyboardDown = PublishSubject<Void>()
    var removeFromSuperview = PublishSubject<Void>()
    
    let weight = BehaviorRelay<Int>(value: 20)
    let maxTextCount = BehaviorRelay<Int>(value: 300)
    let minTextCount = BehaviorRelay<Int>(value: 10)
    
    
}
