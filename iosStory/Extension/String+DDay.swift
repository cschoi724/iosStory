//
//  String+DDay.swift
//  iosStory
//
//  Created by cschoi724 on 2021/07/12.
//

import Foundation
extension String{
    
    var DDay : Int? {
        let calendar = Calendar.current
        let currentDate = Date()
        let dateFormatter = DateFormatter()
     
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: currentDate))
        guard let endDate = dateFormatter.date(from: self) else{
            return nil
        }
        guard let localEndDate = calendar.date(byAdding: .second, value: Int(timeZoneOffset),
                                                    to: endDate) else {return nil}
                
        guard let second = calendar.dateComponents([.second], from: localEndDate, to: currentDate).second else{
            return nil
        }
        
        return second
    }
    
}
