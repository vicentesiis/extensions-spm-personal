//
//  PincodeRequest.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 22/04/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

enum PincodeRequest: RequestProtocol {

  //Pin code
  case statusControlPin(userHash: String)
  case sendControlpinChannel(userHash: String, groupId: String, typeControlPin: TypeControlPin)
  case checkControlPin(controlPin: String)
  case modifycontrolpin(parameters: ModifyControlPinParameters)
  case remindcontrolpin
  
  var path: String {
    switch self {
    case .sendControlpinChannel(_, _,let typeControlPin):
      return "controlpin/channels/" + typeControlPin.rawValue
    case .checkControlPin:
      return "checkcontrolpin"
    case .statusControlPin:
      return "statuscontrolpin"
    case .modifycontrolpin:
      return "modifycontrolpin"
      case .remindcontrolpin:
      return "remindcontrolpin"
    }
  }
  
  var method: HTTPMethod {
    switch self {
      case .checkControlPin, .statusControlPin, .modifycontrolpin, .remindcontrolpin:
        return .get
      case .sendControlpinChannel:
        return .post
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
      case .sendControlpinChannel, .checkControlPin, .statusControlPin, .modifycontrolpin, .remindcontrolpin:
        return ["": ""]
    }
  }
  
  var cachePolicy: NSURLRequest.CachePolicy  {
    switch self {
      case  .sendControlpinChannel, .checkControlPin, .statusControlPin, .modifycontrolpin, .remindcontrolpin:
        return .reloadIgnoringLocalCacheData
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
      case .sendControlpinChannel, .checkControlPin, .statusControlPin, .modifycontrolpin, .remindcontrolpin:
        return 10.0
    }
  }
  
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
      case .sendControlpinChannel, .statusControlPin, .remindcontrolpin:
        break
      case let .checkControlPin( controlPin):
        baseParams["controlPIN"] = controlPin
      case .modifycontrolpin(let parameters):
        baseParams["status_purchase_pin"] = parameters.statusPurchasePin
        baseParams["status_parental_pin"] = parameters.statusParentalPin
        baseParams["status_channel_pin"] = parameters.statusChannelPin
        baseParams["accesss_parental_code"] = parameters.accesssParentalCode
        baseParams["pin"] = parameters.pin
    }
    return baseParams
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
      case .checkControlPin, .statusControlPin, .modifycontrolpin, .remindcontrolpin:
        return baseParams
      case .sendControlpinChannel(let userHash, let groupId, let type):
        baseParams["user_hash"] = userHash
        if type != .list {
          baseParams["group_id"] = groupId
        }
        return baseParams
    }
  }
}
