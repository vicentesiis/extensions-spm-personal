//
//  ContentRequest.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/5/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

enum ContentRequest: RequestProtocol {
  
  case contentList(path:String)
  case contentRecommendations(path:String)
  case data(groupId: String)
  case serie(groupId: String)
  case recommendations(groupId: String)
  
  
  var path: String {
    switch self {
    case .contentList(let path),
         .contentRecommendations(let path):
      return path
    case .data:
      return "data"
    case .serie:
      return "serie"
    case .recommendations:
      return "recommendations"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case  .contentList, .contentRecommendations, .data, .serie, .recommendations:
      return .get
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .contentList, .contentRecommendations, .data, .serie, .recommendations:
      return ["": ""]
    }
  }
  
  var cachePolicy: NSURLRequest.CachePolicy  {
    switch self {
    case  .contentList, .contentRecommendations, .data, .serie, .recommendations:
      return .reloadIgnoringLocalCacheData
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
    case .contentList, .contentRecommendations, .data, .serie, .recommendations:
      return 30.0
    }
  }
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .contentList, .contentRecommendations:
      return baseParams
    case .data(let groupId), .serie(let groupId), .recommendations(let groupId):
      baseParams["group_id"] = groupId
      return baseParams
    }
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    let baseParams = baseParameters ?? [:]
    return baseParams
  }
}
