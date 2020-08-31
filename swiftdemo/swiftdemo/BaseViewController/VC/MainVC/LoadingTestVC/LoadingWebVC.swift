//
//  LoadingWebVC.swift
//  swiftdemo
//
//  Created by qf on 2020/8/31.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
import WebKit
class LoadingWebVC: BaseViewController,WKNavigationDelegate {

    lazy var webview: WKWebView = {
        let web = WKWebView.init(frame: CGRect.init(x: 0, y: KNavgationBarHeight, width: KScreenWidth, height: KScreenHeight-KNavgationBarHeight))
        web.load(URLRequest.init(url: URL.init(string: "https://www.darrenblog.cn/")!))
        web.navigationDelegate = self
        return web
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.id_navTitle = "网页展示"
        self.view.addSubview(self.webview)
        
        Loading.id_showProgressLine(onView: self.id_customNavBar)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Loading.id_dismissNav()
    }
     
//    func  webViewDidFinishLoad(_ webView:  UIWebView) {
//
//        Loading.id_dismissNav()
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
