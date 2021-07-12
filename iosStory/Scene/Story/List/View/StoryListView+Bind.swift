//
//  BCStoryList+Bind.swift
//  iosClubRadio
//
//  Created by cschoi724 on 2020/07/01.
//  Copyright © 2020 Inforex. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension StoryListView{

    func bindTo(){
        let anotherview_tap = UITapGestureRecognizer()
        another_view.addGestureRecognizer(anotherview_tap)
        
    
        let inputs = StoryListViewModel.Inputs(anotherview_tap: anotherview_tap.rx.event.map{_ in},
                                               downlayer_tap: close_btn.rx.tap.map{_ in})
        
        
        viewModel = StoryListViewModel(inputs)
        viewModel.setUp(viewData)
        
        viewModel.removeFromSuperview
            .drive{ [weak self] _ in
                guard let self = self else{ return}
                self.animateDown{ _ in
                    self.removeFromSuperview()
                }
            }
            .disposed(by: bag)
        
        viewModel.storys
            .bind{ [weak self] storys in
                guard let self = self else{ return}
                self.stoty_none_view.isHidden = !storys.isEmpty
            }
            .disposed(by: bag)
        
    }
}
