//
//  BundleUtil.swift
//  swiftdemo
//
//  Created by qf on 2020/8/31.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class BundleUtil{
   static func getCurrentBundle() -> Bundle{
               
       let podBundle = Bundle(for: DealistConfig.self)
       
       let bundleURL = podBundle.url(forResource: "swiftdemo", withExtension: "bundle")
       
       if bundleURL != nil {
           let bundle = Bundle(url: bundleURL!)!
           return bundle
       }else{
           return Bundle.main
       }
   }
   
//   static func cl_localizedStringForKey(key: String) -> String {
//       return self.cl_localizedStringForKey(key: key, value: "")
//   }
//   
//   static func cl_localizedStringForKey(key: String,value:String) -> String {
//       var bundle: Bundle? = nil
//       
//       if bundle == nil {
//           var language = NSLocale.preferredLanguages.first
//           let r: Range? = language?.range(of: "zh-Hans")
//           if r != nil {
//               language = "zh-Hans"
//           } else {
//               language = "en"
//           }
//           
//           bundle = Bundle(path: self.getCurrentBundle().path(forResource: language, ofType: "lproj")!)
//       }
//       
//       let str = bundle?.localizedString(forKey: key, value: value, table: nil)
//       return str ?? ""
//   }
}
