//
//  UIGraphicsViewController.swift
//  swiftdemo
//
//  Created by qf on 2021/1/28.
//  Copyright © 2021 qf. All rights reserved.
//

import UIKit

class UIGraphicsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let grap = GraphicsView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: KScreenWidth))
        grap.backgroundColor  = UIColor.white
        self.view.addSubview(grap)
        // Do any additional setup after loading the view.
    }
}
class GraphicsView: UIView{
    var labels = Array<UILabel>()
    let titles = ["应收帐款","应付账款","应缴税金","货币资金余额","净利润增长率","营业收入"]
    convenience init(frame: CGRect, cardLayout layout: CardLayout) {
        self.init(frame:frame)
    }
    // draw方法必须在view界面调用，否则 UIGraphicsGetCurrentContext()== nil
    override func draw(_ rect: CGRect) {
         super.draw(rect)
        // 移除视图上已有labels
        for label in self.labels {
            label.removeFromSuperview()
        }
        var values = Array<Int>()
        var sum = 0
        
        //生成随机数
        for _ in titles {
            let rand = Int.random(in: 200...500)
            values.append(rand);
            sum += rand
        }
        
        //计算百分比
        var percents = Array<CGFloat>()
        for value in values {
            percents.append(CGFloat(value)/CGFloat(sum))
        }
//        let center = CGPoint.init(x: KScreenWidth/2.0, y: (self.height - self.bottomView.height)/2.0)
        let center = CGPoint.init(x: KScreenWidth/2.0, y:self.height/2.0)
        let radius = KScreenWidth / 2.0 / 1.8
        let context:CGContext? = UIGraphicsGetCurrentContext()
        
        //折线半径
        let radius2 = radius + 30.0
        //label 宽度不能超出屏幕
        let width = KScreenWidth/2.0 - radius2
        let height: CGFloat = 20.0
        
        var index = 0
        var startAngle:CGFloat = 0.0
        for percent in percents {
            let angle = CGFloat.pi * 2.0 * percent
            let color = UIColor.init(red: CGFloat.random(in: 0.0...1.0), green: CGFloat.random(in: 0.0...1.0), blue: CGFloat.random(in: 0.0...1.0), alpha: 1.0)
            //画扇形
            context?.move(to: center)
            context?.setFillColor(color.cgColor)
            context?.addArc(center: center, radius: CGFloat(radius), startAngle: startAngle, endAngle: startAngle + angle, clockwise: false)
            context?.fillPath()
            
            //画折线
            let halfAngle = startAngle + angle / 2.0
            let point1 = self.getPoint(center: center, angle: halfAngle, radius: radius)
            let point2 = self.getPoint(center: center, angle: halfAngle, radius: radius2)
            let point3x = point1.x <= point2.x ? point2.x + width : point2.x - width
            let point3 = CGPoint.init(x: point3x, y: point2.y)
            context?.move(to: point1)
            context?.addLines(between: [point1,point2,point3])
            context?.setStrokeColor((UIColor.lightGray.cgColor))
            context?.strokePath()//显示路径
            
            //值标签
            let labelx = point1.x <= point2.x ? point2.x : point3.x
            let label = UILabel.init(frame: CGRect.init(x: labelx, y: point2.y - height, width: width, height: height))
            label.font = UIFont.systemFont(ofSize: 15)
            label.textAlignment = .center
            label.textColor = UIColor.gray
            label.text = "$" + String(values[index] * 100)
            self.addSubview(label)
            self.labels.append(label)
            
            //文字标签
            let textlabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: width, height: 30))
            textlabel.center = self.getPoint(center: center, angle: halfAngle, radius: radius - 30)
            textlabel.font = UIFont.systemFont(ofSize: 10)
            textlabel.textColor = .white
            textlabel.textAlignment = .center
            textlabel.numberOfLines = 0
            textlabel.text = self.titles[index] + "\n" + String.init(format: "%.f%%",percent * 100)
            textlabel.transform = CGAffineTransform.init(rotationAngle: halfAngle + CGFloat.pi / 2.0)
            self.addSubview(textlabel)
            self.labels.append(textlabel)
            
            startAngle += angle
            index += 1
        }
        
        let  toollabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: radius, height: radius))
        toollabel.backgroundColor = UIColor.white
        toollabel.center = center
        toollabel.layer.masksToBounds = true
        toollabel.layer.cornerRadius = radius/2
        self.addSubview(toollabel)
        self.labels.append(toollabel)
    }
    func getPoint(center: CGPoint, angle: CGFloat, radius: CGFloat) -> CGPoint{
        let x = center.x + cos(angle) * radius
        let y = center.y + sin(angle) * radius
        return CGPoint.init(x: x, y: y)
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
