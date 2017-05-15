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
    var pagControl: UIPageControl!
    var nextBtn: UIButton!
    
    var index = 0
    var pageHeadings = ""
    var pageImages = ""
    var pageContent = ""

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
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let gap: CGFloat = 10
        self.titleLabel.frame.size = CGSize(width: width / 3, height: 45)
        self.titleLabel.center = CGPoint(x: width / 2, y: 22.5 + gap)
        
        self.explainImageView.frame.size = CGSize(width: 200, height: 200)
        self.explainImageView.center = CGPoint(x: width / 2, y: self.titleLabel.frame.maxY + 50 + gap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
