//
//  DialogCell.swift
//  swiftdemo
//
//  Created by qf on 2020/8/31.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
typealias clickSwichCluse = () -> ()
typealias clickDetailCluse = () -> ()

class DialogCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var swichClouse: clickSwichCluse?
    var detailClouse: clickDetailCluse?

    @IBOutlet weak var swich: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func clickSwich(_ sender: Any) {
        if self.swich.isOn {
            if swichClouse != nil {
                swichClouse!()
            }
        } else {
            
        }
    }
    @IBAction func clickBtn(_ sender: Any) {
        if detailClouse != nil {
            detailClouse!()
        }
    }
    static func cellWithTableView(tableView:UITableView) -> DialogCell{
        let bundle = Bundle.main
        let ID = "DialogCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = bundle.loadNibNamed("DialogCell", owner: nil, options: nil)?.last as! DialogCell?
        }
        cell?.selectionStyle = .none
        
        return cell! as! DialogCell
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
