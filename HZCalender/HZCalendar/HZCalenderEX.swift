//
//  HZCalenderEX.swift
//  CalendarTest
//
//  Created by welkj on 2017/10/25.
//  Copyright © 2017年 Heinz. All rights reserved.
//

import Foundation

extension DateComponents  {
    /**获取下一天*/
    func nextDay() -> DateComponents {
        let calendar = Calendar.current
        var date = calendar.date(from: self)
        date?.addTimeInterval(60 * 60 * 24)
        return calendar.dateComponents([.year, .month, .day], from: date!)
    }
    /**获取前一天*/
    func previousDay() -> DateComponents {
        let calendar = Calendar.current
        var date = calendar.date(from: self)
        date?.addTimeInterval(-60 * 60 * 24)
        return calendar.dateComponents([.year, .month, .day], from: date!)
    }
    /**获取下一个月*/
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
    /**获取下一年*/
    func nextYear() -> DateComponents {
        var components = DateComponents()
        components.month = self.month
        components.day = self.day
        components.year = self.year! + 1
        return components
    }
    /**获取前一月*/
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
    /**获取前一年*/
    func previousYear() -> DateComponents {
        var components = DateComponents()
        components.year = self.year! - 1
        components.month = self.month
        components.day = self.day
        return components
    }
    /**两个是不是同一天*/
    func isEque(day: DateComponents) -> Bool {
        return self.year == day.year &&
            self.month == day.month &&
            self.day == day.day
    }
    /**是不是未来的一天*/
    func isFuture() -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        let str1 = String.init(format: "%ld%02ld%02ld",
                               self.year!, self.month!, self.day!)
        let str2 = String.init(format: "%ld%02ld%02ld",
                               components.year!, components.month!, components.day!)
        let val1 = Int(str1)!
        let val2 = Int(str2)!
        if val1 > val2 {
            return true
        } else {
            return false
        }
    }
    
    
    
}

