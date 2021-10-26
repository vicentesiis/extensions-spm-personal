//
//  DownloadRequest.swift
//  ClaroVideoServices
//
//  Created by Luis Salcido on 04/02/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

enum DownloadRequest: RequestProtocol {
  case getMedia(getMediaParams: GetMediaParams)
  case getLicense(getMediaParams: GetMediaParams)
  
  var path: String {
    switch self {
    case .getMedia:
      return "getmedia"
    case .getLicense:
      return "getlicense"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getMedia, .getLicense:
      return .post
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .getMedia,.getLicense:
      return [:]
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
    case .getMedia, .getLicense:
      return 10.0
    }
  }
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .getMedia(let getMediaParams),.getLicense(let getMediaParams):
      baseParams["group_id"] = getMediaParams.groupId
      baseParams["stream_type"] = getMediaParams.streamType
      baseParams["content_id"] = getMediaParams.contentId
      return baseParams
    }
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .getMedia(let getMediaParams),.getLicense(let getMediaParams):
      baseParams["payway_token"] = getMediaParams.paywayToken
      baseParams["user_token"] = getMediaParams.userToken
      return baseParams
    }
  }
  
  
}
