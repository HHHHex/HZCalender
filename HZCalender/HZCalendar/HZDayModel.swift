//
//  HZDayModel.swift
//  CalendarTest
//
//  Created by welkj on 2017/10/25.
//  Copyright © 2017年 Heinz. All rights reserved.
//

import UIKit

class HZDayModel {
    
    var isEnable: Bool = false
    var year_month_day: DateComponents = DateComponents()
    
    class func creatDays(by components: DateComponents) -> [HZDayModel] {
        let calendar = Calendar.current
        let date = calendar.date(from: components)!
        //***总天数
        let current_total_days = calendar.range(of: .day, in: .month, for: date)!.count
        //到这个月的一号
        var edit_comp = calendar.dateComponents([.year, .month, .day], from: date)
        edit_comp.day = 1
        let date_first = calendar.date(from: edit_comp)!
        //***第一天是星期几
        let first_weekday = calendar.ordinality(of: .weekday, in: .weekOfMonth, for: date_first)! - 1
        //到上一个月
        if (edit_comp.month == 1) {
            edit_comp.month = 12
            edit_comp.year! -= 1
        } else {
            edit_comp.month! -= 1
        }
        let date_pre_month = calendar.date(from: edit_comp)!
        //***上一个月的总天数
        let past_total_days = calendar.range(of: .day, in: .month, for: date_pre_month)!.count
        var ary: [HZDayModel] = []
        for index in 0...42 {
            let model = HZDayModel()
            model.year_month_day.year = components.year
            model.year_month_day.month = components.month
            if (index < first_weekday) {// 上月
                let day = past_total_days - (first_weekday - index) + 1
                if (components.month == 1) {
                    model.year_month_day.month = 12
                    model.year_month_day.year = components.year! - 1
                } else {
                    model.year_month_day.month = components.month! - 1
                }
                model.year_month_day.day = day
                model.isEnable = false
            } else if (index >= first_weekday + current_total_days) {//下月
                let day = index - first_weekday - current_total_days + 1
                if (components.month == 12) {
                    model.year_month_day.month = 1
                    model.year_month_day.year = components.year! + 1
                } else {
                    model.year_month_day.month = components.month! + 1
                }
                model.year_month_day.day = day
                model.isEnable = false
            } else {//当月
                let day = index - first_weekday + 1
                model.year_month_day.day = day
                model.isEnable = true
            }
            ary.append(model)
        }
        return ary
    }
    
}
