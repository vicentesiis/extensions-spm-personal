//
//  RecordingRequest.swift
//  ClaroVideoServices
//
//  Created by alonso.salcido on 11/16/18.
//  Copyright © 2018 amco. All rights reserved.
//

import Foundation

enum RecordingRequest: RequestProtocol {
  
  case addRecordingEventRequest(eventId:String,channelId: String, paywayToken: String, offset: Int?)
  case getRecordingListWithStatusRequest(status:String)
  case getRecordingListWithUriRequest(uri:String)
  case getRecordingDataWithEvent(eventId:String,channelId: String)
  case deleteRecordingDataWithUri(uri: String)
  case playRecordingDataWithUri(uri: String, paywayToken: String)
  case addRecordingSerie(eventId: String, channelId: String, groupId: String, paywayToken: String)
  
  var path: String {
    switch self {
    case .addRecordingEventRequest:
      return "add"
    case .getRecordingListWithStatusRequest:
      return "list"
    case .getRecordingListWithUriRequest(let uri):
      return  uri
    case .deleteRecordingDataWithUri(let uri):
      return  uri
    case .getRecordingDataWithEvent:
      return "data"
    case .playRecordingDataWithUri(let uri, _):
      return uri
    case .addRecordingSerie:
      return "series/add"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getRecordingListWithUriRequest, .deleteRecordingDataWithUri:
      return .get
    default:
      return .post
    }
  }
  
  var headers: HTTPHeaders {
    return ["": ""]
  }
  
  var timeoutInterval: TimeInterval {
    return 10.0
  }
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    let baseParams = baseParameters ?? [:]
    return baseParams
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case let .addRecordingEventRequest(eventId, channelId, paywayToken, offset):
      baseParams["event_id"] = eventId
      baseParams["channel_id"] = channelId
      baseParams["payway_token"] = paywayToken
      if let offset = offset {
        baseParams["offset"] = offset
      }
      return baseParams
    case .getRecordingListWithStatusRequest(let status):
      baseParams["status"] = status
      return baseParams
    case .getRecordingDataWithEvent(let eventId, let channelId):
      baseParams["event_id"] = eventId
      baseParams["channel_id"] = channelId
      return baseParams
    case .getRecordingListWithUriRequest, .deleteRecordingDataWithUri:
      return baseParams
    case .playRecordingDataWithUri(_ ,let paywayToken):
      return ["payway_token":paywayToken]
    case .addRecordingSerie(let eventId, let channelId, let groupId, let paywayToken):
      baseParams["event_id"] = eventId
      baseParams["channel_id"] = channelId
      baseParams["group_id"] = groupId
      baseParams["payway_token"] = paywayToken
      return baseParams
    }
  }
  
}
