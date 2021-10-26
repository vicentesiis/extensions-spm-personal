//
//  NetRequest.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 22/04/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

enum NetRequest: RequestProtocol {
  case fetchNetOauthCallback(code: String)
  case getNetUrl
  case auth(user: String, password: String)
  
  var path: String {
    switch self {
      case .getNetUrl:
        return "request"
      case .fetchNetOauthCallback:
        return "oauth_callback_login"
    case .auth:
      return "auth"
    }
  }
  var method: HTTPMethod {
    switch self {
    case  .getNetUrl, .fetchNetOauthCallback:
      return .get
    case .auth:
      return .post
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .fetchNetOauthCallback, .getNetUrl:
      return ["": ""]
    case .auth:
      return ["Content-Type":"application/x-www-form-urlencoded"]
    }
  }
  
  var cachePolicy: NSURLRequest.CachePolicy  {
    switch self {
    case  .fetchNetOauthCallback, .getNetUrl, .auth:
      return .reloadIgnoringLocalCacheData
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
    case .fetchNetOauthCallback, .getNetUrl, .auth:
      return 10.0
    }
  }
  
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .getNetUrl:
      break
    case .fetchNetOauthCallback(let code):
      baseParams["code"] = code
    case .auth:
      return baseParams
    }
    return baseParams
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .fetchNetOauthCallback, .getNetUrl:
      return baseParams
    case .auth(let user, let password):
      baseParams["username"] = user
      baseParams["password"] = password
      return baseParams
    }
  }
}
