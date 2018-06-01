//
//  Util.swift
//  TesteCedroIOS
//
//  Created by pc on 31/05/18.
//  Copyright © 2018 pc. All rights reserved.
//

import UIKit

class Util: NSObject {
    class func getDateFromString(tempString: String?) -> Date? {
        guard let dateString = tempString else {
            return nil
        }
        let dateFormater = DateFormatter()
        dateFormater.timeZone = TimeZone.current
        dateFormater.locale = Locale(identifier: "pt_BR")
        dateFormater.isLenient = true
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        return dateFormater.date(from: dateString)
        
    }
    class func formatBackDateString(dateString: String) -> String {
        
        
        let date = self.getDateFromString(tempString: dateString)
        let dateFormater = DateFormatter()
        dateFormater.timeZone = TimeZone.current
        dateFormater.locale = Locale(identifier: "pt_BR")
        dateFormater.isLenient = true
        dateFormater.timeZone = TimeZone.current
        
        
        dateFormater.dateFormat = "dd/MM/yyyy - HH:mm"
        print(date)
        if date == nil {
            return ""
        }
        return dateFormater.string(from: date!)
    }
}
