//
//  EPGRequest.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 03/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

enum EPGRequest: RequestProtocol {
  
  case epgChannel(params: EPGChannelParams)
  case epgMenu
  case epgVersion
  
  var path: String {
    switch self {
    case .epgChannel:
      return "channel"
    case .epgMenu:
      return "menu"
    case .epgVersion:
      return "version"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .epgChannel, .epgMenu, .epgVersion:
      return .get
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .epgChannel, .epgMenu, .epgVersion:
      return [:]
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
    case .epgChannel, .epgMenu, .epgVersion:
      return 10.0
    }
  }
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .epgChannel(let params):
      baseParams["date_from"] = params.dateFrom
      baseParams["date_to"] = params.dateTo
      baseParams["filter_inactive"] = params.filterInactive
      if let channelList = params.channelList {
        baseParams["channel_list"] = channelList
      }
      if let nodeId = params.nodeId {
        baseParams["node_id"] = nodeId
      }
      return baseParams
    case .epgMenu:
      return baseParams
    case .epgVersion:
      return baseParams
    }
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    switch self {
    case .epgChannel, .epgMenu, .epgVersion:
      return [:]
    }
  }
  
}
