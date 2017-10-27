//
//  HZCalenderEX.swift
//  CalendarTest
//
//  Created by welkj on 2017/10/25.
//  Copyright © 2017年 Heinz. All rights reserved.
//

import Foundation

extension DateComponents  {
    
    func nextDay() -> DateComponents {
        let calendar = Calendar.current
        var date = calendar.date(from: self)
        date?.addTimeInterval(60 * 60 * 24)
        return calendar.dateComponents([.year, .month, .day], from: date!)
    }
    
    func previousDay() -> DateComponents {
        let calendar = Calendar.current
        var date = calendar.date(from: self)
        date?.addTimeInterval(-60 * 60 * 24)
        return calendar.dateComponents([.year, .month, .day], from: date!)
    }
    
    func nextMonth() -> DateComponents {
        var components = DateComponents()
        components.year = self.year
        components.day = self.day
        if (self.month == 12) {
            components.month = 1
            components.year = self.year! + 1
        } else {
            components.month = self.month! + 1
        }
        components.day = self.day
        return components
    }
    
    func nextYear() -> DateComponents {
        var components = DateComponents()
        components.month = self.month
        components.day = self.day
        components.year = self.year! + 1
        return components
    }
    
    func previousMonth() -> DateComponents {
        var components = DateComponents()
        components.year = self.year
        components.day = self.day
        if (self.month == 1) {
            components.month = 12
            components.year = self.year! - 1
        } else {
            components.month = self.month! - 1
        }
        return components
    }
    
    func previousYear() -> DateComponents {
        var components = DateComponents()
        components.year = self.year! - 1
        components.month = self.month
        components.day = self.day
        return components
    }
    
    func isEque(day: DateComponents) -> Bool {
        return self.year == day.year &&
            self.month == day.month &&
            self.day == day.day
    }
    
    func isFuture() -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        let str1 = "\(self.year!)\(self.month!)\(self.day!)"
        let str2 = "\(components.year!)\(components.month!)\(components.day!)"
        let val1 = Int(str1)!
        let val2 = Int(str2)!
        if val1 > val2 {
            return true
        } else {
            return false
        }
    }
    
    
    
}

