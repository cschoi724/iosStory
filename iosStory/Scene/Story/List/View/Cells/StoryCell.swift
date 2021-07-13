//
//  BCStoryCell.swift
//  iosClubRadio
//
//  Created by cschoi724 on 2020/07/01.
//  Copyright © 2020 Inforex. All rights reserved.
//

import Foundation
import Kingfisher
import RxSwift
import RxCocoa

class StoryCell : UITableViewCell{
    
    @IBOutlet weak var super_view: UIView!
    @IBOutlet weak var thumbnail_imageView: UIImageView!
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var date_view: UIView!
    @IBOutlet weak var insdate_label: UILabel!
    @IBOutlet weak var more_btn: UIButton!
    @IBOutlet weak var message_frame_view: UIView!
    @IBOutlet weak var message_label: UILabel!
    @IBOutlet weak var gender_imageView: UIImageView!
    
    var story : StoryModel!
    var bag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        message_label.text = nil
        name_label.text = nil
        date_view.isHidden = true
        bag = DisposeBag()
    }
    
    func initalize(){
        guard let model = self.story else{
            return
        }
        
        let fromUser = model.from
        
        let url = URL(string: fromUser.thumbnailUrl)
        thumbnail_imageView.kf.setImage(with: url, placeholder: UIImage(named: "imgProDefault"))
        thumbnail_imageView.layer.cornerRadius = thumbnail_imageView.frame.width/2
        
        name_label.text = fromUser.name
        message_label.text = model.contents
        message_frame_view.layer.cornerRadius = 5
        
        if model.read {
            message_frame_view.backgroundColor = UIColor(r: 241, g: 238, b: 255)
        }else{
            message_frame_view.backgroundColor = UIColor(r: 238, g: 238, b: 238)
        }
        
        if let sec = model.date.DDay{
            date_view.isHidden = false
            let hours = sec / 3600
            let minutes = (sec % 3600) / 60
            if hours >= 24 {
                insdate_label.text = "오래 전"
            }else if hours < 24, hours > 0{
                insdate_label.text = String(format: "%2d시간 전", arguments: [hours])
            }else if hours <= 0, minutes < 1{
                insdate_label.text = "방금"
            }else if hours <= 0 {
                insdate_label.text = String(format: "%2d분 전", arguments: [minutes])
            }
        }
        
        gender_imageView.image = fromUser.gender == "m" ?
            UIImage(named: "badgeSexM") : UIImage(named: "badgeSexFm")
        
        more_btn.rx.tap
            .bind{_ in
                guard let action = model.moreAction else{ return }
                action(model)
            }
            .disposed(by: bag)
    }

    
}
