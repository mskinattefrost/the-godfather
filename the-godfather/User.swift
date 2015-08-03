//
//  User.swift
//  the-godfather
//
//  Created by Marvin Allan Lu on 7/21/15.
//  Copyright (c) 2015 SourcePad. All rights reserved.
//

import Foundation

class User {
    
    var firstName: String?
    var lastName: String?
    var birthDate: String?
    var nickname: String?
    
    var father: Dictionary<String, AnyObject>?
    var mother: Dictionary<String, AnyObject>?
    var id: String?
    
    init(id: String, object: Dictionary<String, AnyObject>) {
        self.id = id as String
        self.firstName = object["first_name"] as? String
        self.lastName = object["last_name"] as? String
        self.nickname = object["nickname"] as? String
        self.birthDate = object["birthday"] as? String
        
        self.mother = object["mother"] as? Dictionary<String, AnyObject>
        self.father = object["father"] as? Dictionary<String, AnyObject>
        
    }
    
    func reverseFullName() -> String {
        return "\(lastName!), \(firstName!)"
    }
    
    func fullName() -> String {
        return "\(firstName!) \(lastName!)"
    }
    
    func fullNameNick() -> String {
        if let nick = nickname {
            return "\(firstName!) \"\(nick)\" \(lastName!)"
        } else {
            return self.fullName()
        }
    }
    
    func motherFullName() -> String {
        let firstName = self.mother?["first_name"] as! String
        let lastName = self.mother?["last_name"] as! String
        
        return "\(firstName) \(lastName)"
    }
    
    func fatherFullName() -> String {
        let firstName = self.father?["first_name"] as! String
        let lastName = self.father?["last_name"] as! String
        
        return "\(firstName) \(lastName)"
    }
    
    func ageDisplay() -> String {
                
        if !self.birthDate!.isEmpty {
            var calendar: NSCalendar = NSCalendar.currentCalendar()
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            let formattedDate = dateFormatter.dateFromString(self.birthDate!)
            
            let ageComponents = calendar.components(.CalendarUnitYear,
                fromDate: formattedDate!,
                toDate: NSDate(),
                options: nil)
            let age = ageComponents.year
            
            return "\(age)"
        } else {
            return "n/a"
        }
        
    }
    
    
}
