//
//  ExplainPageController.swift
//  GuessNum
//
//  Created by Eric Chen on 2017/5/14.
//  Copyright © 2017年 MasB1ue. All rights reserved.
//

import UIKit


class ExplainPageController: UIPageViewController {
    
    var pageHeadings = ["設定位數","設定重複","開始遊戲","C的說明"]
    var pageImages = ["ex1.jpg","ex2.jpg","ex3.jpg","ex4.PNG"]
    var pageContent = ["藉由調整拉桿決定數字的位數\n4-容易\n5-適中\n6-困難","藉由啟動開關決定數字是否重複\n不重複-容易\n重複-困難","當輸入數字後，會對數字進行\n判定，以ABC三個級別顯示\nA-位置跟數字皆正確。。。\nB-有這個數字但位置不正確\nＣ-有這個數字且重複出現。\nPS:Ｃ只會在重複關卡出現", "當輸入的數字\n出現重複時\n便會記成1C\nPS:跟重複的次數無關"]
    var pageHeight = [4,3,6,4]
    
    var canceal: Bool = true //隱藏彩蛋
    var ansString: String = "" //答案
    
     
//    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
//        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        
        if let startViewController = contentViewController(at: 0) {  //設定初始頁
            setViewControllers([startViewController], direction: .forward, animated: true, completion: nil)
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func forward(index: Int) {  //往前翻
        if let nextViewController = contentViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func contentViewController(at index: Int) -> ExplainContentController? { //設定頁面
        var startPage = 0
        if !canceal {
            startPage = -1
        }
        if index < startPage || index >= pageHeadings.count {
            return nil
        }
        
        let contentController = ExplainContentController()
        if index == -1 {
            contentController.pageContent = "答案是：\(ansString)"
            contentController.index = index

            return contentController
        }
        contentController.pageHeadings = pageHeadings[index]
        contentController.pageImages = pageImages[index]
        contentController.pageContent = pageContent[index]
        contentController.index = index
        contentController.pageHeight = pageHeight[index]
        
        return contentController
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

extension ExplainPageController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ExplainContentController).index
        index += 1
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ExplainContentController).index
        index -= 1
        
        return contentViewController(at: index)
    }
}



