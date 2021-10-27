//
//  ReminderRequest.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 22/04/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

enum ReminderRequest: RequestProtocol {
  
  case delete(reminderId: Int)
  case create(channelId: Int, eventId: Int, type: String, expDate: Int)
  case list
  
  var path: String {
    switch self {
    case .delete:
      return "delete"
    case .create:
      return "create"
    case .list:
      return "list"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .delete, .create, .list:
      return .get
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .delete, .create, .list:
      return ["": ""]
    }
  }
  
  var cachePolicy: NSURLRequest.CachePolicy  {
    switch self {
    case .delete, .create, .list:
      return .reloadIgnoringLocalCacheData
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
    case .delete, .create, .list:
      return 10.0
    }
  }
  
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .list:
      break
    case .delete(let reminderId):
      baseParams["reminder_id"] = reminderId
    case .create(let channelId, let eventId, let type, let expDate):
      baseParams["exp_date"] = expDate
      baseParams["type"] = type
      baseParams["channel_id"] = channelId
      baseParams["event_id"] = eventId
    }
    return baseParams
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    let baseParams = baseParameters ?? [:]
    switch self {
    case .delete, .create, .list:
      return baseParams
    }
  }
}
