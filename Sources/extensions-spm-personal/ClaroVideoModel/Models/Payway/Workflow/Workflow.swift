//
//  Workflow.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/26/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class Workflow: NSObject {
  
  public var list: [Gateway]?
  public var contentId: String
  public var gateway: String
  public var gatewayText: String
  public var rentType: String
  public var rentaDescripcionContent: String
  public var rentaComprobanteMail: String
  public var email: String
  public var buyLink: String
  public var listBuyLinks: [Gateway]
  public var promos: [String: Any]
  public var contentInfo: [String: Any]
  public var contentPrice: String
  public var contentPriceDisplay: String
  public var contentGenres: Int
  public var contentRoles: Int
  public var hasSavedPayway: String
  public var hasUserSusc: String
  public var workflowNew: String
  public var cardNumber: String
  public var statusCreditCard: String
  
  
  // MARK: - Instance Methods
  public init(list: [Gateway]? = nil, contentId: String = "", gateway: String = "", gatewayText: String = "",
              rentType: String = "", rentaDescripcionContent: String = "", rentaComprobanteMail: String = "",
              email: String = "", buyLink: String = "", listBuyLinks:  [Gateway] = [],
              promos: [String: Any] = [:], contentInfo: [String: Any] = [:], contentPrice: String = "",
              contentPriceDisplay: String = "", contentGenres: Int = -1, contentRoles: Int = -1,
              hasSavedPayway: String = "", hasUserSusc: String = "", workflowNew: String = "",
              cardNumber: String = "", statusCreditCard: String = "") {
    self.list = list
    self.contentId = contentId
    self.gateway = gateway
    self.gatewayText = gatewayText
    self.rentType = rentType
    self.rentaDescripcionContent = rentaDescripcionContent
    self.rentaComprobanteMail = rentaComprobanteMail
    self.email = email
    self.buyLink = buyLink
    self.listBuyLinks = listBuyLinks
    self.promos = promos
    self.contentInfo = contentInfo
    self.contentPrice = contentPrice
    self.contentPriceDisplay = contentPriceDisplay
    self.contentGenres = contentGenres
    self.contentRoles = contentRoles
    self.hasSavedPayway = hasSavedPayway
    self.hasUserSusc = hasUserSusc
    self.workflowNew = workflowNew
    self.cardNumber = cardNumber
    self.statusCreditCard = statusCreditCard
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    //For Boughts and Rents
    let workflowContainerTry = try? container.nestedContainer(keyedBy: WorkflowKeys.self, forKey: .workflow)
    if let workflowContainer = workflowContainerTry {
      contentId = try workflowContainer.decodeIfPresent(String.self, forKey: .contentId) ?? ""
      gateway = try workflowContainer.decodeIfPresent(String.self, forKey: .gateway) ?? ""
      gatewayText = try workflowContainer.decodeIfPresent(String.self, forKey: .gatewayText) ?? ""
      rentType = try workflowContainer.decodeIfPresent(String.self, forKey: .rentType) ?? ""
      rentaDescripcionContent = try workflowContainer.decodeIfPresent(String.self, forKey: .rentaDescripcionContent) ?? ""
      rentaComprobanteMail = try workflowContainer.decodeIfPresent(String.self, forKey: .rentaComprobanteMail) ?? ""
      email = try workflowContainer.decodeIfPresent(String.self, forKey: .email) ?? ""
      buyLink = try workflowContainer.decodeIfPresent(String.self, forKey: .buyLink) ?? ""
      listBuyLinks = try workflowContainer.decodeIfPresent([Gateway].self, forKey: .listBuyLinks) ?? []
      promos = try workflowContainer.decodeIfPresent([String: Any].self, forKey: .promos) ?? [:]
      contentInfo = try workflowContainer.decodeIfPresent([String: Any].self, forKey: .contentInfo) ?? [:]
      contentPrice = try workflowContainer.decodeIfPresent(String.self, forKey: .contentPrice) ?? ""
      contentPriceDisplay = try workflowContainer.decodeIfPresent(String.self, forKey: .contentPriceDisplay) ?? ""
      contentGenres = try workflowContainer.decodeIfPresent(Int.self, forKey: .contentGenres) ?? -1
      contentRoles = try workflowContainer.decodeIfPresent(Int.self, forKey: .contentRoles) ?? -1
      statusCreditCard = try workflowContainer.decodeIfPresent(String.self, forKey: .statusCreditCard) ?? ""
      cardNumber = try workflowContainer.decodeIfPresent(String.self, forKey: .cardNumber) ?? ""
    }
    list = try container.decodeIfPresent([Gateway].self, forKey: .list)
    hasSavedPayway = try container.decodeIfPresent(String.self, forKey: .hasSavedPayway) ?? ""
    hasUserSusc = try container.decodeIfPresent(String.self, forKey: .hasUserSusc) ?? ""
    workflowNew = try container.decodeIfPresent(String.self, forKey: .workflowNew) ?? ""
  }
}
