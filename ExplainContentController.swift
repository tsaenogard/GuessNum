//
//  ExplainContentController.swift
//  GuessNum
//
//  Created by Eric Chen on 2017/5/14.
//  Copyright © 2017年 MasB1ue. All rights reserved.
//

import UIKit

class ExplainContentController: UIViewController {
    
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var titleLabel: UILabel!
    var explainImageView: UIImageView!
    var contentLabel: UILabel!
    var pageControl: UIPageControl!
    var nextBtn: UIButton!
    
    var index = 0
    var pageHeadings = ""
    var pageImages = ""
    var pageContent = ""
    var pageHeight = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        self.titleLabel = UILabel()
        self.titleLabel.font = UIFont(name: "Helvetica", size: 30)
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = UIColor.darkGray
        self.titleLabel.text = pageHeadings
        self.view.addSubview(self.titleLabel)
        
        self.explainImageView = UIImageView(image: UIImage(named: pageImages))
        self.explainImageView.contentMode = .scaleToFill
        self.view.addSubview(self.explainImageView)
        
        self.contentLabel = UILabel()
        self.contentLabel.font = UIFont(name: "Helvetica", size: 20)
        self.contentLabel.textAlignment = .center
        self.contentLabel.numberOfLines = 0
        self.contentLabel.textColor = UIColor.darkGray
        self.contentLabel.text = pageContent
        self.view.addSubview(self.contentLabel)
        
        self.pageControl = UIPageControl()
        self.pageControl.numberOfPages = 4
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPage = index
        self.view.addSubview(self.pageControl)
        
        self.nextBtn = UIButton()
        self.nextBtn.setTitleColor(UIColor.blue, for: .normal)
        self.nextBtn.addTarget(self, action: #selector(nextBtnAction(_:)), for: .touchUpInside)
        if case 0 ... 2 = index {
            nextBtn.setTitle("NEXT", for: .normal)
        }else if case 3 = index {
            nextBtn.setTitle("DONE", for: .normal)
        }
        self.view.addSubview(self.nextBtn)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let gap: CGFloat = 10
        self.titleLabel.frame.size = CGSize(width: width, height: 45)
        self.titleLabel.center = CGPoint(x: width / 2, y: 22.5 + gap * 3)
        
        self.explainImageView.frame.size = CGSize(width: 200, height: 180)
        self.explainImageView.center = CGPoint(x: width / 2, y: self.titleLabel.frame.maxY + 100 + gap)
        
        self.contentLabel.frame.size = CGSize(width: width, height: CGFloat(24 * pageHeight))
        self.contentLabel.center = CGPoint(x: width / 2, y: self.explainImageView.frame.maxY + self.contentLabel.frame.height / 2 + gap)
        
        self.pageControl.frame.size = CGSize(width: width / 2, height: 40)
        self.pageControl.center = CGPoint(x: width / 2, y: height - 20)
        
        self.nextBtn.frame.size = CGSize(width: 50, height: 40)
        self.nextBtn.center = CGPoint(x: width - 25 - gap , y: self.pageControl.frame.midY)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextBtnAction(_ sender: UIButton) {
        if case 0...2 = index {
            let pageViewController = parent as! ExplainPageController
            pageViewController.forward(index: index)
        }else if case 3 = index {
            UserDefaults.standard.set(true, forKey: "hasViewedExplain")
            dismiss(animated: true, completion: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
