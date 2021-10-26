//
//  PushNotificationRequest.swift
//  ClaroVideoServices
//
//  Created by Luis Salcido on 04/02/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

enum PushNotificationRequest: RequestProtocol {
  case addToken(notificationData: RemoteNotificationData)
  case deleteToken(notificationData: RemoteNotificationData)
  
  var path: String {
    switch self {
    case .addToken:
      return "add"
    case .deleteToken:
      return "delete"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .addToken,.deleteToken:
      return .post
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .addToken(let notificationData), .deleteToken(let notificationData):
      var headers = ["Content-Type":"application/x-www-form-urlencoded"]
      if let XAPPID = notificationData.xappid {
        headers["X-APPID"] = XAPPID
      }
      return headers
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
    case .addToken,.deleteToken:
      return 10.0
    }
  }
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
     switch self {
       case .addToken,.deleteToken:
        return [:]
       }
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var parameters: [String: Any] = [:]
    switch (self) {
    case .addToken(let notificationData):
      parameters = ["userId": notificationData.userId ?? "",
                    "partner": notificationData.partner,
                    "os": notificationData.os,
                    "version": notificationData.version,
                    "device": notificationData.device,
                    "token": notificationData.token,
                    "metadata": ["subscriptionType": notificationData.subscriptionType]]
      
      case .deleteToken(let notificationData):
        parameters = ["userId"  : notificationData.userId ?? "",
                      "partner" : notificationData.partner,
                      "tokens"   : [notificationData.token]]
    }
    
    if let jsonData = try? JSONSerialization.data(withJSONObject: parameters),
      let jsonString = String(data: jsonData, encoding: .utf8) {
      return ["parameters":jsonString]
    }
    return [:]
  }
}
