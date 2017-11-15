//
//  HZCalenderContent.swift
//  CalendarTest
//
//  Created by welkj on 2017/10/25.
//  Copyright © 2017年 Heinz. All rights reserved.
//

import UIKit

protocol HZCalenderContentDelegate: NSObjectProtocol {
    func newSelect(day: String)
    func newPage(year: String, month: String)
}

class HZCalenderContent: UIView {
    
    weak var delegate: HZCalenderContentDelegate? {
        didSet {
            let calendar = Calendar.current
            /**初始化月份的符号*/
            let month = calendar.shortMonthSymbols[cur_year_month.month! - 1]
            delegate?.newPage(year: "\(cur_year_month.year!)", month: month)
            delegate?.newSelect(day: "\(select_day.year!)-\(select_day.month!)-\(select_day.day!)")
        }
    }
    
    private let reuseId = "HZCalenderCell"
    private let dayLabels: [UILabel] = {
        var ary: [UILabel] = []
        for index in 0...6 {
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12)
            /**周的符号*/
            label.text = Calendar.current.shortWeekdaySymbols[index]
            label.textColor = k_color_dark
            ary.append(label)
        }
        return ary
    }()
    
    private let scrollView: UIScrollView = UIScrollView()
    private let collectionL: UICollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let collectionM: UICollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let collectionR: UICollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var select_day: DateComponents = {
        return Calendar.current.dateComponents([.year, .month, .day], from: Date())
    }()
    private var cur_year_month: DateComponents = Calendar.current.dateComponents([.year, .month], from: Date()) {
        willSet {
            days_left = HZDayModel.creatDays(by: newValue.previousMonth())
            days_middle = HZDayModel.creatDays(by: newValue)
            days_right = HZDayModel.creatDays(by: newValue.nextMonth())
            /**月份的符号*/
            let calendar = Calendar.current
            let month = calendar.shortMonthSymbols[newValue.month! - 1]
            delegate?.newPage(year: "\(newValue.year!)", month: month)
        }
    }
    private var days_left: [HZDayModel] = [] {
        didSet { collectionL.reloadData() }
    }
    private var days_middle: [HZDayModel] = [] {
        didSet { collectionM.reloadData() }
    }
    private var days_right: [HZDayModel] = [] {
        didSet { collectionR.reloadData() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.onCreat()
        days_left = HZDayModel.creatDays(by: cur_year_month.previousMonth())
        days_middle = HZDayModel.creatDays(by: cur_year_month)
        days_right = HZDayModel.creatDays(by: cur_year_month.nextMonth())
    }
    func nextDay() {
        let nextday = select_day.nextDay()
        if nextday.isFuture() {
            return
        }
        select_day = nextday
        collectionL.reloadData()
        collectionM.reloadData()
        collectionR.reloadData()
        delegate?.newSelect(day: "\(select_day.year!)-\(select_day.month!)-\(select_day.day!)")
    }
    
    func nextMonth() {
        cur_year_month = cur_year_month.nextMonth()
    }
    
    func nextYear() {
        cur_year_month = cur_year_month.nextYear()
    }
    
    func beforeDay() {
        select_day = select_day.previousDay()
        collectionL.reloadData()
        collectionM.reloadData()
        collectionR.reloadData()
        delegate?.newSelect(day: "\(select_day.year!)-\(select_day.month!)-\(select_day.day!)")
    }
    
    func beforeMonth() {
        cur_year_month = cur_year_month.previousMonth()
    }
    
    func beforeYear() {
        cur_year_month = cur_year_month.previousYear()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.x < scrollView.bounds.size.width) {// 向左
            cur_year_month = cur_year_month.previousMonth()
        } else if (scrollView.contentOffset.x > scrollView.bounds.size.width) {
            cur_year_month = cur_year_month.nextMonth()
        }
        scrollView.setContentOffset(collectionM.frame.origin, animated: false)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.bounds.size.width
        let labelWidth = width / 7
        for index in 0...(dayLabels.count - 1) {
            let label = dayLabels[index]
            label.frame = CGRect.init(x: labelWidth*CGFloat(index), y: 0, width: labelWidth, height: 22)
        }
        let height = self.bounds.size.height - 22
        scrollView.frame = CGRect.init(x: 0, y: 22, width: width, height: height)
        scrollView.contentSize = CGSize.init(width: width*3, height: height)
        collectionL.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
        collectionM.frame = CGRect.init(x: width, y: 0, width: width, height: height)
        collectionR.frame = CGRect.init(x: width*2, y: 0, width: width, height: height)
        scrollView.setContentOffset(collectionM.frame.origin, animated: false)
    }
    
    private func onCreat() {
        for label in dayLabels {
            self.addSubview(label)
        }
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        self.addSubview(scrollView)
        collectionL.delegate = self
        collectionL.dataSource = self
        collectionL.backgroundColor = UIColor.white
        collectionL.register(HZCalenderCell.classForCoder(), forCellWithReuseIdentifier: reuseId)
        collectionM.delegate = self
        collectionM.dataSource = self
        collectionM.backgroundColor = UIColor.white
        collectionM.register(HZCalenderCell.classForCoder(), forCellWithReuseIdentifier: reuseId)
        collectionR.delegate = self
        collectionR.dataSource = self
        collectionR.backgroundColor = UIColor.white
        collectionR.register(HZCalenderCell.classForCoder(), forCellWithReuseIdentifier: reuseId)
        scrollView.addSubview(collectionL)
        scrollView.addSubview(collectionM)
        scrollView.addSubview(collectionR)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HZCalenderContent: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollView.setContentOffset(collectionM.frame.origin, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42 //(6*7)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! HZCalenderCell
        var ary: [HZDayModel]!
        if collectionView == collectionL {
            ary = days_left
        } else if collectionView == collectionM {
            ary = days_middle
        } else if collectionView == collectionR {
            ary = days_right
        }
        let day = ary[indexPath.row]
        cell.label.text = "\(day.year_month_day.day!)"
        if day.isEnable && day.year_month_day.isEque(day: select_day) {
            cell.label.backgroundColor = k_color_blue
            cell.label.textColor = UIColor.white
        } else if day.isEnable {
            cell.label.backgroundColor = UIColor.white
            cell.label.textColor = UIColor.darkText
        } else {
            cell.label.backgroundColor = UIColor.white
            cell.label.textColor = UIColor.lightGray
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var ary: [HZDayModel]!
        if collectionView == collectionL {
            ary = days_left
        } else if collectionView == collectionM {
            ary = days_middle
        } else if collectionView == collectionR {
            ary = days_right
        }
        let day = ary[indexPath.row]
        if day.year_month_day.isFuture() {
            return
        }
        if day.isEnable {
            self.select_day = day.year_month_day
            collectionL.reloadData()
            collectionM.reloadData()
            collectionR.reloadData()
            delegate?.newSelect(day: "\(select_day.year!)-\(select_day.month!)-\(select_day.day!)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let height = collectionView.frame.size.height
        return CGSize.init(width: width / 7, height: height / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
