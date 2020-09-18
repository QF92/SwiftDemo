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


import CoreLocation  //导入定位核心库
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
        //开启定位
        loadLocation()
        
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

       var locationManager = CLLocationManager()
       var currentLocation:CLLocation!

       var lock = NSLock()
}


extension LoginVC: CLLocationManagerDelegate{  //遵守定位代理，以获取定位结果。
  
     //打开定位
     func loadLocation(){
 
        locationManager.delegate = self
         //定位方式
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  //定位精确度（最高）一般有电源接入，比较耗电
                                        //kCLLocationAccuracyNearestTenMeters; //精确到10米
        
        
     //iOS8.0以上才可以使用
        if(UIDevice.current.systemVersion >= "8.0"){
           //始终允许访问位置信息 //始终授权
           locationManager.requestAlwaysAuthorization()
           //使用应用程序期间允许访问位置数据   //弹出用户授权对话框，使用程序期间授权（ios8后)
           locationManager.requestWhenInUseAuthorization()
       }
    //开启定位
       locationManager.startUpdatingLocation()
   }
 
 
 
//获取定位信息
  private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
 
     lock.lock()
    //取得locations数组的最后一个
    let location:CLLocation = locations[locations.count-1]
        currentLocation = locations.last   //注意：获取集合中最后一个位置（最新的位置）
        //判断是否为空
    
    print("定位经纬度为：\(currentLocation.coordinate.latitude)")
    
    //一直发生定位错误输出结果为0：原因是我输出的是currentLocation.altitude(表示高度的)而不是currentLoction.coordinate.latitude（这个才是纬度）
      if(location.horizontalAccuracy > 0){
        let  lat = Double(String(format: "%.1f", location.coordinate.latitude))
        let  long = Double(String(format: "%.1f", location.coordinate.longitude))
          print("纬度:\(long!)")
          print("经度:\(lat!)")
          LonLatToCity()
          //停止定位
          locationManager.stopUpdatingLocation()
         lock.unlock()
    }
 
}
 
//出现错误
    private func locationManager(manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError?) {
        print(error as Any)
}
 
///将经纬度转换为城市名
func LonLatToCity() {
    let geocoder: CLGeocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(currentLocation) { (placemark, error) -> Void in
 
        if(error == nil)
        {
            let array = placemark! as NSArray
            let mark = array.firstObject as! CLPlacemark
//            //城市
//            var city: String = (mark.addressDictionary! as NSDictionary).value(forKey: "City") as! String
//            //国家
//            let country: NSString = (mark.addressDictionary! as NSDictionary).value(forKey: "Country") as! NSString
//            //国家编码
//            let CountryCode: NSString = (mark.addressDictionary! as NSDictionary).value(forKey: "CountryCode") as! NSString
//            //街道位置
//            let FormattedAddressLines: NSString = ((mark.addressDictionary! as NSDictionary).value(forKey: "FormattedAddressLines") as AnyObject).firstObject as! NSString
//            //具体位置
//            let Name: NSString = (mark.addressDictionary! as NSDictionary).value(forKey: "Name") as! NSString
//            //省
//            var State: String = (mark.addressDictionary! as NSDictionary).value(forKey: "State") as! String
//            //区
//            let SubLocality: NSString = (mark.addressDictionary! as NSDictionary).value(forKey: "SubLocality") as! NSString
//
//            //如果需要去掉“市”和“省”字眼
//
//            State = State.replacingOccurrences(of: "省", with: "")
//            let citynameStr = city.replacingOccurrences(of: "市", with: "")
            
            
            var street = mark.thoroughfare! // addressDictionary!["Street"] as? String ?? " "
            //城市
            let citys =  mark.subAdministrativeArea! // addressDictionary!["City"] as? String ?? " "
            let state = mark.administrativeArea!//addressDictionary!["State"] as? String ?? " "
            let zip =  mark.isoCountryCode!// addressDictionary!["ZIP"] as? String ?? " "
            //国家
            let countrys = mark.country! // addressDictionary!["Country"] as? String ?? " "
            //国家编码
            let countrycodes = mark.isoCountryCode! // addressDictionary!["Country"] as? String ?? " "
            
           
 
 
 
        }
        else
        {
            print(error)
        }
    }
 
 
}
 
}
