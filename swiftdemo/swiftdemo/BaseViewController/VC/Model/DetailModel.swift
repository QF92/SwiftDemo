//
//  DetailModel.swift
//  swiftdemo
//
//  Created by qf on 2020/8/28.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
struct MyActivityListModel:Codable {
    var activityList:[DetailModel] = []
}

class DetailModel: Codable {
    let beneficial: String?
    let hawser:String?
    let aggrieved:String?
    let largess:String?
    let melon:String?
    let simplicity:String?
}
