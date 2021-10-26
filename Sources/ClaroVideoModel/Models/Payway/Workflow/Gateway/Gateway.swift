//
//  Gateway.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/26/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class Gateway: NSObject, NSCoding {
  public var name: String
  public var text: String
  public var buyLink: String
  public var productId: String
  public var accessCode: Bool
  public var msgAccessCode: String
  public var productType: String
  
  public init(name: String = "", text: String = "", buyLink: String = "",
              productId: String = "", accessCode: Bool = false, msgAccessCode: String = "",
              productType: String = "") {
    self.name = name
    self.text = text
    self.buyLink = buyLink
    self.productId = productId
    self.accessCode = accessCode
    self.msgAccessCode = msgAccessCode
    self.productType = productType
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""
    buyLink = try container.decodeIfPresent(String.self, forKey: .buyLink) ?? ""
    productId = try container.decodeIfPresent(String.self, forKey: .productId) ?? ""
    accessCode = try container.decodeIfPresent(Bool.self, forKey: .accessCode) ?? false
    msgAccessCode = try container.decodeIfPresent(String.self, forKey: .msgAccessCode) ?? ""
    productType = try container.decodeIfPresent(String.self, forKey: .productType) ?? ""
  }
  
  public init?(coder: NSCoder) {
    name = coder.decodeObject(forKey: "name") as! String
    text = coder.decodeObject(forKey: "text") as! String
    buyLink = coder.decodeObject(forKey: "buyLink") as! String
    productId = coder.decodeObject(forKey: "productId") as! String
    accessCode = coder.decodeObject(forKey: "accessCode") as! Bool
    msgAccessCode = coder.decodeObject(forKey: "msgAccessCode") as! String
    productType = coder.decodeObject(forKey: "productType") as! String
  }
  
  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(text, forKey: "text")
    aCoder.encode(buyLink, forKey: "buyLink")
    aCoder.encode(productId, forKey: "productId")
    aCoder.encode(accessCode, forKey: "accessCode")
    aCoder.encode(msgAccessCode, forKey:"msgAccessCode")
    aCoder.encode(productType, forKey:"productType")
  }
}
