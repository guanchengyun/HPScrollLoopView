//
//  ViewController.swift
//  HPScrollLoopView
//
//  Created by 官城云 on 2018/8/3.
//  Copyright © 2018年 guan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: - action
    
    @IBAction func buttonAction(_ sender: Any) {
        self.recommendDetailHeaderView.items = [UIColor.red,UIColor.green,UIColor.blue,UIColor.gray]
    }
    
    
    // MARK: - get
    fileprivate lazy var recommendDetailHeaderView = { () -> HPRecommendDetailHeaderView in
        let recommendDetailHeaderView = HPRecommendDetailHeaderView()
        recommendDetailHeaderView.backgroundColor = UIColor.gray
        recommendDetailHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
        self.view.addSubview(recommendDetailHeaderView)
        return recommendDetailHeaderView
    }()


}

