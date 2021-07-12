//
//  StoryListModel.swift
//  iosStory
//
//  Created by cschoi724 on 2021/07/10.
//

import Foundation
import RxSwift
import RxCocoa

class StoryListModel {
    
    var viewer = BehaviorRelay<User?>(value: nil)
    var storys = BehaviorRelay<[StoryModel]>(value: [])
    var removeFromSuperview = BehaviorRelay<Bool>(value: false)
    var page = 1
}
