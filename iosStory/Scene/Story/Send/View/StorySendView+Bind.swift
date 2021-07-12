//
//  BCStorySend+Bind.swift
//  iosClubRadio
//
//  Created by cschoi724 on 2020/06/30.
//  Copyright © 2020 Inforex. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift
import RxCocoa

extension StorySendView {
    
    
    func bind(){
        let anotherview_tap   = UITapGestureRecognizer()
        let superview_tap     = UITapGestureRecognizer()
        
        another_view.addGestureRecognizer(anotherview_tap)
        self.addGestureRecognizer(superview_tap)
                
        let input = StorySendViewModel.Input(text: conts_textView.rx.text.orEmpty.map{ $0},
                                             send: send_btn.rx.tap.map{_ in},
                                             close_tap: close_btn.rx.tap.map{_ in},
                                             another_tap: anotherview_tap.rx.event.map{_ in})
        
        viewModel = StorySendViewModel(input)
        viewModel.setUp(viewData)
        
        viewModel.text
            .map{ !$0.isEmpty }
            .drive{ [weak self] in
                guard let self = self else{ return }
                self.placeholder_label.isHidden = $0
            }
            .disposed(by: bag)
        
        viewModel.text
            .distinctUntilChanged()
            .drive{ [weak self] in
                guard let self = self else{ return }
                self.conts_textView.text = $0
            }
            .disposed(by: bag)
                
        viewModel.textCount
            .map{ "\($0)/\(300)" }
            .drive{ [weak self] in
                guard let self = self else{ return }
                self.conts_count_label.text = $0
            }
            .disposed(by: bag)
        
        viewModel.keyboardDown
            .drive{ [weak self] _ in
                guard let self = self else{ return }
                self.endEditing(true)
            }
            .disposed(by: bag)
        
        viewModel.removeFromSuperview
            .drive{ [weak self] _ in
                guard let self = self else{ return }
                self.removeFromSuperview()
            }
            .disposed(by: bag)
    
        superview_tap.rx.event
            .bind {  [weak self] _ in
                guard let self = self else{ return }
                self.endEditing(true)
            }
            .disposed(by: bag)
    }
    
}

