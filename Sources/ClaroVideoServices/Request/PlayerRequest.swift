//
//  PlayerRequest.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/9/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

enum PlayerRequest: RequestProtocol {
  
  case getMedia(getMediaParams: GetMediaParams)
  case getQualities(language: String)
  case sendTrackEvent
  case sendClaroDashboardEvent
  case getCkc
  
  var path: String {
    switch self {
    case .getMedia:
      return "getmedia"
    case .getQualities, .sendTrackEvent, .sendClaroDashboardEvent, .getCkc:
      return ""
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case  .getMedia, .sendClaroDashboardEvent, .getCkc:
      return .post
    case .getQualities, .sendTrackEvent:
      return .get
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .getMedia:
      return ["pragma": "akamai-x-get-client-ip, akamai-x-cache-on, akamai-x-cache-remote-on, akamai-x-check-cacheable, akamai-x-get-cache-key, akamai-x-get-extracted-values, akamai-x-get-nonces, akamai-x-get-ssl-client-session-id, akamai-x-get-true-cache-key, akamai-x-serial-no, akamai-x-feo-trace, akamai-x-get-request-id"]
    case .getQualities, .sendTrackEvent:
      return [:]
    case .sendClaroDashboardEvent:
      return ["Content-Type": "application/json","Accept-Language": "es-MX;q=1, en-MX;q=0.9"]
    case .getCkc:
      return ["Content-Type": "application/json"]
    }
  }
  
  var cachePolicy: NSURLRequest.CachePolicy  {
    switch self {
    case .getMedia, .getQualities, .sendTrackEvent, .sendClaroDashboardEvent, .getCkc:
      return .reloadIgnoringLocalCacheData
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
    case .getMedia, .getQualities, .sendTrackEvent, .sendClaroDashboardEvent, .getCkc:
      return 20.0
    }
  }
  
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .sendTrackEvent:
      return baseParams
    case .getMedia(let getMediaParams):
      baseParams["group_id"] = getMediaParams.groupId
      baseParams["content_id"] = getMediaParams.contentId
      baseParams["preview"] = getMediaParams.isTrailer
      baseParams["stream_type"] = getMediaParams.streamType
      baseParams["region"] = getMediaParams.region
      baseParams["startTime"] = getMediaParams.startTime
      baseParams["endTime"] = getMediaParams.endTime
      return baseParams
    case .getQualities(let language):
      baseParams["askqlang"] = language
      baseParams["askq"] = "q"
      return baseParams
    case .sendClaroDashboardEvent, .getCkc:
      return [:]
    }
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .sendTrackEvent, .getQualities, .getCkc:
      return baseParams
    case .getMedia(let getMediaParams):
      baseParams["payway_token"] = getMediaParams.paywayToken
      baseParams["user_token"] = getMediaParams.userToken
      return baseParams
    case .sendClaroDashboardEvent:
      return ["logs":[baseParameters]]
    }
  }
}


