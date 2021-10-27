//
//  Workflow+Parceable.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/26/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Workflow: Parceable {
  public static func parseObject(dictionary: [String : Any]) -> Result<Workflow, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      // here "jsonData" is the dictionary encoded in JSON data
      let workflow = try JSONDecoder().decode(Workflow.self, from: jsonData)
      return .success(workflow)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
}

extension Workflow: Decodable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case workflow = "workflow"
    case hasSavedPayway = "hasSavedPayway"
    case hasUserSusc = "hasUserSusc"
    case workflowNew = "newWorkflow"
    case list = "list"
  }
  enum WorkflowKeys: String, CodingKey {
    case contentId = "contentId"
    case gateway = "gateway"
    case gatewayText = "gatewayText"
    case rentType = "renttype"
    case rentaDescripcionContent = "rentaDescripcionContent"
    case rentaComprobanteMail = "rentaComprobanteMail"
    case email = "email"
    case buyLink = "buyLink"
    case listBuyLinks = "listBuyLinks"
    case promos = "promos"
    case contentInfo = "contentInfo"
    case contentPrice = "contentPrice"
    case contentPriceDisplay = "contentPriceDisplay"
    case contentGenres = "contentGenres"
    case contentRoles = "contentRoles"
    case cardNumber = "cardNumber"
    case statusCreditCard = "statusCreditCard"
  }
}
