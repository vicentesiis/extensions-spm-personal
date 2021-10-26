//
//  SearchRequest.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 13/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

enum SearchRequest: RequestProtocol {
  
  case getVerticalSearchResults(field: String, value: String, start: Int, quantity: Int, provider: String?)
  case getGenericSearchResults(searchString: String, start: Int, quantity: Int)
  case fetchSearch(searchText: String, searchParams: [String: Any])
  case getVerticalLookUpResultds(string: String, fiel: String, start: Int, quantity: Int)
  case linealpredictive(searchText: String, searchParams: [String: Any])
  
  var path: String {
    switch self {
    case .getVerticalSearchResults:
      return "vertical"
    case .getGenericSearchResults:
      return "generic"
    case .fetchSearch:
      return "predictive"
    case .getVerticalLookUpResultds:
      return "verticallookup"
    case .linealpredictive:
      return "linealpredictive"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getVerticalSearchResults, .getGenericSearchResults, .fetchSearch, .getVerticalLookUpResultds, .linealpredictive:
      return .get
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .getVerticalSearchResults, .getGenericSearchResults, .fetchSearch, .getVerticalLookUpResultds, .linealpredictive:
      return ["": ""]
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
    case .getVerticalSearchResults, .getGenericSearchResults, .fetchSearch, .getVerticalLookUpResultds, .linealpredictive:
      return 10.0
    }
  }
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .getVerticalSearchResults(let field, let value, let start, let quantity, let provider):
      baseParams["field"] = field
      baseParams["value"] = value
      baseParams["from"] = start
      baseParams["quantity"] = quantity
      if let prov = provider, !prov.isEmpty, prov != "null" {
        baseParams["provider_id"] = provider ?? ""
      }
    case .getGenericSearchResults(let searchString, let start, let quantity):
      baseParams["value"] = searchString
      baseParams["from"] = start
      baseParams["quantity"] = quantity
    case .fetchSearch(let searchText, let searchParams):
      for (key, value) in searchParams {
        baseParams[key] = value
      }
      baseParams["value"] = searchText
    case .getVerticalLookUpResultds(let string, let fiel, let start, let quantity):
      baseParams["field"] = fiel
      baseParams["value"] = string
      baseParams["from"] = start
      baseParams["quantity"] = quantity
    case .linealpredictive(let searchText, let searchParams):
      for (key, value) in searchParams {
        baseParams[key] = value
      }
      baseParams["value"] = searchText
    }
    return baseParams
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    return baseParameters
  }
  
}
