//
//  BCStorySendViewModel.swift
//  iosClubRadio
//
//  Created by cschoi724 on 2020/07/01.
//  Copyright © 2020 Inforex. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift
import RxCocoa

class StorySendViewModel {
    
    var model = StorySendModel()
    let bag = DisposeBag()
    
    struct Input {
        var text : Observable<String>
        var send : Observable<Void>
        var close_tap : Observable<Void>
        var another_tap : Observable<Void>
    }
    
    var text : Driver<String>
    var textCount : Driver<Int>    
    var keyboardDown : Driver<Void>
    var removeFromSuperview : Driver<Void>
    
    init(_ input : Input){
        
        text = model.text
            .distinctUntilChanged()
            .map{ $0 }
            .asDriver(onErrorRecover: { _ in .empty() })
    
        textCount = model.textCount
            .distinctUntilChanged()
            .map{ $0 }
            .asDriver(onErrorRecover: { _ in .empty() })
    
        keyboardDown = model.keyboardDown
            .map{ $0}
            .asDriver(onErrorRecover: { _ in .empty() })
        
        removeFromSuperview = model.removeFromSuperview
            .map{ $0}
            .asDriver(onErrorRecover: { _ in .empty() })
        
        model.text
            .map{ text in
                let trimCount = text.components(separatedBy: "\n").count - 1
                return text.count + (trimCount*20) - trimCount
            }
            .bind(to: model.textCount)
            .disposed(by: bag)
        
        input.text
            .bind(to: model.text)
            .disposed(by: bag)
                
        input.send
            .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
            .withLatestFrom(model.textCount)
            .withLatestFrom(model.maxTextCount){ ($0,$1) }
            .withLatestFrom(model.minTextCount){ ($0.0,$0.1,$1) }
            .map{ textCount,max,min in
                if textCount > max {
                    Toast.show("300자이내로 작성해주세요")
                    return false
                }else if textCount < min{
                    Toast.show("10자이상 작성해주세요")
                    return false
                }else{
                    return true
                }
            }
            .filter{$0}
            .withLatestFrom(model.text)
            .filter{
                if $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
                    Toast.show("사연을 입력해주세요")
                    return false
                }else{
                    return true
                }
            }
            .withLatestFrom(model.fromUser){ ($0,$1)}
            .withLatestFrom(model.toUser){ ($0.0,$0.1,$1)}
            .bind {[weak self]( text, fromUser, toUser) in
                guard let self = self else{ return}
                self.model.keyboardDown.onNext(())
                self.model.removeFromSuperview.onNext(())
                self.send(fromUser, to: toUser, text: text){ res in
                    if res {
                        Toast.show("사연이 전송되었습니다")
                    }else{
                        Toast.show("사연 전송에 실패했습니다.")
                    }
                }
            }
            .disposed(by: bag)
        
        input.close_tap
            .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
            .map{_ in ()}
            .bind(to: model.removeFromSuperview)
            .disposed(by: bag)
        
        input.another_tap
            .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
            .withLatestFrom(model.editing)
            .bind{ [weak self] editting in
                guard let self = self else{ return }
                if editting {
                    self.model.keyboardDown.onNext(())
                }else{
                    self.model.removeFromSuperview.onNext(())
                }
            }
            .disposed(by: bag)
    }
    
    
    
}
