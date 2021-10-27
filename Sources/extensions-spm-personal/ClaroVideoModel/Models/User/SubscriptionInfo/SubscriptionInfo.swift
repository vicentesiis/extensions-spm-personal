//
//  SubscriptionInfo.swift
//  ClaroVideoServices
//
//  Created by Adrián Salazar G on 11/8/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public class SubscriptionInfo: NSObject {
  
  public var productType: String? = nil
  public var offerText: String? = nil
  public var purchaseInfo: [String: Any]? = nil
  public var waspurchase: Int
  
  override public init() {
    self.productType = nil
    self.offerText = nil
    self.purchaseInfo = nil
    self.waspurchase = 0
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    productType = try? container.decode(String.self, forKey: .productType)
    offerText = try? container.decode(String.self, forKey: .offerText)
    waspurchase = (try? container.decode(Int.self, forKey: .waspurchase)) ?? 0
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(productType, forKey: .productType)
    try codingKeys.encode(offerText, forKey: .offerText)
    try codingKeys.encode(waspurchase, forKey: .waspurchase)
    let purchaseInfoStr = ParserHelper.encodeObject(data: purchaseInfo)
    try codingKeys.encode(purchaseInfoStr, forKey: .purchaseInfo)
  }
  
  public class func decodeArray(arrayDic: [[String: Any]]) -> [SubscriptionInfo] {
    var arraySubscription: [SubscriptionInfo] = []
    for dic in arrayDic {
      if let subs = ParserHelper.parseSimpleObject(of: SubscriptionInfo.self, data: dic) {
        if let purchaseData = dic["purchase_data"] as? [String: Any] {
          subs.purchaseInfo = purchaseData
        }
        arraySubscription.append(subs)
      }
    }
    return arraySubscription
  }
  
}
