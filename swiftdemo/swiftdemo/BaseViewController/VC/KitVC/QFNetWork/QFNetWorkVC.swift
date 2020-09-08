//
//  QFNetWorkVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/4.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

//枚举的关联值是实际值，并不是原始值的另一种表达方法。实际上，如果没有比较有意义的原始值，你就不需要提供原始值。
enum Suit {
    case spades, hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
}
class QFNetWorkVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "首页"
        
        let a = UILabel.init(frame:CGRect.init(x: 10, y: 100, width: view.id_width - 20, height: 165))
//        (font: SemiboldFont(16), color: UIColor.blue)
        a.font = SemiboldFont(16)
        a.textColor = UIColor.blue
        a.numberOfLines = 0;
        a.text = "用法直接看`QFNetWorkVC`类即可\n\nOC的调用方式，和`QFNetWorkVC`在同一个目录下"
        view.addSubview(a)
        
//        self.test_post_a()
        Swiftlog()
        
        // 开始网络状态监测
        // 由于可能多个地方需要知道网络状态，所以添加通知`kNetworkStatusNotification`即可
        // 在通知回调方法里面，判断`HN.networkStatus`即可
        HN.startMonitoring()
    }

    /// **测试用例** post
    func test_post_a() {
        let p: [String: Any] = ["city": "北京市", "locatex": 0, "locatey": 0, "num": 2]
        HN.POST(url: API.Home.storeList.url, parameters: p).success { response in
            print("response -->", response)
        }.failed { error in
            print("error -->", error)
        }
    }

    /// **测试用例** post
    func test_post_b() {
        let p: [String: Any] = ["city": "北京市", "locatex": 0, "locatey": 0, "num": 2]
        HN.fetch(API.Home.storeList, parameters: p).success { response in
            print("response -->", response)
        }.failed { error in
            print("error -->", error)
        }
    }

    /// **测试用例** post
    func test_post_c() {
        let p: [String: Any] = ["city": "北京市", "locatex": 0, "locatey": 0, "num": 2]
        API.Home.storeList.fetch(p, success: {response in
            print("response -->", response)
        }, failed: {error in
            print("error -->", error)
        })
    }

    /// **测试用例** get
    func test_get_a() {
        let p = ["userId": "02363BC2523811E68BD95CB9018916241119"]

        API.Me.meIndex.fetch(p, success: {response in
            print("response -->", response)
        }, failed: {error in
            print("error -->", error)
        })
    }

    /// **测试用例** get
    func test_get_b() {
        let p = ["userId": "02363BC2523811E68BD95CB9018916241119"]

        HN.fetch(API.Me.meIndex, parameters: p).success { response in
            print("response -->", response)
        }.failed { error in
            print("error -->", error)
        }
    }

    /// **测试用例** get
    func test_get_c() {
        let p = ["userId": "02363BC2523811E68BD95CB9018916241119"]

        API.Me.meIndex.fetch(p).success { response in
            print("response -->", response)
        }.failed { error in
            print("error -->", error)
        }
    }
    
    /// **测试用例** get请求
    func get() {
        let url = "https://demo.xx.com/get/"
        let p: [String : Any] = ["name": "demo", "age": 18]
        
        HN.GET(url: url, parameters: p).success { (response) in
            // TODO...
        }.failed { (error) in
            // TODO...
        }
    }
    
    /// **测试用例** post请求
    func post() {
        let url = "https://demo.xx.com/get/"
        let p: [String : Any] = ["name": "demo", "age": 18]
        
        HN.POST(url: url, parameters: p).success { (response) in
            // TODO...
        }.failed { (error) in
            // TODO...
        }
    }
    
    /// **测试用例** 上传图片
    func photo() {
        let url = "https://demo.xx.com/get/"
        let p: [String : String] = ["name": "demo", "age": "18"]
        
        // 假设这里有2个照片，转为data，一般是选取相册里面的，可能还要压缩
        let d1_png = (UIImage(named: "xxxx.png")?.pngData())!
        let d2_jpg = (UIImage(named: "xxxx.jpg")?.jpegData(compressionQuality: 1))!
        
        // 图片的`MIME Type`可以使用`SDWebImage`获得
        let datas = [QFMultipartData(data: d1_png, name: "headurl", fileName: "1.png",
                                     mimeType: QFDataMimeType.PNG.rawValue),
                     QFMultipartData(data: d2_jpg, name: "headurl", fileName: "2.jpg",
                                     mimeType: QFDataMimeType.JPEG.rawValue)]
        
        HN.POST(url: url, parameters: p, datas: datas).progress { (progress) in
            debugPrint("progress: \(progress.fractionCompleted)")
        }.success { (response) in
            debugPrint("success: \(response)")
        }.failed { (error) in
            debugPrint("failed: \(error)")
        }
    }

    func Swiftlog() {
        let apple = 3
        let oranges = 5
        let applesummary = "I have \(apple) apples"
        let fruotus = "I have \(apple + oranges) pieces of fruit"
        
        debugPrint(applesummary ,fruotus)
        
        
        var shoppingList = ["catfish", "water" ,"tulips"]
        shoppingList[1] = "bottle of water"
        
        var occupations = ["Malcolm": "Captain","Kaylee": "Mechanic",]
        occupations["Jayne"] = "Public Relations"
        shoppingList.append("blue paint")  //数组在添加元素
        
        debugPrint(shoppingList)
        let  emptyArray = [String]()
        let emptyDictionary = [String:Float]()
        
        
        //使用 if 和 switch 来进行条件操作，使用 for-in、while 和 repeat-while 来进行循环。包裹条件和循环变量的括号可以省略，但是语句体的大括号是必须的。
        let individuakScores = [75,43,103,87,12]
        var teamScore = 0
        for score in individuakScores{
            if score > 50 {
                teamScore += 3
            }else{
                teamScore += 1
            }
        }
        print(teamScore)
        //在 if 语句中，条件必须是一个布尔表达式——这意味着像 if score { ... } 这样的代码将报错，而不会隐形地与 0 做对比。
        //你可以一起使用 if 和 let 一起来处理值缺失的情况。这些值可由可选值来代表。一个可选的值是一个具体的值或者是 nil 以表示值缺失。在类型后面加一个问号（?）来标记这个变量的值是可选的。
        
        var optionalString: String? = "Hello"
        print(optionalString == nil)
        
        var optionalName: String? = "John AppleSeed"
        var greeting = "Hello!"
        if let name = optionalName {
            greeting = "hell0,\(name)"
        }
        
        //switch 支持任意类型的数据以及各种比较操作——不仅仅是整数以及测试相等。
        //注意 let 在上述例子的等式中是如何使用的，它将匹配等式的值赋给常量 x。
       // 运行 switch 中匹配到的 case 语句之后，程序会退出 switch 语句，并不会继续向下运行，所以不需要在每个子句结尾写 break。
        let vegetable = "red pepper"
        switch vegetable {
        case "celery":
            print("Add some raisins and make ants on a log.")
        case "cucumber", "watercress":
            print("That would make a good tea sandwich.")
        case let x where x.hasSuffix("pepper"):
            print("Is it a spicy \(x)?")
        default:
            print("Everything tastes good in soup.")
        }
        
        let interestigNum = ["Prime": [2,3,5,7,11,13] , "Fibonacci":[11,1,1,2,4,6], "Square": [1,4,9,16,25],]
        var largest = 0
        
        for (kind, numbers) in interestigNum {
            for number in numbers {
                if number > largest{
                    largest = number
                    debugPrint(largest, kind)
                }
            }
        }
        
        
        //使用 while 来重复运行一段代码直到条件改变。循环条件也可以在结尾，保证能至少循环一次。
        var n = 2
        while n < 100 {
            n *= 2
        }
        print(n)

        var m = 2
        repeat {
            m *= 2
        } while m < 100
        print(m)
        
        //你可以在循环中使用 ..< 来表示下标范围。
        //使用 ..< 创建的范围不包含上界，如果想包含的话需要使用 ...
        var total = 0
        for i in 0..<4 {
            total += i
        }
        print(total)
        
        
        //函数和闭包
//        使用func 来声明一个函数，使用名字和参数来调用函数。使用-> 来指定函数返回值的类型。
        func greet(person: String, day: String)-> String{
            return "Hello \(person), today is \(day)."
        }
        
        greet(person: "BOb", day: "Tuesday")
        
        
//        使用元组来生成复合值，比如让一个函数返回多个值。该元组的元素可以用名称或数字来获取。
        
        func calculateStatistics(scores:[Int]) -> (min:Int, max: Int, sum: Int){
            var  min = scores[0]
            var  max = scores[0]
            var  sum = 0
            
            for score in scores {
                if score > max{
                    max = score
                }else if score < min{
                    min = score
                }
                sum += score
            }
            
            return (min,max, sum)
        }
        let statistics = calculateStatistics(scores:[5,3,100,3,9])
        print(statistics.sum , statistics.2)

        
//        函数可以嵌套。被嵌套的函数可以访问外侧函数的变量，你可以使用嵌套函数来重构一个太长或者太复杂的函数
        func returnFifteen()-> Int{
            var  y = 10
            func add(){
                y += 5
            }
            add()
            
            return y
        }
        returnFifteen()
        
//        函数是第一等类型，这意味着函数可以作为另一个函数的返回值
        func makeIncrementer() -> ((Int)->Int){
            func addone(number: Int) -> Int{
                return 1 + number
            }
            return addone
        }
        var  increment = makeIncrementer()
        increment(7)
        
       // 函数也可以当作参数传入另一个函数
        func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
            for item in list {
                if condition(item) {
                    return true
                }
            }
            return false
        }
        func lessThanTen(number: Int) -> Bool {
            return number < 10
        }
        var numbers = [20, 19, 7, 12]
        hasAnyMatches(list: numbers, condition: lessThanTen)
        
//        函数实际上是一种特殊的闭包:它是一段能之后被调取的代码。闭包中的代码能访问闭包作用域中的变量和函数，即使闭包是在一个不同的作用域被执行的——你已经在嵌套函数的例子中看过了。你可以使用 {} 来创建一个匿名闭包。使用 in 将参数和返回值类型的声明与闭包函数体进行分离。
        
        numbers.map({
            (number: Int) -> Int in
            let result = 3 * number
            return result
        })
        
        
        //swift 提供了便捷的快速排序数组、字典的函数 sorted( )。$0 来表示闭包的第一个参数，$1 来表示第二个，以此类推，in 也可以省略
       let dict = ["1": "a", "3": "c", "2": "b", "5": "e", "4": "d", "6": "f"]
        // 根据 key
        let key1 = dict.sorted{$0.0 < $1.0}
        // 根据 value
       let key2 = dict.sorted{$0.1 < $1.1}

        // 进一步省略参数
       let key3 =  dict.sorted(by: <)
       let key4 = dict.sorted(by: >)
        
        
        let sortedNumbers = numbers.sorted { $0 > $1 }
        print(sortedNumbers)

    //        对象和类。  //使用 class 和类名来创建一个类。类中属性的声明和常量、变量声明一样，唯一的区别就是它们的上下文是类。同样，方法和函数声明也一样。
 }
}
class NameShape{
            var numberOfSides:Int = 0
            var name: String

            init(name: String) {
                self.name = name
            }
           func simpleDescription() -> String {
                return "A shape with \(numberOfSides) sides."
            }
    }

class Square: NameShape {
           var sideLength: Double

           init(sideLength: Double, name: String) {
               self.sideLength = sideLength
               super.init(name: name)
               numberOfSides = 4
           }

           func area() ->  Double {
               return sideLength * sideLength
           }

           override func simpleDescription() -> String {
               return "A square with sides of length \(sideLength)."
           }
       }
