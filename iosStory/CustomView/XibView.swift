//
//  XibView.swift
//  iosStory
//
//  Created by cschoi724 on 2021/07/10.
//

import Foundation
import UIKit
import SwiftyJSON

class XibView: UIView {
    var viewData : JSON = JSON()
    var isInitailized = true
    var appearViewListener : (() -> Void)?
    var removeViewListener : (() -> Void)?
    
    required init(frame: CGRect, viewData : JSON) {
        super.init(frame: frame)
        self.viewData = viewData
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit(){
        guard let xibName = NSStringFromClass(self.classForCoder).components(separatedBy: ".").last else { return }
        if let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as? UIView{
            view.frame = self.bounds
            view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
            self.addSubview(view)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let listender = appearViewListener, isInitailized{
            listender()
        }
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        if let listender = removeViewListener {
            listender()
        }
    }
}

