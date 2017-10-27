//
//  HZCalenderCell.swift
//  CalendarTest
//
//  Created by welkj on 2017/10/25.
//  Copyright © 2017年 Heinz. All rights reserved.
//

import UIKit

class HZCalenderCell: UICollectionViewCell {
    
    var label: UILabel = UILabel.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.layer.cornerRadius = 13
        label.clipsToBounds = true
        self.addSubview(label)
        
        //约束
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 26))
        self.addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 26))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
