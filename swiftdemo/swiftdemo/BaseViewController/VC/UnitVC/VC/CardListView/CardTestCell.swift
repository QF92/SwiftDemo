//
//  CardTestCell.swift
//  swiftdemo
//
//  Created by qf on 2020/9/25.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class CardTestCell: CardCollectionViewCell {
    
    lazy var iconView: UIImageView = {
        let img = UIImageView.init(frame:  CGRect(x: 0, y: 0, width:self.id_width, height: 150))
        img.isUserInteractionEnabled = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var numberLabel: UILabel = {
        let number = UILabel.init(frame: CGRect.init(x:(self.id_width-42)/2 , y: self.id_height - 30, width: 42, height: 20))
        number.backgroundColor = RGBAColor(242,211,54)
        number.text = ""
        number.textColor = UIColor.white
        return number
    }()

    lazy var leftLabel: UILabel = {
        let number = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: 90, height: 40))
        number.backgroundColor = UIColor.white
        number.text = "喜欢😍"
        number.textAlignment = .center
        number.textColor = RGBAColor(255,88,88)
        return number
    }()
    
    lazy var rightLabel: UILabel = {
        let number = UILabel.init(frame: CGRect.init(x: self.id_width - 100 , y: 0, width: 90, height: 40))
        number.backgroundColor = UIColor.white
        number.text = "😠讨厌"
        number.textColor = RGBAColor(255,88,88)
        return number
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(self.iconView)
        self.addSubview(self.numberLabel)
        self.addSubview(self.leftLabel)
        self.addSubview(self.rightLabel)
        
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
