//
//  BCStoryListView.swift
//  iosClubRadio
//
//  Created by cschoi724 on 2020/07/01.
//  Copyright © 2020 Inforex. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class StoryListView :XibView {
    
    @IBOutlet weak var super_view: UIView!
    @IBOutlet weak var another_view: UIView!
    @IBOutlet weak var close_btn: UIButton!
    @IBOutlet weak var story_list_view: UIView!
    @IBOutlet weak var stoty_none_view: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : StoryListViewModel!
    let bag = DisposeBag()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isInitailized {
            initialize()
            animateUp()
            isInitailized = false
        }
    }
    
    override func removeFromSuperview() {
        animateDown{ _ in
            super.removeFromSuperview()
        }
    }
    
    func initialize(){
        setLayout()
        bindTo()
        setTableView()
    }
    
    func setLayout(){
        setShadow()
    }
    
    func setShadow(){
        super_view.layer.shadowColor = UIColor(r: 0, g: 0, b: 0, a: 0.5).cgColor
        super_view.layer.shadowOpacity = 1
        super_view.layer.shadowOffset = CGSize(width: 0, height: -8)
        super_view.layer.shadowRadius = 16
        let bounds = super_view.bounds
        let shadowPath = UIBezierPath(rect: CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: 5)).cgPath
        super_view.layer.shadowPath = shadowPath
        super_view.layer.shouldRasterize = true
        super_view.layer.rasterizationScale = UIScreen.main.scale
    }
    
}
