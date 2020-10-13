//
//  CardListVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/25.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class CardListVC: BaseViewController {

    var cellCount:Int = 10
    lazy var cardLayout: CardLayout = {
        let layout = CardLayout()
        layout.visibleCount = 4
        layout.maxAngle = 15.0
        layout.isRepeat = false
        layout.isPanAnimatedEnd = false //必须动画结束才可再次拖拽，为true时可不停的拖拽
        layout.maxRemoveDistance = self.view.frame.width/4
        layout.cardInsets = UIEdgeInsets(top: 10, left: 10, bottom: -10, right: 10)
        return layout
    }()
    
    lazy var topLabel: UILabel = {
        let top = UILabel.init(frame:CGRect.init(x: 10, y: 100, width: 100, height: 30) )
        top.text = "top 10"
        top.font = UIFont.systemFont(ofSize: 18)
        top.textColor = UIColor.white
        return top
    }()
    
    lazy var topslider: UISlider = {
        let  top = UISlider.init(frame: CGRect.init(x: 130, y: 100, width: 200, height: 30))
        top.minimumValue = -10  //最小值
        top.maximumValue = 10  //最大值
        top.value = 0  //当前默认值
        top.addTarget(self, action: #selector(topChange(sender:)), for: .valueChanged)
        return top
    }()
    
    lazy var leftLabel: UILabel = {
        let left = UILabel.init(frame:CGRect.init(x: 10, y: 150, width: 100, height: 30) )
        left.text = "left 10"
        left.font = UIFont.systemFont(ofSize: 18)
        left.textColor = UIColor.white
        return left
    }()
    
    lazy var leftslider: UISlider = {
        let  left = UISlider.init(frame: CGRect.init(x: 130, y: 150, width: 200, height: 30))
        left.addTarget(self, action: #selector(leftChange(sender:)), for: .valueChanged)
        left.minimumValue = -10
        left.maximumValue = 10
        left.value = 0
        return left
    }()
    
    lazy var rightLabel: UILabel = {
        let right = UILabel.init(frame:CGRect.init(x: 10, y: 190, width: 100, height: 30) )
        right.text = "right 10"
        right.font = UIFont.systemFont(ofSize: 18)
        right.textColor = UIColor.white
        return right
    }()
    
    lazy var rightslider: UISlider = {
        let  right = UISlider.init(frame: CGRect.init(x: 130, y: 190, width: 200, height: 30))
        right.minimumValue = -10
        right.maximumValue = 10
        right.value = 0
        right.addTarget(self, action: #selector(rightChange(sender:)), for: .valueChanged)
        return right
    }()
    
    lazy var bottomLabel: UILabel = {
        let bottom = UILabel.init(frame:CGRect.init(x: 10, y: 240, width: 100, height: 30) )
        bottom.text = "bottom 10"
        bottom.font = UIFont.systemFont(ofSize: 18)
        bottom.textColor = UIColor.white
        return bottom
    }()
    
    lazy var bottomslider: UISlider = {
        let  bottom = UISlider.init(frame: CGRect.init(x: 130, y: 240, width: 200, height: 30))
        bottom.minimumValue = -10
        bottom.maximumValue = 10
        bottom.value = 0
        bottom.addTarget(self, action: #selector(bottomChange(sender:)), for: .valueChanged)
        return bottom
    }()
    
    lazy var cardView:CardView = {
        let card = CardView.init(frame: CGRect.init(x:(KScreenWidth - 300)/2 , y: 300, width: 300, height: 300))
        return card
    }()
    
    
    lazy var leftbtn:UIButton = {
        let left = UIButton.init(frame: CGRect.init(x: 15, y: 650, width: 50, height: 30))
        left.setTitle("左", for: UIControl.State.normal)
        left.backgroundColor = UIColor.red
        left.layer.cornerRadius = 20
        left.layer.masksToBounds = true
        left.addTarget(self, action: #selector(leftButtonClicked(sender:)), for: .touchUpInside)
        return left
    }()
    
    lazy var rightBtn:UIButton = {
        let rightbtn = UIButton.init(frame: CGRect.init(x: KScreenWidth - 100, y: 650, width: 50, height: 30))
        rightbtn.setTitle("右", for: UIControl.State.normal)
        rightbtn.backgroundColor = UIColor.red
        rightbtn.layer.cornerRadius = 20
        rightbtn.layer.masksToBounds = true
        rightbtn.addTarget(self, action: #selector(rightButtonClick(_:)), for: .touchUpInside)
        return rightbtn
    }()
    
    lazy var SkipBtn:UIButton = {
        let Skip = UIButton.init(frame: CGRect.init(x: KScreenWidth/2, y: 650, width: 50, height: 30))
        Skip.setTitle("跳转", for: UIControl.State.normal)
        Skip.backgroundColor = UIColor.red
        Skip.layer.cornerRadius = 20
        Skip.layer.masksToBounds = true
        Skip.addTarget(self, action: #selector(updateButtonClick(_:)), for: .touchUpInside)
        return Skip
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        self.view.addSubview(self.topLabel)
        self.view.addSubview(self.topslider)
        self.view.addSubview(self.leftLabel)
        self.view.addSubview(self.leftslider)
        self.view.addSubview(self.rightLabel)
        self.view.addSubview(self.rightslider)
        self.view.addSubview(self.bottomLabel)
        self.view.addSubview(self.bottomslider)
        self.view.addSubview(self.cardView)
        self.view.addSubview(self.leftbtn)
        self.view.addSubview(self.rightBtn)
        self.view.addSubview(self.SkipBtn)
        // Do any additional setup after loading the view.
        self.cardView.dataSource = self
        self.cardView.delegate = self
        self.cardView.setCardLayout(cardLayout: self.cardLayout)
        self.cardView.register(classCellType: CardTestCell.self)
        self.cardView.reloadData()
    }
    
    @objc func leftButtonClicked(sender: Any?) {
        self.cardView.removeTopCardViewCell(swipe: .left)
    }
    
    @objc func rightButtonClick(_ sender: Any?) {
        self.cardView.removeTopCardViewCell(swipe: .right)
    }
    
    @objc func updateButtonClick(_ sender: Any?) {
        self.cardView.scrollToItem(at: self.cellCount/2, animated: true)
    }
    
    @objc func topChange(sender: UISlider) {
        
        self.topLabel.text = "top \(String(Int(sender.value)))"
        self.cardLayout.cardInsets.top = CGFloat(sender.value)
        self.cardView.invalidateLayout()
    }
    
    @objc func leftChange(sender: UISlider) {
        self.leftLabel.text = "left \(String(Int(sender.value)))"
        self.cardLayout.cardInsets.left = CGFloat(sender.value)
        self.cardView.invalidateLayout()
    }
    
    @objc func rightChange(sender: UISlider) {
        self.rightLabel.text = "right \(String(Int(sender.value)))"
        self.cardLayout.cardInsets.right = CGFloat(sender.value)
        self.cardView.invalidateLayout()
    }
    
    @objc func bottomChange(sender: UISlider) {
        self.bottomLabel.text = "bottom \(String(Int(sender.value)))"
        self.cardLayout.cardInsets.bottom = CGFloat(sender.value)
        self.cardView.invalidateLayout()
    }
}

extension CardListVC: CardViewDataSource, CardViewDelegate {
    // MARK: - GXCardViewDataSource
    func numberOfItems(in cardView: CardView) -> Int {
        return self.cellCount
    }
    func cardView(_ cardView: CardView, cellForItemAt indexPath: IndexPath) -> CardCollectionViewCell {
        let cell = cardView.dequeueReusableCell(for: indexPath, cellType: CardTestCell.self)
        cell.iconView.image = UIImage(named: String(format: "banner%d.jpeg", indexPath.item%3))
        cell.numberLabel.text = String(indexPath.item)
        cell.leftLabel.isHidden = true
        cell.rightLabel.isHidden = true
        
        return cell
    }
    
    // MARK: - GXCardViewDelegate
    func cardView(_ cardView: CardView, didRemoveLast cell: CardCollectionViewCell, forItemAt index: Int, direction: CardCollectionViewCell.SwipeDirection) {
        NSLog("didRemove forRowAtIndex = %d, direction = %d", index, direction.rawValue)
        if !cardView.cardLayout.isRepeat {
            cardView.reloadData()
            cardView.scrollToItem(at: 0, animated: false)
        }
    }
    func cardView(_ cardView: CardView, willRemove cell: CardCollectionViewCell, forItemAt index: Int, direction: CardCollectionViewCell.SwipeDirection) {
        NSLog("willRemove forRowAtIndex = %d, direction = %d", index, direction.rawValue)
        if let toCell = cell as? CardTestCell {
            toCell.leftLabel.isHidden = !(direction == .right)
            toCell.rightLabel.isHidden = !(direction == .left)
        }
    }
    func cardView(_ cardView: CardView, didRemove cell: CardCollectionViewCell, forItemAt index: Int, direction: CardCollectionViewCell.SwipeDirection) {
        NSLog("didRemove forRowAtIndex = %d, direction = %d", index, direction.rawValue)
        if !cardView.cardLayout.isRepeat && index == 9 {
            self.cellCount = 20
            cardView.reloadData()
        }
    }
    func cardView(_ cardView: CardView, didMove cell: CardCollectionViewCell, forItemAt index: Int, move point: CGPoint, direction: CardCollectionViewCell.SwipeDirection) {
        NSLog("move point = %@,  direction = %ld", point.debugDescription, direction.rawValue)
        if let toCell = cell as? CardTestCell {
            toCell.leftLabel.isHidden = !(direction == .right)
            toCell.rightLabel.isHidden = !(direction == .left)
        }
    }
    func cardView(_ cardView: CardView, didDisplay cell: CardCollectionViewCell, forItemAt index: Int) {
        NSLog("didDisplay forRowAtIndex = %d", index)
    }
    func cardView(_ cardView: CardView, didSelectItemAt index: Int) {
        NSLog("didSelectItemAt index = %d", index)
    }
}
