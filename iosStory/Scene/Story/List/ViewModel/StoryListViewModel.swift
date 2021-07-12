//
//  StoryViewModel.swift
//  iosStory
//
//  Created by cschoi724 on 2021/07/10.
//

import Foundation
import RxSwift
import RxCocoa

class StoryListViewModel {
    
    let model = StoryListModel()
    let bag = DisposeBag()
    
    struct Inputs {
        var anotherview_tap : Observable<Void>
        var downlayer_tap : Observable<Void>
    }
    
    var removeFromSuperview : Driver<Bool>
    var storys : BehaviorRelay<[StoryModel]>
    
    init(_ inputs: Inputs) {
        
        storys = model.storys
        
        removeFromSuperview = model.removeFromSuperview
            .filter{ $0 }
            .map{ $0 }
            .asDriver(onErrorRecover: {_ in .empty()})
        
        inputs.anotherview_tap
            .map{_ in true}
            .bind(to: model.removeFromSuperview)
            .disposed(by: bag)
        
        inputs.downlayer_tap
            .map{_ in true}
            .bind(to: model.removeFromSuperview)
            .disposed(by: bag)
        
    }
}
