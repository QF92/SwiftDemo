//
//  NetWorkingTool.swift
//  swiftdemo
//
//  Created by qf on 2020/8/27.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
import Alamofire

public typealias Success = (_ data : Data)->()
public typealias Failure = (_ error : Error)->()
class NetWorkingTool: NSObject {
    
    static let shared:NetWorkingTool = {
          let share = NetWorkingTool()
          return share
      }()
    //单例
    static var sharedInstance : NetWorkingTool{
        struct Static {
            static let instance : NetWorkingTool = NetWorkingTool()
        }
        return Static.instance
    }
    
//    open func request<Parameters: Encodable>(
//        _ convertible: URLConvertible,
//        method: HTTPMethod = .get,
//        parameters: Parameters? = nil,
//        encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default,
//        headers: HTTPHeaders? = nil,
//        interceptor: RequestInterceptor? = nil
//    ) -> DataRequest
    
   /// GET请求
         func getRequest(urlString: String,params: Parameters? = nil,success: @escaping Success,failure: @escaping Failure){
            request(urlString, params: params, method: .get, success, failure)
        }
        
        /// POST请求
         func postRequest(urlString: String,params: Parameters? = nil,success: @escaping Success,failure: @escaping Failure){
            
            request(urlString, params: params, method:.post, success, failure)
        }
        
        //公共的私有方法
        private func request(
            _ urlString: String,
            params: Parameters? = nil,
            method: HTTPMethod,
            _ success: @escaping Success,
            _ failure: @escaping Failure)
        {
            let manager = AF.session
            manager.configuration.timeoutIntervalForRequest = 10
            AF.request(urlString, method:method, parameters:params).responseData { response in
                guard response.value != nil else {
                    return
                }
                switch (response.result) {
                case .success:
                    success(response.data! as Data)
                    break
                case .failure(let error):
                    failure(error)
                    break
                }
            }
        }
    
    static  func UIr() {
           //接口地址
           let urls:String = "http://www.baidu.com"
           //参数
           let parameters:Dictionary = ["type":"1","name":"customer","password":"123456"]
           ///Alamofire 请求实例
           AF.request(URL(string: urls)!, method: .post, parameters: parameters).responseString { (responses) in
               let ste:String = responses.value ?? ""
               print(ste)
               
           }
           
           AF.request("http://127.0.0.1:8888/ISAPI", method: HTTPMethod.get, parameters: parameters).responseJSON { (response) in
                   switch response.result {
                   case .success:
                       print("SUCCESS")
                       print(response.value!)
                   case .failure:
                       print("ERROR")
                   }
           }

           AF.request("https://httpbin.org/get", requestModifier: { $0.timeoutInterval = 5 }).response {
               (response) in

           }

       }
    
       //文件下载
         private func dOwnload(urlString: String, params: Parameters? = nil,method: HTTPMethod, success: @escaping Success, failure: @escaping Failure)
            {
                let videoUrl = "http://onapp.yahibo.top/public/videos/video.mp4"
                AF.download(urlString, interceptor: nil) { (videoUrl, response) -> (destinationURL: URL, options: DownloadRequest.Options) in
                           let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                           let time = Date().timeIntervalSince1970
                           let fileURL = documentsURL.appendingPathComponent("\(time).mp4")
                           print("沙盒路径：\(documentsURL)")
                           return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
                };
                
        };
}
