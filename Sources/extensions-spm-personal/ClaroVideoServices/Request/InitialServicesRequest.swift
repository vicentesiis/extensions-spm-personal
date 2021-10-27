//
//  InitialSertvicesRequest.swift
//  ClaroVideoServices
//
//  Created by alonso.salcido on 11/20/18.
//  Copyright © 2018 amco. All rights reserved.
//

import Foundation

enum InitialServicesRequest: RequestProtocol {
  
  case startHeaderInfo
  case apaMetadata
  case apaAsset
  case launcher
  case nav
  case metadataTranslations
  
  var path: String {
    switch self {
    case .startHeaderInfo:
      return "/user/startheaderinfo"
      case .apaMetadata, .metadataTranslations:
      return "/apa/metadata"
    case .apaAsset:
      return "/apa/asset"
    case .launcher:
      return "/apa/launcher"
    case .nav:
      return "/nav/data"
    }
  }
  
  var method: HTTPMethod {
    switch self {
      case .startHeaderInfo, .apaMetadata, .apaAsset, .launcher, .nav, .metadataTranslations:
      return .get
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
      case .startHeaderInfo, .apaMetadata, .apaAsset, .launcher, .nav, .metadataTranslations:
      return ["": ""]
    }
  }
  
  var cachePolicy: NSURLRequest.CachePolicy  {
    switch self {
      case .startHeaderInfo, .apaMetadata, .apaAsset, .launcher, .nav, .metadataTranslations:
      return .reloadIgnoringLocalCacheData
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
      case .startHeaderInfo, .apaMetadata, .apaAsset, .launcher, .nav, .metadataTranslations:
      return 10.0
    }
  }
  
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    let baseParams = baseParameters ?? [:]
    
    switch self {
      case .startHeaderInfo, .apaMetadata, .apaAsset, .launcher, .nav, .metadataTranslations:
      return baseParams
    }
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    let baseParams = baseParameters ?? [:]
    switch self {
      case .startHeaderInfo, .apaMetadata, .apaAsset, .launcher, .nav, .metadataTranslations:
      return baseParams
    }
  }
  
}
