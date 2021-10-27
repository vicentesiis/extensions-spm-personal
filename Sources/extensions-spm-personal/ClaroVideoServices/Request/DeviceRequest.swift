//
//  DeviceRequest.swift
//  ClaroVideoServices
//
//  Created by Luis Salcido on 31/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

enum DeviceRequest: RequestProtocol {
  case attach(groupId: String, purchaseId: String?)
  
  var path: String {
    switch self {
    case .attach:
      return "/device/attach"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .attach:
       return .get
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .attach:
       return ["": ""]
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
    case .attach:
      return 10.0
    }
  }
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .attach(let groupId, let purchaseId):
      baseParams["group_id"] = groupId
      if let idPurchase = purchaseId, idPurchase != "" {
        baseParams["purchase_id"] = idPurchase
      }
      return baseParams
    }
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    return nil
  }
}
