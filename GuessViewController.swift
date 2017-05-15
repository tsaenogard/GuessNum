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
            title:"說明",
            style:.plain,
            target:self,
            action:#selector(GuessViewController.explain))
        self.navigationItem.rightBarButtonItem = rightButton
        
        self.bombImageView = UIImageView(image: UIImage(named: "img1.jpg"))
        self.bombImageView.contentMode = .scaleAspectFill
        self.bombImageView.backgroundColor = UIColor.red
        self.view.addSubview(self.bombImageView)
        
        for _ in 0 ..< numOfNum {
            let textField = UITextField()
            textField.placeholder = "_"
            textField.font = UIFont(name: "Helvetica", size: 30)
            textField.adjustsFontSizeToFitWidth = true
            textField.textAlignment = .center
            textField.inputView = UIView(frame: CGRect.zero)
            textField.borderStyle = .line
            textNums.append(textField)
            self.view.addSubview(textField)
        }
        
        for i in 0 ... 9 {
            let button = UIButton()
            button.setTitle("\(i)", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor(red: 0, green: 127 / 255 , blue: 255 / 255, alpha: 1.0)
            button.layer.cornerRadius = 5.0
            button.addTarget(self, action: #selector(onBtnAction(_:)), for: .touchUpInside)
            self.numBtn.append(button)
            self.view.addSubview(button)
        }
        
        self.checkBtn = UIButton()
        self.checkBtn.setTitle("CHECK!", for: .normal)
        self.checkBtn.setTitleColor(UIColor.white, for: .normal)
        self.checkBtn.backgroundColor = UIColor.red
        self.checkBtn.layer.cornerRadius = 5.0
        self.checkBtn.addTarget(self, action: #selector(onCheckAction(_:)), for: .touchUpInside)
        self.view.addSubview(self.checkBtn)
        
        self.resultTableView = UITableView()
        self.resultTableView.delegate = self
        self.resultTableView.dataSource = self
        self.resultTableView.backgroundColor = UIColor(red: 252 / 255, green: 243 / 255, blue: 218 / 255, alpha: 1.0)
        self.view.addSubview(self.resultTableView)
        
        textNums[0].becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let gap: CGFloat = 8
        self.bombImageView.frame.size = CGSize(width: width / 2, height: height / 6)
        self.bombImageView.center = CGPoint(x: width / 2, y: height / 12)
        
        for (i,textField) in textNums.enumerated() {
            textField.frame.size = CGSize(
                width: height / 15,
                height: height / 15)
            
            textField.center = CGPoint(
                x: width * CGFloat(i + 1) / CGFloat(textNums.count + 1),
                y: self.bombImageView.frame.maxY + height / 30 + gap)}
        
        for (i,button) in numBtn.enumerated() {
            button.frame.size = CGSize(
                width: height / 18,
                height: height / 18)
            button.center = CGPoint(
                x: width / CGFloat(8) * CGFloat(i > 4 ? i - 4 : i + 1),
                y: self.textNums[0].frame.maxY + height / 36 + gap + (i > 4 ? height / 18 + gap : 0))
        }
        
        self.checkBtn.frame.size = CGSize(width: height / 9, height: 50)
        self.checkBtn.center = CGPoint(x: width * 13 / 16, y: self.numBtn[0].frame.maxY + gap / 2)
        
        self.resultTableView.frame = CGRect(
            x: width / 6,
            y: self.numBtn[9].frame.maxY + gap,
            width: width * 2 / 3,
            height: height - self.numBtn[9].frame.maxY - (navigationController?.navigationBar.frame.height)! - 6 * gap)
        print(resultTableView.frame.minY)
        print(resultTableView.frame.height)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - function
    func createAns() -> [Int] {
        var baseArray = [0,1,2,3,4,5,6,7,8,9]
        var resultArray: [Int] = []
        
        for _ in 0 ..< numOfNum {
            let randon = Int(arc4random_uniform(UInt32(baseArray.count)))
            resultArray.append(baseArray[randon])
            if !boolOfRepeat {
                baseArray.remove(at: randon)
            }
        }
        print(ansNum)
        return resultArray
    }
    
    func checkAns() -> (A: Int, B:Int, C: Int) {
        var posCorrect = 0
        var numCorrect = 0
        var repeatNum = 0
        for (ig, guess) in guessNum.enumerated() {
            var _posCOrrect = 0
            var _numCorrect = 0
            for (ia, ans) in ansNum.enumerated() {
                if guess == ans && ig == ia {
                    _posCOrrect += 1
                }else if guess == ans {
                    _numCorrect += 1
                }
            }
            if _posCOrrect + _numCorrect > 1 {
                if posCorrect == 1 {
                    repeatNum += 1
                    _numCorrect = 0
                }else {
                    repeatNum += 1
                    _numCorrect = 1
                }
            }
            posCorrect += _posCOrrect
            numCorrect += _numCorrect
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
    func onBtnAction(_ sender: UIButton) {
        for (i,textField) in textNums.enumerated() {
            if textField.isFirstResponder {
                textField.text = sender.currentTitle
                if i < textNums.count - 1 {
                    textNums[i + 1].becomeFirstResponder()
                }
                return
            }
        }
    }
    
    func onCheckAction(_ sender: UIButton) {
        
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


extension GuessViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 20)
        cell.backgroundColor = UIColor(red: 252 / 255, green: 243 / 255, blue: 218 / 255, alpha: 1.0)
        cell.textLabel?.text = resultString[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.frame =  CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30)
        label.backgroundColor = UIColor.lightGray
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = " 數字      結果 "
        label.textAlignment = .center
        
        
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
