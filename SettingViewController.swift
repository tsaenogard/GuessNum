//
//  SettingViewController.swift
//  GuessNum
//
//  Created by Eric Chen on 2017/5/14.
//  Copyright © 2017年 MasB1ue. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    
    var titleImageView: UIImageView!
    var numStackView: UIStackView!
    var repeatStackView: UIStackView!
    var goBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //導覽列設定
        self.view.backgroundColor = UIColor.white
        self.title = "Setting"
        self.navigationController?.navigationBar.barTintColor =
            UIColor(red: 210 / 255, green: 105 / 255, blue: 30 / 255, alpha: 0.5)
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationController?.navigationBar.isTranslucent = false
        let rightButton = UIBarButtonItem(
            title:"說明",
            style:.plain,
            target:self,
            action:#selector(SettingViewController.explain))
        self.navigationItem.rightBarButtonItem = rightButton
        
        self.titleImageView = UIImageView(image: UIImage(named: "title.PNG"))
        self.titleImageView.contentMode = .scaleAspectFit
        self.view.addSubview(self.titleImageView)
        
        self.numStackView = UIStackView()
        let slider = UISlider()
        slider.maximumValue = 6.0
        slider.minimumValue = 4.0
        slider.value = 4.0
        slider.addTarget(self, action: #selector(onSlider(_:)), for: .valueChanged)
        self.numStackView.addArrangedSubview(slider)
        let numLabel = UILabel()
        numLabel.text = "4"
        numLabel.textColor = UIColor.darkGray
        numLabel.font = UIFont(name: "Helvetica", size: 30)
        self.numStackView.addArrangedSubview(numLabel)
        self.numStackView.axis = .horizontal
        self.numStackView.spacing = 20
        self.numStackView.alignment = .fill
        self.view.addSubview(self.numStackView)
        
        self.repeatStackView = UIStackView()
        let repeatLabel = UILabel()
        repeatLabel.text = "重複"
        repeatLabel.textColor = UIColor.darkGray
        repeatLabel.font = UIFont(name: "Helvetica", size: 26)
        self.repeatStackView.addArrangedSubview(repeatLabel)
        let repeatSwitch = UISwitch()
        repeatSwitch.isOn = false
        self.repeatStackView.addArrangedSubview(repeatSwitch)
        self.repeatStackView.axis = .horizontal
        self.repeatStackView.spacing = 20
        self.repeatStackView.alignment = .fill
        self.view.addSubview(self.repeatStackView)
        
        self.goBtn = UIButton()
        self.goBtn.layer.borderWidth = 1.0
        self.goBtn.layer.cornerRadius = 8.0
        self.goBtn.setTitle("GO!", for: .normal)
        self.goBtn.setTitleColor(UIColor.blue, for: .normal)
        self.goBtn.addTarget(self, action: #selector(onGoBtn(_:)), for: .touchUpInside)
        self.view.addSubview(self.goBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let gap: CGFloat = 30
        self.titleImageView.frame.size = CGSize(width: width * 2 / 3, height: height / 4 + gap)
        self.titleImageView.center = CGPoint(x: width / 2, y: height / 8)
        
        self.numStackView.frame.size = CGSize(width: width / 3, height: 30)
        self.numStackView.center = CGPoint(x: width / 2, y: self.titleImageView.frame.maxY + gap )
        
        self.repeatStackView.frame.size = CGSize(width: width / 3, height: 30)
        self.repeatStackView.center = CGPoint(x: width / 2, y: self.numStackView.frame.maxY + gap )
        
        self.goBtn.frame.size = CGSize(width: 80, height: 50)
        self.goBtn.center = CGPoint(x: width / 2, y: self.repeatStackView.frame.maxY + gap * 2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.bool(forKey: "hasViewedExplain") {
            return
        }
        let pageViewController = ExplainPageController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            self.present(pageViewController, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func explain() {
        let pageViewController = ExplainPageController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.present(pageViewController, animated: true, completion: nil)
    }
    
    func onGoBtn(_ sender: UIButton) {
        let goViewController = GuessViewController()
        goViewController.numOfNum = Int((numStackView.subviews[0] as! UISlider).value)
        goViewController.boolOfRepeat = (repeatStackView.subviews[1] as! UISwitch).isOn
        
        self.navigationController?.pushViewController(goViewController, animated: true)
    }
    
    func onSlider(_ sender: UISlider) {
        (numStackView.subviews[1] as! UILabel).text = String(Int(sender.value))
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
