//
//  PaywayRequest.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/20/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

enum PaywayRequest: RequestProtocol {
  
  case purchasebuttoninfo(groupId: String?, isLive: Bool?, seassonId: String?, objectType: String)
  case workflowstart(uri: String)
  case buyConfirm(uri: String, ticket: String, payway: String, token: String)
  case linealChannels
  case dataSuscription
  case multiPurchaseButtonInfo(groupIds: [String], token: String)
  
    var path: String {
    switch self {
    case .purchasebuttoninfo:
      return "purchasebuttoninfo"
    case .workflowstart(let uri):
      return uri
    case .buyConfirm(let uri, _, _, _):
      return uri
    case .linealChannels:
      return "linealchannels"
    case .dataSuscription:
        return "data"
    case .multiPurchaseButtonInfo:
      return "multipurchasebuttoninfo"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case  .purchasebuttoninfo, .workflowstart, .linealChannels, .dataSuscription:
      return .get
    case .buyConfirm, .multiPurchaseButtonInfo:
      return .post
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .purchasebuttoninfo, .workflowstart, .linealChannels, .dataSuscription, .multiPurchaseButtonInfo:
      return ["": ""]
    case .buyConfirm:
      return ["Content-Type": "multipart/form-data; boundary=Boundary-ClaroVideo/iTunes"]
    }
  }
  
  var cachePolicy: NSURLRequest.CachePolicy  {
    switch self {
    case .purchasebuttoninfo, .workflowstart, .buyConfirm, .linealChannels, .dataSuscription, .multiPurchaseButtonInfo:
      return .reloadIgnoringLocalCacheData
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
    case .purchasebuttoninfo, .workflowstart, .linealChannels, .dataSuscription, .multiPurchaseButtonInfo:
      return 10.0
    case .buyConfirm:
      return 30.0
    }
  }
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
        var baseParams = baseParameters ?? [:]
    switch self {
    case .workflowstart, .buyConfirm, .multiPurchaseButtonInfo:
      return baseParams
    case .dataSuscription:
      return baseParams
    case .purchasebuttoninfo(let groupId, let isLive, let seassonId, let objectType):
      if let groupId = groupId {
        baseParams["group_id"] = groupId
      } else {
        baseParams["object_type"] = objectType
      }
      if let seassonId = seassonId {
        baseParams["season_id"] = seassonId
      }
      if let isLive = isLive {
        baseParams["islive"] = isLive
      }
      return baseParams
    case .linealChannels:
      return baseParams
    }
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams: ServiceParameters = [:]
    switch self {
    case .workflowstart, .purchasebuttoninfo, .linealChannels, .dataSuscription:
      return baseParams
    case .buyConfirm(_, let ticket, let payway, let token):
      baseParams["ticket"] = ticket
      baseParams["payway"] = payway
      baseParams["token"] = token
      return baseParams
    case .multiPurchaseButtonInfo(let groupIds ,let token):
      baseParams["token"] = token
      baseParams["group_ids"] = groupIds
      return baseParams
    }
  }
}
