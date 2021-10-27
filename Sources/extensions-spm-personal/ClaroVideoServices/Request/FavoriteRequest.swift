//
//  FavoriteRequest.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 22/04/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

enum FavoriteRequest: RequestProtocol {
  
  case favoriteLive(epgVersion: String)
  case favorited(path: String)
  case add(groupId: String)
  case delete(groupId: String)
  
  var path: String {
    switch self {
    case .favoriteLive:
      return "favoritedlive"
    case .add:
      return "favoriteadd"
    case .delete:
      return "favoritedel"
    case .favorited(let path):
      return path
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case  .favorited, .add, .delete:
      return .get
    case .favoriteLive:
      return .post
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .favorited, .add, .delete, .favoriteLive:
      return ["": ""]
    }
  }
  
  var cachePolicy: NSURLRequest.CachePolicy  {
    switch self {
    case  .favorited, .add, .delete, .favoriteLive:
      return .reloadIgnoringLocalCacheData
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
    case .add, .delete, .favoriteLive:
      return 10.0
    case .favorited:
      return 30.0
    }
  }
  
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .favorited:
      break
    case let .favoriteLive(epgVersion):
      baseParams["epg_version"] = epgVersion
      break
    case .add(let groupId), .delete(let groupId):
      baseParams["object_id"] = groupId
      baseParams["object_type"] = 1
    }
    return baseParams
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    let baseParams = baseParameters ?? [:]
    switch self {
    case .favorited, .add, .delete, .favoriteLive:
      return baseParams
    }
  }
}
