//
//  DialogNormalView.swift
//  swiftdemo
//
//  Created by qf on 2020/8/31.
//  Copyright © 2020 qf. All rights reserved.
//

//属性观察 (Property Observers) 是 Swift 中一个很特殊的特性，利用属性观察我们可以在当前类型内监视对于属性的设定，并作出一些响应。Swift 中为我们提供了两个属性观察的方法，它们分别是 willSet 和 didSet。
//
//使用这两个方法十分简单，我们只要在属性声明的时候添加相应的代码块，就可以对将要设定的值和已经设置的值进行监听了：
import UIKit

typealias DialogLeftClouse = ()->()
typealias DialogRightClouse = ()->()

class DialogNormalView: UIView {
    var timer: DispatchSourceTimer?
    var countDownNumber = 0{
        didSet {//属性观察
            if countDownNumber <= 0 {
                return
            }
            if self.timer != nil {
                self.timer?.cancel()
                self.timer = nil
            }
            var timeOut: Int = countDownNumber
            self.timer = DispatchSource.makeTimerSource(queue: .main)
            self.timer?.schedule(deadline: .now(),repeating: 1)
            self.timer?.setEventHandler(handler: {() ->Void in
                if timeOut <= 0{
                    self.timer?.cancel()
                    self.timer = nil
                    self.clickRightbtn()
                }else {
                        timeOut -= 1
                        if self.rightActionTitle != nil && (self.rightActionTitle?.count ?? 0) > 0 {
                            let originTitleArr = (self.rightActionTitle ?? "").components(separatedBy: "(")
                            let originTitle = originTitleArr.first
                            let title = (originTitle ?? "") + "(\(timeOut)s)"
                            self.rightBtn.titleLabel?.text = title
                            self.rightBtn.setTitle(title, for: .normal)
                        }
                }
            })
             self.timer?.resume()
        }
    }
    lazy var titleLabel: UILabel = {
            let title = UILabel.init(frame: CGRect.zero)
            title.textAlignment = .center
            title.numberOfLines = 0
            title.font = UIFont.systemFont(ofSize: 18)
            title.textColor = RGBAColor(23, 32, 46)
            return title
        }()
        lazy var msgLabel: UILabel = {
            let title = UILabel.init(frame: CGRect.zero)
            title.textAlignment = .center
            title.font = UIFont.systemFont(ofSize: 14)
            title.textColor = RGBAColor(96, 102, 111)
            title.numberOfLines = 0
            return title
        }()
        lazy var leftBtn: UIButton = {
            let btn = UIButton.init(type: UIButton.ButtonType.system)
            btn.setTitleColor(RGBAColor(23, 32, 46), for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.addTarget(self, action: #selector(clickLeftbtn), for: .touchUpInside)
            return btn
        }()
        lazy var rightBtn: UIButton = {
            let btn = UIButton.init(type: UIButton.ButtonType.system)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.addTarget(self, action: #selector(clickRightbtn), for: .touchUpInside)
            return btn
        }()
        lazy var lineViewRow: UIView = {
            let line = UIView.init(frame: CGRect.zero)
            line.backgroundColor = UIColor.systemGroupedBackground
            return line
        }()
        lazy var lineView: UIView = {
            let line = UIView.init(frame: CGRect.zero)
            line.backgroundColor = UIColor.systemGroupedBackground
            return line
        }()
        lazy var bottomView: UIView = {
            let bottom = UIView.init(frame: CGRect.zero)
            bottom.backgroundColor = UIColor.clear
            return bottom
        }()
        
        open var title: String? {
            get { return self.titleLabel.text }
            set { self.titleLabel.text = newValue }
        }
        open var msg: String? {
            get { return self.msgLabel.text }
            set { self.msgLabel.text = newValue }
        }
        open var leftActionTitle: String? {
            get { return self.leftBtn.currentTitle }
            set { self.leftBtn.setTitle(newValue, for: .normal)  }
        }
        open var rightActionTitle: String? {
            get { return self.rightBtn.currentTitle }
            set { self.rightBtn.setTitle(newValue, for: .normal)  }
        }
        open var leftHandler: DialogLeftClouse?
        open var rightHandler: DialogRightClouse?
        
        var keyBoardHeight: CGFloat = 0
        
        var superWidth = KScreenWidth
        var superHeight = KScreenHeight
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            initView()
            initEventHendle()
        }
        
        func fitFont() {
            if KScreenWidth > 375 && UIDevice.current.orientation == .portrait {
                self.titleLabel.font = UIFont.systemFont(ofSize: 20)
                self.msgLabel.font = UIFont.systemFont(ofSize: 16)
                self.rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
                self.leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            } else {
                self.titleLabel.font = UIFont.systemFont(ofSize: 18)
                self.msgLabel.font = UIFont.systemFont(ofSize: 14)
                self.rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                self.leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            }
        }
        
        func initEventHendle() {
            ScreenTools.share.screenClouse = { [weak self] (orientation) in
                self?.setNeedsLayout()
            }
        }
        
        func initView() {
            self.layer.cornerRadius = 8
            self.backgroundColor = UIColor.white
            self.addSubview(self.titleLabel)
            self.addSubview(self.msgLabel)
            self.addSubview(self.lineViewRow)
            self.addSubview(self.bottomView)
            self.bottomView.addSubview(self.leftBtn)
            self.bottomView.addSubview(self.rightBtn)
            self.bottomView.addSubview(self.lineView)
        }
        
        @objc func clickLeftbtn() {
            if self.leftHandler != nil {
                self.leftHandler!()
            }
        }
        @objc func clickRightbtn() {
            if self.rightHandler != nil {
                self.rightHandler!()
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        override func layoutSubviews() {
            super.layoutSubviews()
            self.fitFont()

            self.superWidth = KScreenWidth
            self.superHeight = KScreenHeight
            
            let constraintSize = CGSize(
                width: dialogWidth - 20,
                height: self.superHeight - 150
            )
    //        sizeToFit:会计算出最优的 size 而且会改变自己的size
    //        sizeThatFits:会计算出最优的 size 但是不会改变 自己的 size
            var titleSize = self.titleLabel.sizeThatFits(constraintSize)
            var msgSize = self.msgLabel.sizeThatFits(constraintSize)
            if msgSize.height > constraintSize.height  {
                msgSize.height = constraintSize.height
            }
            if titleSize.height > constraintSize.height  {
                titleSize.height = constraintSize.height
            }
            self.titleLabel.preferredMaxLayoutWidth = dialogWidth - 20
            self.msgLabel.preferredMaxLayoutWidth = dialogWidth - 20

            // 标题和文本的frame
            if titleSize.height > 0 &&  msgSize.height > 0 { // 标题和内容
                self.titleLabel.frame = CGRect.init(x: 16, y: 16, width: dialogWidth-32, height: titleSize.height)
                self.msgLabel.frame = CGRect.init(x: 16, y: self.titleLabel.frame.maxY + 12, width: dialogWidth-32, height: msgSize.height)
            } else if (titleSize.height <= 0 &&  msgSize.height > 0) { // 只展示一个标题
                self.titleLabel.frame = CGRect.zero
                self.msgLabel.textColor = RGBAColor(23, 32, 46)
                self.msgLabel.frame = CGRect.init(x: 16, y: 20, width: dialogWidth-32, height: msgSize.height)
            } else if (titleSize.height > 0 &&  msgSize.height <= 0) {
                self.titleLabel.frame = CGRect.init(x: 16, y: 20, width: dialogWidth-32, height: titleSize.height)
                self.msgLabel.frame = CGRect.init(x: 0, y: self.titleLabel.frame.maxY, width: 0, height: 0)
            } else {
                print("标题和内容不能同时为空")
            }
            
            self.lineViewRow.frame = CGRect.init(x: 0, y: self.msgLabel.frame.maxY + 20, width: dialogWidth, height: 1)
            self.bottomView.frame = CGRect.init(x: 0, y: self.lineViewRow.frame.maxY, width: dialogWidth, height: 50)
            if self.leftActionTitle == nil || self.leftActionTitle?.count == 0 {
                self.leftBtn.frame = CGRect.zero
                self.lineView.frame = CGRect.zero
                self.rightBtn.frame = self.bottomView.bounds
                
                self.frame = CGRect.init(x: 0.5*(superWidth - dialogWidth), y: 0.5*(superHeight - (self.bottomView.frame.maxY)), width: dialogWidth, height: self.bottomView.frame.maxY)
                self.rightBtn.setTitleColor(DialogManager.share.mainColor, for: .normal)
                return
            }
            if self.rightActionTitle == nil || self.rightActionTitle?.count == 0 {
                self.rightBtn.frame = CGRect.zero
                self.lineView.frame = CGRect.zero
                self.leftBtn.frame = self.bottomView.bounds
                
                self.frame = CGRect.init(x: 0.5*(superWidth - dialogWidth), y: 0.5*(superHeight - (self.bottomView.frame.maxY)), width: dialogWidth, height: self.bottomView.frame.maxY)
                self.leftBtn.setTitleColor(DialogManager.share.mainColor, for: .normal)
                return
            }
            if self.rightActionTitle != nil && self.leftActionTitle != nil {
                self.leftBtn.frame = CGRect.init(x: 0, y: 0, width: dialogWidth*0.5-0.5, height: self.bottomView.frame.height)
                self.rightBtn.frame = CGRect.init(x: dialogWidth*0.5+0.5, y: 0, width: dialogWidth*0.5-0.5, height: self.bottomView.frame.height)
                self.lineView.frame = CGRect.init(x: dialogWidth*0.5-0.5, y: 0, width: 1, height: self.bottomView.frame.height)
            }
            self.frame = CGRect.init(x: 0.5*(superWidth - dialogWidth), y: 0.5*(superHeight - (self.bottomView.frame.maxY)), width: dialogWidth, height: self.bottomView.frame.maxY)
            self.rightBtn.setTitleColor(DialogManager.share.mainColor, for: .normal)
        }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
