//
//  MyactivityTableViewCell.swift
//  swiftdemo
//
//  Created by qf on 2020/8/28.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class MyactivityTableViewCell: UITableViewCell {
    fileprivate var titleLabel:UILabel?      // 活动标题
       fileprivate var timeView:UILabel?      // 开始-结束 时间
       fileprivate var addressView:UILabel?   // 活动地址
       fileprivate var signupNumView:UILabel? // 报名人数

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           
           self.backgroundColor = UIColor.white
           
           self.titleLabel = UILabel.init(frame: CGRect(x: 10, y: 10, width: KScreenWidth, height: 28))
           self.titleLabel?.font = UIFont.systemFont(ofSize: 22)
           self.titleLabel?.textColor = UIColor.black
           self.titleLabel?.textAlignment = NSTextAlignment.left
           self.contentView.addSubview(self.titleLabel!)
           
           self.timeView = UILabel.init(frame: CGRect(x: 10, y: self.titleLabel!.frame.maxY + 10, width: KScreenWidth - 20, height: 12))
           self.timeView?.text =  "activity_time"
           self.contentView.addSubview(self.timeView!)
           
           self.addressView = UILabel.init(frame: CGRect(x: 10, y: self.timeView!.frame.maxY + 10, width: KScreenWidth - 20, height: 12))
           self.addressView?.text =  "activity_add"
           self.contentView.addSubview(self.addressView!)
           
           self.signupNumView = UILabel.init(frame: CGRect(x: 10, y: self.addressView!.frame.maxY + 10, width: KScreenWidth - 20, height: 12))
           self.signupNumView?.text =  "activity_num"
           self.contentView.addSubview(self.signupNumView!)
           
           let bottomLineView = UIView.init(frame: CGRect(x: 0, y: self.signupNumView!.frame.maxY + 10, width: KScreenWidth, height: 10))
           bottomLineView.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
           self.contentView.addSubview(bottomLineView)
           
       }
       //set赋值方法
       var detailModel:DetailModel? {
           didSet{
               self.titleLabel?.text = detailModel!.hawser
               self.timeView?.text = "\(String(describing: detailModel!.aggrieved)) —— \(String(describing:detailModel!.largess))"
               self.addressView?.text = detailModel!.melon
               self.signupNumView?.text = "\(String(describing:detailModel!.simplicity))已报名"
           }
       }

       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
       }
       //MARK: cell的高度
       class func myactivityTableViewCellHeight() -> CGFloat{
           return 10 + 28 + 10 + 12 + 10 + 12 + 10 + 12 + 10 + 10;
       }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
