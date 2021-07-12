//
//  UIView+Animate.swift
//  iosStory
//
//  Created by cschoi724 on 2021/07/10.
//

import Foundation
import UIKit

extension UIView{
    
    func animateUp(_ duration: TimeInterval = 0.5, delay: Double = 0, completion: ((Bool)->Void)? = nil){
        self.frame.origin.y = self.bounds.height
        UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseIn],
                       animations: {
                        self.frame.origin.y = 0
        }, completion: completion)
        self.isHidden = false
    }
  
    func animateDown(_ duration: TimeInterval = 0.5, delay: Double = 0, completion: ((Bool)->Void)? = nil){
        UIView.animate(withDuration: duration, delay: delay, options: [.curveLinear],
                       animations: {
                        self.center.y = self.bounds.height
        },  completion: completion)
        
        UIView.animate(withDuration: duration,  delay: delay, options: [.curveLinear], animations: {
            self.frame.origin.y = self.bounds.height
        }, completion: completion)
    }
    
}
