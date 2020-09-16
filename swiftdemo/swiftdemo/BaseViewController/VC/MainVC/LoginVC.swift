//
//  LoginVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/9.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class Person: NSObject {

    fileprivate var name:String = "man"
    //  fileprivate 表示代码可以在当前文件中被访问，而不做类型限定。
    
    private var age:Int = 1
    // private 只能在本类的作用域且在当前文件内能访问
}

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5
class LoginVC: BaseViewController {
   
    var disposeBag = DisposeBag() // 来自父类 ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.id_navTitle = "登录"
        
        let p = Person()
        print(p.name)
//        print(p.age)
        //编译器不会提示age属性 如果强行写p.age,会报错'age' is inaccessible due to 'private' protection level
       
        
       self.view.addSubview(self.usernameOutlet)
       self.view.addSubview(self.usernameValidOutlet)
       self.view.addSubview(self.passwordOutlet)
       self.view.addSubview(self.passwordValidOutlet)
       self.view.addSubview(self.doSomethingOutlet)
        
        self.usernameOutlet.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.top.equalToSuperview().offset(150)
            make.width.equalTo(KScreenWidth-30)
            make.height.equalTo(48)
        }
        self.usernameValidOutlet.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.top.equalTo(self.usernameOutlet.snp.bottom).offset(10)
            make.width.equalTo(KScreenWidth-30)
            make.height.equalTo(48)
        }
        
        self.passwordOutlet.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.top.equalTo(self.usernameValidOutlet.snp.bottom).offset(10)
            make.width.equalTo(KScreenWidth-30)
            make.height.equalTo(48)
        }
        self.passwordValidOutlet.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.top.equalTo(self.passwordOutlet.snp.bottom).offset(10)
            make.width.equalTo(KScreenWidth-30)
            make.height.equalTo(48)
//            make.edges.equalTo(self.passwordOutlet).inset(UIEdgeInsetsMake(10, 15, 20, 25))
        }
        self.doSomethingOutlet.snp.makeConstraints { (make) in
            make.leading.equalTo(15)
            make.top.equalTo(self.passwordValidOutlet.snp.bottom).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(48)
        }
        
        usernameValidOutlet.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidOutlet.text = "Password has to be at least \(minimalPasswordLength) characters"
        
//        self.usernameTF.rx：将textfiled用Reactive封装；
//        .text：监听和绑定text filed的值；
//        .orEmpty对上面的操作进行抽离简化二次封装；
//        .map使用ObservableType进行监听
        
        
         // 用户名 -> 用户名是否有效
        let usernameValid = usernameOutlet.rx.text.orEmpty.map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordOutlet.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)

        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)

        // 用户名是否有效 -> 密码输入框是否可用
//        usernameValid
//            .bind(to: usernameOutlet.rx.isEnabled)
//            .disposed(by: disposeBag)
//
//        passwordValid
//            .bind(to: passwordOutlet.rx.isEnabled)
//            .disposed(by:disposeBag)
        
        // 用户名是否有效 -> 用户名提示语是否隐藏
        usernameValid
            .bind(to: usernameValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)

        passwordValid
            .bind(to: passwordValidOutlet.rx.isHidden)
            .disposed(by: disposeBag)

        everythingValid
            .bind(to: doSomethingOutlet.rx.isEnabled)
            .disposed(by: disposeBag)

        doSomethingOutlet.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
        
        let controlEvent = self.doSomethingOutlet.rx.controlEvent(.touchUpInside)
               controlEvent.subscribe { (result) in
                   print("订阅:\(result) \n \(Thread.current)")
               }.disposed(by: disposeBag)
        
        //ControlEvent: 专门用于描述 UI 控件所产生的事件，它具有以下特征  //不会产生 error 事件 //一定在 MainScheduler 订阅（主线程订阅） ///一定在 MainScheduler 监听（主线程监听） ///会共享附加作用
         //events.subscribeOn(ConcurrentMainScheduler.instance)保证主队列调度
         //UI响应事件，不会存在失败响应
    }
        
        lazy var usernameOutlet: UITextField = {
            let text = UITextField.init(frame: CGRect.zero)
            text.placeholder = "UserName"
            return text
        }()
    
       lazy var passwordOutlet: UITextField = {
        let text = UITextField.init(frame: CGRect.zero)
        text.placeholder = "PassWord"
        return text
    }()
    
    lazy var usernameValidOutlet: UILabel = {
        let textlab = UILabel.init()
        textlab.backgroundColor = UIColor.red
        return textlab
    }()
    
    lazy var passwordValidOutlet: UILabel = {
        let textlab = UILabel.init()
        textlab.backgroundColor = UIColor.red
        return textlab
    }()
    
    lazy var doSomethingOutlet: UIButton = {
        let dobut = UIButton.init(type: UIButton.ButtonType.system)
          dobut.setTitleColor(RGBAColor(23, 32, 46), for: .normal)
          dobut.setTitle("按钮", for: .normal)
          dobut.backgroundColor = UIColor.red
          dobut.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return dobut
    }()
    
    func showAlert() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )

        alertView.show()
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
