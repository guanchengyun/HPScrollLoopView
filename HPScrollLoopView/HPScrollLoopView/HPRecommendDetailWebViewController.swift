//
//  HPRecommendDetailWebViewController.swift
//  hupu
//
//  Created by 官城云 on 2018/8/3.
//

import UIKit

class HPRecommendDetailWebViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.recommendDetailHeaderView.items = [UIColor.red,UIColor.green,UIColor.blue,UIColor.gray]
    }
    
    // MARK: - get
    
    fileprivate lazy var recommendDetailHeaderView = { () -> HPRecommendDetailHeaderView in
        let recommendDetailHeaderView = HPRecommendDetailHeaderView()
        recommendDetailHeaderView.backgroundColor = UIColor.gray
        self.view.addSubview(recommendDetailHeaderView)
        return recommendDetailHeaderView
    }()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
