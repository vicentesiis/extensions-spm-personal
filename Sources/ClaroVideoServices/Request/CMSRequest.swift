//
//  CMSRequest.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/31/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

enum CMSRequest: RequestProtocol {
  
  case level(node: String)
  case levelUser(node: String)
  case special(specialName:String)
  case superhighlight(path:String)
  
  var path: String {
    switch self {
    case .level:
      return "level"
    case .levelUser:
      return "leveluser"
    case .special:
      return "special"
    case .superhighlight(let path):
      return path
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case  .level, .levelUser,.special, .superhighlight:
      return .get
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .level, .levelUser, .special, .superhighlight:
      return ["": ""]
    }
  }
  
  var cachePolicy: NSURLRequest.CachePolicy  {
    switch self {
    case .level, .levelUser, .special, .superhighlight:
      return .reloadIgnoringLocalCacheData
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
    case .level, .levelUser, .special, .superhighlight:
      return 10.0
    }
  }
  
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .level(let node), .levelUser(let node):
      baseParams["node"] = node
      return baseParams
    case .special(let specialName):
      baseParams["special"] = specialName
      return baseParams
    case .superhighlight:
      return baseParams
    }
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    let baseParams = baseParameters ?? [:]
    return baseParams
  }
}


