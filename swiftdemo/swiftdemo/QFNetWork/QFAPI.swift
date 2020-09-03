//
//  QFAPI.swift
//  swiftdemo
//
//  Created by qf on 2020/9/3.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

/// Type representing HTTP methods.
public enum QFHTTPMethod {
    /// Common HTTP methods.
    case delete, get, patch, post, put
}

/// API interface protocol
public protocol QFAPIProtocol {
    /// API URL address
    var url: String { get }
    /// API description information
    var description: String { get }
    /// API additional information, eg: Author | Note...
    var extra: String? { get }
    /// Type representing HTTP methods.
    var method: QFHTTPMethod { get }
}

/// Extension method
public extension QFAPIProtocol {

    /// 根据`QFAPIProtocol`进行一个网络请求
    ///
    /// - Parameters:
    ///   - parameters: `nil` by default.
    ///   - headers: `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///   - success: Successful response
    ///   - failed: Failed response
    ///
    func fetch(_ parameters: [String: Any]? = nil, headers: [String: String]? = nil, success: HNSuccessClosure?, failed: HNFailedClosure?) {
        let task = HN.fetch(self, parameters: parameters, headers: headers)
        if let s = success {
            task.success(s)
        }
        if let f = failed {
            task.failed(f)
        }
    }

    /// 根据`QFAPIProtocol`进行一个网络请求
    ///
    /// - Parameters:
    ///   - parameters: `nil` by default.
    ///   - headers: `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///
    func fetch(_ parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> QFNetworkRequest {
        HN.fetch(self, parameters: parameters, headers: headers)
    }
}

/// 为了`QFAPIProtocol`给`QFNetworking`扩展的网络请求方法
public extension QFNetworking {
    /// Creates a request, for `QFAPIProtocol`
    ///
    /// - note: more see: `self.request(...)`
    @discardableResult
    func fetch(_ api: QFAPIProtocol, parameters: [String: Any]? = nil, headers: [String: String]? = nil) -> QFNetworkRequest {
        let method = methodWith(api.method)
        let task = request(url: api.url, method: method, parameters: parameters, headers: headers)
        task.description = api.description
        task.extra = api.extra
        return task
    }
}

/// Function to convert request method
private func methodWith(_ m: QFHTTPMethod) -> Alamofire.HTTPMethod {
    // case delete, get, patch, post, put
    switch m {
    case .delete: return .delete
    case .get: return .get
    case .patch: return .patch
    case .post: return .post
    case .put: return .put
    }
}
