//
//  BCStorySendView.swift
//  iosClubRadio
//
//  Created by cschoi724 on 2020/06/30.
//  Copyright © 2020 Inforex. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class StorySendView : XibView{
    
    @IBOutlet weak var super_view: UIView!
    @IBOutlet weak var another_view: UIView!
    @IBOutlet weak var close_btn: UIButton!
    @IBOutlet weak var conts_textView: UITextView!
    @IBOutlet weak var placeholder_label: UILabel!
    @IBOutlet weak var send_btn: UIButton!
    @IBOutlet weak var conts_count_label: UILabel!
    
    let bag = DisposeBag()
    var viewModel : StorySendViewModel!
    let weight = 20
    let maxTextCount = 300
    let minTextCount = 10
    
    let sendBtnGradient: CAGradientLayer = CAGradientLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isInitailized {
            initialize()
            isInitailized = false
            animateUp()
        }
        sendBtnGradient.frame = send_btn.bounds
    }
    
    override func removeFromSuperview() {
        animateDown{ _ in
            super.removeFromSuperview()
        }
    }
    
    func initialize(){
        setLayout()
        bind()
        setTextview()
    }
    
    func setLayout(){
        setSendBtn()
        setShadow()
        self.conts_textView.layer.cornerRadius = 5
    }
    
    func setSendBtn(){
        sendBtnGradient.frame = send_btn.bounds
        sendBtnGradient.colors = [
            UIColor(r: 133, g: 129, b: 255).cgColor,
            UIColor(r: 152, g: 107, b: 255).cgColor
        ]
        sendBtnGradient.startPoint = CGPoint(x: 0, y: 0.5)
        sendBtnGradient.endPoint = CGPoint(x: 1, y: 0.5)
        sendBtnGradient.locations = [0,1]
        send_btn.layer.cornerRadius = 19
        send_btn.layer.masksToBounds = true
        send_btn.layer.addSublayer(sendBtnGradient)
        
        
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
