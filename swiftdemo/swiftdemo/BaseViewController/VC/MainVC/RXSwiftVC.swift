//
//  RXSwiftVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/14.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
import RxSwift
class RXSwiftVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let array = [1,2,3,4,5,6,7,8,9,10]
        
        for num in array {
            if num > 2 {
                let number =  num + 1
                if (number % 2 == 0) {
                    print("----\(number)")
                }
            }
        }
        
//        对象对某一数据流变化做出响应的这种编码方式称为响应式
//        .filter   过滤条件操作符 
//            .forEach
        // 使用RX
        array.filter { $0 > 2 }.filter{($0 + 1) % 2 == 1}.forEach {
            print( $0 )
        }
        
        
        // 1: 创建序列
           _ =  Observable<String>.create { (obserber) -> Disposable in
                // 3:发送信号
                obserber.onNext("Cooci -  框架班级")
                return Disposables.create()  // 这个销毁不影响我们这次的解读
                // 2: 订阅序列
                }.subscribe(onNext: { (text) in
                    print("订阅到:\(text)")   // 控制台打印：“订阅到:Cooci -  框架班级”
                })
//        1：创建序列的代码 Create 后面的 闭包A 里面有 3：发送信号，如果要执行 发送信号 ，必然要来到这个闭包A
//        2：我们执行 2: 订阅序列 跟了 闭包B
//        3：通过结果我们显然知道，先执行 闭包A 把 Cooci - 框架班级 传给了 闭包B
//        猜测：代码里面嵌套了闭包的执行调用！猜测的真实性，我们开始解读源码来验证
               
//        ObservableType
         
        print("********emty********")
        let emtyOb = Observable<Int>.empty()
        _ = emtyOb.subscribe(onNext: { (number) in
            print("订阅:",number)
        }, onError: { (error) in
            print("error:",error)
        }, onCompleted: {
            print("完成回调")
        }) {
            print("释放回调")
        }
        
        //MARK:  just
        // 单个信号序列创建
        let arrays = ["LG_Cooci","LG_Kody"]
        
        Observable<[String]>.just(arrays)
            .subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)

        _ = Observable<[String]>.just(arrays).subscribe(onNext: { (number) in
            print("订阅:",number)
        }, onError: { (error) in
            print("error:",error)
        }, onCompleted: {
            print("完成回调")
        }) {
            print("释放回调")
        }
        
        // Do any additional setup after loading the view.
        
//        RxCocoa + UIGestureRecognizer
        
        var disposeBag = DisposeBag()
        
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        // 订阅方式实现
        tapGesture.rx.event.subscribe(onNext: { _ in
            print("tapped")
        }).disposed(by: disposeBag)

        // 绑定方式实现
        tapGesture.rx.event.bind { _ in
            print("tapped")
        }.disposed(by: disposeBag)
        
        // 添加一个上滑的手势
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .up
        self.view.addGestureRecognizer(swipe)

        // 订阅方式实现
        swipe.rx.event.subscribe(onNext: { [weak self] recognizer in
            let point = recognizer.location(in: self?.view)
            print("向上滑动 \(point.x) - \(point.y)")
        }).disposed(by: disposeBag)

        // 绑定方式实现
        swipe.direction = .down
        swipe.rx.event.bind { [weak self] recognizer in
            let point = recognizer.location(in: self?.view)
            print("向下滑动 \(point.x) - \(point.y)")
        }.disposed(by: disposeBag)
        
    }

    
    lazy var button: UIButton = {
        let but = UIButton.init(type: UIButton.ButtonType.system)
        but.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return but
    }()

    
    var disposeBag = DisposeBag()
    
    //MARK: - RxSwift应用-button响应
    func setupButton() {
        // 传统UI事件
        self.button.addTarget(self, action: #selector(didClickButton), for: .touchUpInside)
        
        // 这样的操作 - 不行啊!代码逻辑与事件逻辑分层
        self.button.rx.tap
            .subscribe(onNext: { [weak self] in
                print("点了,小鸡炖蘑菇")
                self?.view.backgroundColor = UIColor.orange
            })
            .disposed(by: disposeBag)
    }

    @objc func didClickButton() {
        
        
        
    }
    
    
    lazy var textFiled: UITextField = {
        let tes = UITextField.init(frame: CGRect.init(x: 30, y: 70, width: 160, height: 30))
        tes.placeholder = "测试复制,粘贴到此"
        return tes
    }()
    
    
    //MARK: - RxSwift应用-textfiled
    func setupTextFiled() {
        // 我们如果要对输入的文本进行操作 - 比如输入的的内容 然后我们获取里面的偶数
        // self.textFiled.delegate = self
        // 感觉是不是特别恶心
        // 下面我们来看看Rx
        self.textFiled.rx.text.orEmpty.changed.subscribe(onNext: { (text) in
            print("监听到了 - \(text)")
        }).disposed(by: disposeBag)
        
        self.textFiled.rx.text.bind(to: self.button.rx.title()).disposed(by: disposeBag)
    }
    
    
    
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView.init(frame: CGRect.init(x: 0, y: KNavgationBarHeight, width: KScreenWidth, height: KScreenHeight-KNavgationBarHeight))
        scroll.backgroundColor = UIColor.systemGroupedBackground //systemGroupedBackground
        return scroll
    }()
    //MARK: - RxSwift应用-scrollView
    func setupScrollerView() {
        scrollView.rx.contentOffset.subscribe(onNext: { [weak self] (content) in
            self?.view.backgroundColor = UIColor.init(red: content.y/255.0*0.8, green: content.y/255.0*0.3, blue: content.y/255.0*0.6, alpha: 1);
            print(content.y)
        }).disposed(by: disposeBag)
    }
    
    
     //MARK: - RxSwift应用-KVO
    func setupKVO() {
        // 系统KVO 还是比较麻烦的
        // person.addObserver(self, forKeyPath: "name", options: .new, context: nil)
//        person.rx.observeWeakly(String.self, "name").subscribe(onNext: { (change) in
//            print(change ?? "helloword")
//        }).disposed(by: disposeBag)
    }

    
    //MARK: - 通知
    func setupNotification(){
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .subscribe { (event) in
                print(event)
        }.disposed(by: disposeBag)
    }

    
    lazy var label: UILabel = {
            let title = UILabel.init(frame: CGRect.zero)
               title.textAlignment = .center
               title.numberOfLines = 0
               title.font = UIFont.systemFont(ofSize: 18)
               title.textColor = RGBAColor(23, 32, 46)
               return title
    }()
    //MARK: - 手势
    func setupGestureRecognizer(){
        let tap = UITapGestureRecognizer()
        self.label.addGestureRecognizer(tap)
        self.label.isUserInteractionEnabled = true
        tap.rx.event.subscribe { (event) in
            print("点了label")
        }.disposed(by: disposeBag)
    }
    
    //MARK: - RxSwift应用-网络请求
    func setupNextwork() {
        let url = URL(string: "https://www.baidu.com")
        URLSession.shared.rx.response(request: URLRequest(url: url!))
            .subscribe(onNext: { (response, data) in
                print("response ==== \(response)")
                print("data ===== \(data)")
            }, onError: { (error) in
                print("error ===== \(error)")
            }).disposed(by: disposeBag)
    }

    
    //MARK: - RxSwift应用-timer定时器
    func setupTimer() {
//        timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        timer.subscribe(onNext: { (num) in
//            print("hello word \(num)")
//        }).disposed(by: disposeBag)
    }

    
}



//Observable - 产生事件
//Observer - 响应事件
//Operator - 创建变化组合事件
//Disposable - 管理绑定（订阅）的生命周期
//Schedulers - 线程队列调配
   
//input 输入  Output 输出
