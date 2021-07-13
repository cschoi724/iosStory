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
        guard let endDate = dateFormatter.date(from: self) else{
            return nil
        }
        
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: currentDate))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset),
                                                    to: currentDate) else {return nil}

        guard let second = calendar.dateComponents([.second], from: endDate, to: localDate).second else{
            return nil
        }

        return second
    }
    
}
