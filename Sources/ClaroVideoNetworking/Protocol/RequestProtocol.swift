//
//  RequestProtocol.swift
//  ClaroVideoNetworking
//
//  Created by alonso.salcido on 10/5/18.
//  Copyright © 2018 amco. All rights reserved.
//

import Foundation

public enum HTTPMethod : String {
  case get     = "GET"
  case post    = "POST"
  case put     = "PUT"
  case patch   = "PATCH"
  case delete  = "DELETE"
}

public typealias HTTPHeaders = [String:String]
public typealias ServiceParameters = [String:Any]

public protocol RequestProtocol {
  var path:String {get}
  var method: HTTPMethod {get}
  var headers: HTTPHeaders {get}
  var timeoutInterval:TimeInterval {get}
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters?
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters?
}

public struct SimpleRequest: RequestProtocol {
  public var path: String
  
  public var method: HTTPMethod
  
  public var headers: HTTPHeaders
  
  public var timeoutInterval: TimeInterval
  
  public func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    return method == .get ? baseParameters : [:]
  }
  
  public func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    return method == .post ? baseParameters : [:]
  }
}
