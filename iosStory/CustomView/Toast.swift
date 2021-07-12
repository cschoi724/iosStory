//
//  Toast.swift
//  iosStory
//
//  Created by cschoi724 on 2021/07/12.
//

import Foundation
import Toast_Swift


public class Toast {
    
    class func show(_ message : String,
                    duration : Double = 2.0,
                    position : ToastPosition = .center,
                    background : UIColor = UIColor.black.withAlphaComponent(0.8),
                    title : String? = nil,
                    image: UIImage? = nil,
                    completion: ((Bool)->Void)? = nil){
        
        var style = ToastStyle()
        style.backgroundColor = background
        style.titleAlignment = .center
        style.messageAlignment = .center
        style.horizontalPadding = 20
        //style.verticalPadding = 60
        guard let vc = App.visibleViewController() else{
             return
         }
                
        vc.view.hideAllToasts()
        vc.view.clearToastQueue()
        
        vc.view.makeToast(message,
                          duration: duration,
                          position: position,
                          title: title,
                          image: image,
                          style: style,
                          completion: completion)
    }
   
}
