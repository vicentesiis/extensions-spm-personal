//
//  DispatcherProtocol.swift
//  ClaroVideoNetworking
//
//  Created by alonso.salcido on 10/5/18.
//  Copyright © 2018 amco. All rights reserved.
//

import Foundation

public enum HttpProtocol: String {
  case https = "https://"
  case http  = "http://"
}

public struct Environment {
  
  public var httpProtocol: HttpProtocol
  public var host: String
  public var port: String
  
  public init(httpProtocol: HttpProtocol, host: String, port: String) {
    self.httpProtocol = httpProtocol
    self.host = host
    self.port = port
  }
  
  public func baseURLString() -> String {
    return httpProtocol.rawValue + host + port
  }
}

protocol DispatcherProtocol {
  init(environment: Environment)
  func fetch(uri: String?, request:RequestProtocol,baseParams: ServiceParameters?, completion: @escaping (Result<Response,NetworkError>) -> Void)
  func fetch(uri:String,request:RequestProtocol?,completion: @escaping (Result<Response,NetworkError>) -> Void)
}
