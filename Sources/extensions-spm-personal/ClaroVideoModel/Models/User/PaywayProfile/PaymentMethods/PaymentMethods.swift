//
//  PaymentMethods.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/7/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class PaymentMethods: NSObject {
  public var gateway: String?
  public var gatewayText: String?
  public var status: String?
  public var userCategoryText: String?
  public var account: String?
  public var userCategory: String?
  
  // MARK: - Instance Methods
  public override init() {
    self.gateway = nil
    self.gatewayText = nil
    self.status = nil
    self.userCategoryText = nil
    self.account = nil
    self.userCategory = nil
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    gateway = try? container.decodeIfPresent(String.self, forKey: .gateway)
    gatewayText = try? container.decodeIfPresent(String.self, forKey: .gatewayText)
    status = try? container.decodeIfPresent(String.self, forKey: .status)
    userCategoryText = try? container.decodeIfPresent(String.self, forKey: .userCategoryText)
    account = try? container.decodeIfPresent(String.self, forKey: .account)
    userCategory = try? container.decodeIfPresent(String.self, forKey: .userCategory)
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(gateway, forKey: .gateway)
    try codingKeys.encode(gatewayText, forKey: .gatewayText)
    try codingKeys.encode(status, forKey: .status)
    try codingKeys.encode(userCategoryText, forKey: .userCategoryText)
    try codingKeys.encode(account, forKey: .account)
    try codingKeys.encode(userCategory, forKey: .userCategory)
  }
}
