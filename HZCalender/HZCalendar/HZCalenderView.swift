//
//  HZCalenderView.swift
//  CalendarTest
//
//  Created by welkj on 2017/10/25.
//  Copyright © 2017年 Heinz. All rights reserved.
//

import UIKit

class HZCalenderView: UIView, HZCalenderContentDelegate {
    
    private var contentShow: Bool = false

    private let b_title: UIButton = {
       let button = UIButton.init(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(k_color_green, for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(showOrHide), for: .touchUpInside)
        return button
    }()
    private let b_before_day: UIButton = {
        let button = UIButton.init(type: .system)
        button.tintColor = UIColor.darkGray
        button.setImage(UIImage.init(named: "ic_back_gray"), for: .normal)
        button.addTarget(self, action: #selector(beforeDay), for: .touchUpInside)
        return button
    }()
    private let b_next_day: UIButton = {
        let button = UIButton.init(type: .system)
        button.tintColor = UIColor.darkGray
        button.setImage(UIImage.init(named: "ic_forward_gray"), for: .normal)
        button.addTarget(self, action: #selector(nextDay), for: .touchUpInside)
        return button
    }()
    private let b_next_month: UIButton = {
        let button = UIButton.init(type: .system)
        button.tintColor = UIColor.darkGray
        button.setImage(UIImage.init(named: "ic_forward_gray"), for: .normal)
        button.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
        return button
    }()
    private let b_next_year: UIButton = {
        let button = UIButton.init(type: .system)
        button.tintColor = UIColor.darkGray
        button.setImage(UIImage.init(named: "ic_forward_gray"), for: .normal)
        button.addTarget(self, action: #selector(nextYear), for: .touchUpInside)
        return button
    }()
    
    private let b_before_month: UIButton = {
        let button = UIButton.init(type: .system)
        button.tintColor = UIColor.darkGray
        button.setImage(UIImage.init(named: "ic_back_gray"), for: .normal)
        button.addTarget(self, action: #selector(beforeMonth), for: .touchUpInside)
        return button
    }()
    private let b_before_year: UIButton = {
        let button = UIButton.init(type: .system)
        button.tintColor = UIColor.darkGray
        button.setImage(UIImage.init(named: "ic_back_gray"), for: .normal)
        button.addTarget(self, action: #selector(beforeYear), for: .touchUpInside)
        return button
    }()
    private let l_year: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = k_color_green
        return label
    }()
    private let l_month: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = k_color_green
        return label
    }()
    private let content: HZCalenderContent = {
        let content = HZCalenderContent.init(frame: .zero)
        return content
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        content.delegate = self
        self.addSubview(self.b_before_day)
        self.addSubview(self.b_next_day)
        self.addSubview(self.b_title)
        self.addSubview(self.content)
        self.addSubview(self.b_before_year)
        self.addSubview(self.b_next_year)
        self.addSubview(self.b_before_month)
        self.addSubview(self.b_next_month)
        self.addSubview(self.l_year)
        self.addSubview(self.l_month)
    }
    
    // MARK: - Actions
    @objc func showOrHide() {
        contentShow = !contentShow
        if contentShow {
            
        } else {
            
        }
    }
    @objc func nextDay() {
        content.nextDay()
    }
    
    @objc func nextMonth() {
        content.nextMonth()
    }
    
    @objc func nextYear() {
        content.nextYear()
    }
    
    @objc func beforeDay() {
        content.beforeDay()
    }
    
    @objc func beforeMonth() {
        content.beforeMonth()
    }
    
    @objc func beforeYear() {
        content.beforeYear()
    }
    
    func newSelect(day: String) {
        b_title.setTitle(day, for: .normal)
    }
   
    func newPage(year: String, month: String) {
        l_year.text = year
        l_month.text = month
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.frame.size.width
        let height = self.frame.size.height
        b_before_day.frame = CGRect.init(x: 0, y: 0, width: 60, height: 48)
        b_title.frame = CGRect.init(x: b_before_day.frame.maxX,
                                    y: 0, width: width - 120, height: 48)
        b_next_day.frame = CGRect.init(x: b_title.frame.maxX, y: 0, width: 60, height: 48)
        b_before_year.frame = CGRect.init(x: 0, y: b_next_day.frame.maxY, width: 50, height: 44)
        l_year.frame = CGRect.init(x: b_before_year.frame.maxX,
                                   y: b_next_day.frame.maxY, width: width*0.5 - 120, height: 44)
        b_next_year.frame = CGRect.init(x: l_year.frame.maxX,
                                        y: b_next_day.frame.maxY, width: 50, height: 44)
        b_before_month.frame = CGRect.init(x: b_next_year.frame.maxX + 40,
                                           y: b_next_day.frame.maxY, width: 50, height: 44)
        l_month.frame = CGRect.init(x: b_before_month.frame.maxX,
                                    y: b_next_day.frame.maxY, width: width*0.5 - 120, height: 44)
        b_next_month.frame = CGRect.init(x: l_month.frame.maxX,
                                         y: b_next_day.frame.maxY, width: 50, height: 44)
        content.frame = CGRect.init(x: 0, y: b_next_month.frame.maxY,
                                    width: width, height: height - b_next_month.frame.maxY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
