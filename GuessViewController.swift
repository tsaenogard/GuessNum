//
//  GuessViewController.swift
//  GuessNum
//
//  Created by Eric Chen on 2017/5/14.
//  Copyright © 2017年 MasB1ue. All rights reserved.
//

import UIKit

class GuessViewController: UIViewController {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var bombImageView: UIImageView!
    var textNums: [UITextField] = []
    var numBtn: [UIButton] = []
    var checkBtn: UIButton!
    var resultTableView: UITableView!
    
    var ansNum: [Int] = []
    var guessNum: [Int] = []
    var resultString: [String] = []
    
    var numOfNum: Int = 0
    var boolOfRepeat: Bool = false
    let hide:Bool =  true
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //導覽列設定
        self.view.backgroundColor = UIColor.white
        self.title = "Guess"
        self.navigationController?.navigationBar.barTintColor =
            UIColor(red: 210 / 255, green: 105 / 255, blue: 30 / 255, alpha: 0.5)
        self.navigationController?.navigationBar.isTranslucent = false
        let rightButton = UIBarButtonItem(
            title:"設定",
            style:.plain,
            target:self,
            action:#selector(GuessViewController.explain))
        self.navigationItem.rightBarButtonItem = rightButton
        
        self.bombImageView = UIImageView(image: UIImage(named: "img1.jpg"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - function
    func createAns() -> [Int] {
        var baseArray = [0,1,2,3,4,5,6,7,8,9]
        var resultArray: [Int] = []
        
        for i in 0 ..< numOfNum {
            let randon = Int(arc4random_uniform(UInt32(baseArray.count)))
            resultArray.append(baseArray[randon])
            if !boolOfRepeat {
                baseArray.remove(at: randon)
            }
        }
        return resultArray
    }
    
    func checkAns() -> (A: Int, B:Int, C: Int) {
        var posCorrect = 0
        var numCorrect = 0
        var repeatNum = 0
        for (ig, guess) in guessNum.enumerated() {
            for (ia, ans) in ansNum.enumerated() {
                var _posCOrrect = 0
                var _numCorrect = 0
                if guess == ans && ig == ia {
                    _posCOrrect += 1
                }else if guess == ans {
                    _numCorrect += 1
                }
                

            }
        }
        
        return (posCorrect, numCorrect, repeatNum)
    }
    
    func explain() {
        let pageViewController = ExplainPageController()
        var ansString = ""
        pageViewController.canceal = false
        for int in ansNum {
            ansString.append(String(int))
        }
        pageViewController.ansString = ansString
        self.present(pageViewController, animated: true, completion: nil)
        
    }
    //MARK: - Button
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
