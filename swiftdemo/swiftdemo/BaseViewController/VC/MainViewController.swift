//
//  MainViewController.swift
//  swiftdemo
//
//  Created by qf on 2020/3/9.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

override func viewDidLoad() {
        super.viewDidLoad()
    self.view.backgroundColor = RGBAColor(255,255,255)
         // Do any additional setup after loading the view.
    
       self.view.addSubview(self.TimeLab)
       self.view.addSubview(self.TimeLab1)
       self.view.addSubview(self.timeBtn)
       self.view.addSubview(self.timeBtn2)
        }
            
        class InterviewTest {
           var name: String
           lazy var greeting : String = { return "Hello \(self.name)" }()
            // 这里没有循环引用 ..

           init(name: String) {
                self.name = name
            }
        }

        struct InterviewCandidate {
            var isIos:Bool?
            lazy var iOSResumeDescription:String = {
               return "I am an ios developer"
            }()
                
            lazy var androidResumeDescription:String = {
                return "I am an android developer"
            }()
           }
    
       lazy var TimeLab:UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 15, y: 250, width:100, height: 30))
        label.textColor = RGBAColor(155, 155, 155)
         label.font = UIFont.systemFont(ofSize: 12)
         label.text = "Time1:"
        return label
    }()
    
       lazy var TimeLab1:UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 150, y: 250, width:100, height: 30))
        label.textColor = RGBAColor(155, 155, 155)
         label.font = UIFont.systemFont(ofSize: 12)
         label.text = "Time2:"
        return label
    }()
    
    
    @objc func TimeClickBtn(btn:UIButton){
        CountdownTimer.startTimer(key: .test1, count: 60) { [weak self] (count, finish) in
            self?.TimeLab.text = finish ? "Time1:Finished" : "Time1:\(count)"
        }
        
    }
    @objc func TimeClickBtn2(){
        CountdownTimer.startTimer(key: .test2, count: 10) { [weak self] (count, finish) in
            self?.TimeLab1.text = finish ? "Time1:Finished" : "Time1:\(count)"
        }
        
    }
    lazy var timeBtn:UIButton = {
        let timebtn = UIButton.init(frame: CGRect.init(x: 15, y: 300, width: 100, height: 30))
        timebtn.setTitle("Start Timer1", for: UIControl.State.normal)
        timebtn.backgroundColor = UIColor.red
        timebtn.layer.cornerRadius = 20
        timebtn.layer.masksToBounds = true
        timebtn.addTarget(self, action: #selector(TimeClickBtn(btn:)), for: .touchUpInside)
        return timebtn
    }()
    
    lazy var timeBtn2:UIButton = {
        let timebtn = UIButton.init(frame: CGRect.init(x: 150, y: 300, width: 100, height: 30))
        timebtn.setTitle("Start Timer2", for: UIControl.State.normal)
        timebtn.backgroundColor = UIColor.red
        timebtn.layer.cornerRadius = 20
        timebtn.layer.masksToBounds = true
        timebtn.addTarget(self, action: #selector(TimeClickBtn2), for: .touchUpInside)
        return timebtn
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        CountdownTimer.stopTimer(key: .test1)
    }
}
/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

