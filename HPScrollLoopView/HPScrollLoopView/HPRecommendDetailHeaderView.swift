//
//  HPRecommendDetailHeaderView.swift
//  hupu
//
//  Created by 官城云 on 2018/8/3.
//

import UIKit

fileprivate enum LocationScroll:CGFloat {
    case left = 0.0
    case center = 1.0
    case right = 2.0
}

class HPRecommendDetailHeaderView: UIView {
    private var indexOfCurrent: Int!
    @objc open var items: [UIColor] = [] {
        didSet {
            self.reloadData()
        }
    }
    fileprivate var catchScrollViews:[UIView] = []
    fileprivate var subScrollViews:[UIView] = []

    fileprivate lazy var contentScrollView = { () -> UIScrollView in
        let contentScrollView = UIScrollView()
        contentScrollView.frame = self.bounds
        contentScrollView.bounces = false
        contentScrollView.contentSize = CGSize(width: self.frame.size.width*3, height: self.frame.size.height)
        contentScrollView.isPagingEnabled = true
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.delegate = self
        self.addSubview(contentScrollView)
        contentScrollView.setContentOffset(CGPoint(x: self.frame.size.width, y: 0), animated: false)
        return contentScrollView
    }()
    
    func reloadData() {
        self.indexOfCurrent = 0
        self.loadSubScrollViews()
    }
    
    func loadSubScrollViews() {
        self.loadView(block: self.creatView, locationScroll: .left)
        self.loadView(block: self.creatView, locationScroll: .center)
        self.loadView(block: self.creatView, locationScroll: .right)
    }
    
    func creatView() -> UIView {
        if ((self.catchScrollViews.first) != nil) {
            let view = self.catchScrollViews.first
            self.catchScrollViews.removeFirst()
            return (view)!;
        }else {
            let view = UIView()
            view.frame = self.contentScrollView.bounds
            return view
        }
    }


    fileprivate func loadView(block: @escaping() -> (UIView), locationScroll:LocationScroll) {
        var index:Int
        switch locationScroll {
            case .left: do {
                index = self.indexOfCurrent - 1
                if index < 0 {
                    index = self.items.count - 1
                }
            }
            case .center: do {
                index = self.indexOfCurrent
                }
            case .right: do {
                index = self.indexOfCurrent + 1
                if index >= self.items.count {
                    index = 0
                }
            }
        }
        
        let view = block()
        view.frame.origin.x = locationScroll.rawValue*self.contentScrollView.frame.size.width
        self.contentScrollView.addSubview(view)
        self.subScrollViews.append(view)
        view.backgroundColor = self.items[index]
    }
}

extension HPRecommendDetailHeaderView:UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //如果用户手动拖动到了一个整数页的位置就不会发生滑动了 所以需要判断手动调用滑动停止滑动方法
        if !decelerate {
            self.scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.x
        if offset == 0 {
            self.indexOfCurrent = self.indexOfCurrent - 1
            if self.indexOfCurrent < 0 {
                self.indexOfCurrent = self.items.count-1
            }
        }else if offset == self.frame.size.width * 2 {
            self.indexOfCurrent = self.indexOfCurrent + 1
            if self.indexOfCurrent >= self.items.count {
                self.indexOfCurrent = 0
            }
        }
        self.catchScrollViews += self.subScrollViews
        self.subScrollViews.removeAll()
        
        self.loadSubScrollViews()
        //布局后把contentOffset设为中间
        scrollView.setContentOffset(CGPoint(x: self.frame.size.width, y: 0), animated: false)
    }
    
    // 时间触发器 设置滑动时动画true，会触发的方法
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(self.contentScrollView)
    }
}
