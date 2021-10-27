//
//  MusicMiddlewareRequest.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 30/07/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

enum MusicMiddlewareRequest: RequestProtocol {
  
  case isLoggedin(email: String)
  case musicLevel
  case getPlaylistDetailWithUri
  case getPlayerWith(mediasOnly: Bool)
  case playerGetMediaWith(listId: String, track: String)
  case sendSuccessTrackWith(params: [String: Any])
  case sendTrackEventWith
  case ribbon
  
  var path: String {
    switch self {
    case .isLoggedin:
      return "isLoggedIn"
    case .musicLevel:
      return "level"
    case .playerGetMediaWith:
      return "playerGetMedia"
    case .ribbon:
      return "ribbon"
    case .getPlaylistDetailWithUri,
         .getPlayerWith,
         .sendSuccessTrackWith,
         .sendTrackEventWith:
      return ""
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .musicLevel, .getPlaylistDetailWithUri, .getPlayerWith, .sendTrackEventWith,.ribbon:
      return .get
      case .isLoggedin, .playerGetMediaWith, .sendSuccessTrackWith:
      return .post
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    default:
      return [:]
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
    default:
      return 10.0
    }
  }
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .getPlayerWith(let mediasOnly):
      baseParams["mediasOnly"] = mediasOnly
      baseParams["pagination"] = false
      return baseParams
    case .playerGetMediaWith,
         .sendTrackEventWith,
         .isLoggedin,
         .musicLevel,
         .sendSuccessTrackWith,
         .getPlaylistDetailWithUri,
         .ribbon:
        return baseParams
    }
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .isLoggedin(let email):
      baseParams["mail"] = email
      return baseParams
    case .playerGetMediaWith(let listId, let track):
      baseParams["list_id"] = listId
      baseParams["track"] = track
      return baseParams
    case .sendSuccessTrackWith(let params):
      baseParams = params
      return baseParams
    case .musicLevel,
         .getPlaylistDetailWithUri,
         .getPlayerWith,
         .ribbon,
         .sendTrackEventWith:
      return [:]
    }
  }
  
  
}
