//
//  ViewController.swift
//  HZCalender
//
//  Created by welkj on 2017/10/27.
//  Copyright © 2017年 Heinz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let calendar: HZCalenderView = HZCalenderView.init(frame:.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(calendar)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calendar.frame = CGRect.init(x: 0, y: 64, width: self.view.frame.size.width, height: 300)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

