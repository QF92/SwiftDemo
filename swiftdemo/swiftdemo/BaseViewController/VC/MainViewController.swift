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

                // Do any additional setup after loading the view.
                let viewpe = UIView.init(frame: CGRect(x: 100,y: 100,width: 100,height: 100))
                viewpe.backgroundColor = UIColor.red
                viewpe.alpha = 1.5
                self.view.addSubview(viewpe)
            }
            
        //    lazy var name: String = {
        //        return "BY"
        //    }()
            
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

        }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

