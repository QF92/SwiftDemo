//
//  HomeListCell.swift
//  swiftdemo
//
//  Created by qf on 2020/8/31.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class HomeListCell: UITableViewCell {

        @IBOutlet weak var bottomView: UIView!
        @IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var iconView: UIImageView!
        override func awakeFromNib() {
            super.awakeFromNib()
            
            self.backgroundColor = UIColor.systemGroupedBackground
            self.bottomView.layer.cornerRadius = 4
        }
        
        static func cellWithTableView(tableView:UITableView) -> HomeListCell{
            let bundle = Bundle.main
            let ID = "HomeListCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: ID)
            if cell == nil {
                cell = bundle.loadNibNamed("HomeListCell", owner: nil, options: nil)?.last as! HomeListCell?
            }
            cell?.selectionStyle = .none
            
            return cell! as! HomeListCell
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
