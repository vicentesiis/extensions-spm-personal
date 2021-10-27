//
//  PurchaseButton.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/21/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public enum WaspurchasedValue: Decodable {
  case int(Int), string(String)
  public init(from decoder: Decoder) throws {
    if let int = try? decoder.singleValueContainer().decode(Int.self) {
      self = .int(int)
      return
    }
    if let string = try? decoder.singleValueContainer().decode(String.self) {
      self = .string(string)
      return
    }
    throw WaspurchasedError.missingValue
  }
  
  enum WaspurchasedError:Error {
    case missingValue
  }
}

public class PaymentMethod: NSObject, Decodable {
  public var gateway: String?
  public var gatewayText: String?

  enum CodingKeys: String, CodingKey {
    case gateway
    case gatewayText = "gateway_text"
  }

  required public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    gateway = try? container.decode(String.self, forKey: .gateway)
    gatewayText = try? container.decode(String.self, forKey: .gatewayText)
  }
}

public class Advertisement: NSObject, Decodable {
  public var adstierEnabled: String?

  enum CodingKeys: String, CodingKey {
    case adstierEnabled = "adstierenabled"
  }

  required public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    adstierEnabled = try? container.decode(String.self, forKey: .adstierEnabled)
  }
}

public final class PurchaseButton: NSObject {
  
  public var waspurchased: String
  public var purchasechecked: String
  public var price: String
  public var offerid: String
  public var currency: String
  public var purchaseid: String
  public var oneoffertype: String
  public var linkworkflowstart: String
  public var gateway: String
  public var oneofferdesc: String
  public var producttype: String
  public var key: String
  public var bannerpromo: String
  public var family: String
  public var banner: String
  public var includes: String
  public var buy: String
  public var style: String
  public var periodicity: String
  public var bonus: String
  public var visible: String
  public var paywayToken: String
  public var frequency: Int
  public var paymentMethod: PaymentMethod?
  public var advertisement: Advertisement?
  
  public init(waspurchased: String = "",
              purchasechecked: String = "",
              price: String = "",
              offerid: String = "",
              currency: String = "",
              purchaseid: String = "",
              oneoffertype: String = "",
              linkworkflowstart: String = "",
              gateway: String = "",
              oneofferdesc: String = "",
              producttype: String = "",
              key: String = "",
              bannerpromo: String = "",
              family: String = "",
              banner: String = "",
              includes: String = "",
              buy: String = "",
              style: String = "",
              periodicity: String = "",
              bonus: String = "",
              visible: String = "",
              paywayToken: String = "",
              frequency: Int = 0) {
    self.waspurchased = waspurchased
    self.purchasechecked = purchasechecked
    self.price = price
    self.offerid = offerid
    self.currency = currency
    self.purchaseid = purchaseid
    self.oneoffertype = oneoffertype
    self.linkworkflowstart = linkworkflowstart
    self.gateway = gateway
    self.oneofferdesc = oneofferdesc
    self.producttype = producttype
    self.key = key
    self.bannerpromo = bannerpromo
    self.family = family
    self.banner = banner
    self.includes = includes
    self.buy = buy
    self.style = style
    self.periodicity = periodicity
    self.bonus = bonus
    self.visible = visible
    self.paywayToken = paywayToken
    self.frequency = frequency
    self.paymentMethod = nil
    self.advertisement = nil
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    purchasechecked = try container.decodeIfPresent(String.self, forKey: .purchasechecked) ?? ""
    price = try container.decodeIfPresent(String.self, forKey: .price) ?? ""
    offerid = try container.decodeIfPresent(String.self, forKey: .offerid) ?? ""
    currency = try container.decodeIfPresent(String.self, forKey: .currency) ?? ""
    purchaseid = try container.decodeIfPresent(String.self, forKey: .purchaseid) ?? ""
    oneoffertype = try container.decodeIfPresent(String.self, forKey: .oneoffertype) ?? ""
    linkworkflowstart = try container.decodeIfPresent(String.self, forKey: .linkworkflowstart) ?? ""
    gateway = try container.decodeIfPresent(String.self, forKey: .gateway) ?? ""
    oneofferdesc = try container.decodeIfPresent(String.self, forKey: .oneofferdesc) ?? ""
    producttype = try container.decodeIfPresent(String.self, forKey: .producttype) ?? ""
    key = try container.decodeIfPresent(String.self, forKey: .key) ?? ""
    bannerpromo = try container.decodeIfPresent(String.self, forKey: .bannerpromo) ?? ""
    family = try container.decodeIfPresent(String.self, forKey: .family) ?? ""
    banner = try container.decodeIfPresent(String.self, forKey: .banner) ?? ""
    includes = try container.decodeIfPresent(String.self, forKey: .includes) ?? ""
    buy = try container.decodeIfPresent(String.self, forKey: .buy) ?? ""
    style = try container.decodeIfPresent(String.self, forKey: .style) ?? ""
    periodicity = try container.decodeIfPresent(String.self, forKey: .periodicity) ?? ""
    bonus = try container.decodeIfPresent(String.self, forKey: .bonus) ?? ""
    visible = try container.decodeIfPresent(String.self, forKey: .visible) ?? ""
    paywayToken = try container.decodeIfPresent(String.self, forKey: .paywayToken) ?? ""
    frequency = try container.decodeIfPresent(Int.self, forKey: .frequency) ?? 0
    //This one because in responses of see now comes as an Int not as a String
    if let waspurchasedValue = try container.decodeIfPresent(WaspurchasedValue.self, forKey: .waspurchased) {
      switch waspurchasedValue {
      case .int(let value):
        waspurchased = "\(value)"
      case .string(let value):
        waspurchased = value
      }
    }
    paymentMethod = try container.decodeIfPresent(PaymentMethod.self, forKey: .paymentMethod)
    advertisement = try container.decodeIfPresent(Advertisement.self, forKey: .advertisement)
  }
}
