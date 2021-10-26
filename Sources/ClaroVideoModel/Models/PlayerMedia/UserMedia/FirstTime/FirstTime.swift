//
//  Firsttime.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/10/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

@objc(Firsttime)
public final class FirstTime: NSObject, NSCoding {
  
  public var byDevicePurchase: Bool
  public var byDeviceAccount: Bool
  public var byPurchase: Bool
  public var enabled: Bool
  public var expirationDate: String
  public var expirationHours: Int
  public var beginDate: String
  public var adquisitionDate: String
  
  // MARK: - Instance Methods
  public override init() {
    self.byDevicePurchase = false
    self.byDeviceAccount = false
    self.byPurchase = false
    self.enabled = false
    self.expirationDate = ""
    self.expirationHours = -1
    self.beginDate = ""
    self.adquisitionDate = ""
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(byDevicePurchase, forKey: coding.byDevicePurchase.rawValue)
    coder.encode(byDeviceAccount, forKey: coding.byDeviceAccount.rawValue)
    coder.encode(byPurchase, forKey: coding.byPurchase.rawValue)
    coder.encode(enabled, forKey: coding.enabled.rawValue)
    coder.encode(expirationDate, forKey: coding.expirationDate.rawValue)
    coder.encode(expirationHours, forKey: coding.expirationHours.rawValue)
    coder.encode(beginDate, forKey: coding.beginDate.rawValue)
    coder.encode(adquisitionDate, forKey: coding.adquisitionDate.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let byDevicePurchaseDecode = coder.decodeObject(forKey: coding.byDevicePurchase.rawValue) as? Bool
    let byDeviceAccountDecode = coder.decodeObject(forKey: coding.byDeviceAccount.rawValue) as? Bool
    let byPurchaseDecode = coder.decodeObject(forKey: coding.byPurchase.rawValue) as? Bool
    let enabledDecode = coder.decodeObject(forKey: coding.enabled.rawValue) as? Bool
    let expirationDateDecode = coder.decodeObject(forKey: coding.expirationDate.rawValue) as? String
    let expirationHoursDecode = coder.decodeObject(forKey: coding.expirationHours.rawValue) as? Int
    let beginDateDecode = coder.decodeObject(forKey: coding.beginDate.rawValue) as? String
    let adquisitionDateDecode = coder.decodeObject(forKey: coding.adquisitionDate.rawValue) as? String
    self.init()
    self.byDevicePurchase = byDevicePurchaseDecode ?? false
    self.byDeviceAccount = byDeviceAccountDecode ?? false
    self.byPurchase = byPurchaseDecode ?? false
    self.enabled = enabledDecode ?? false
    self.expirationDate = expirationDateDecode ?? ""
    self.expirationHours = expirationHoursDecode ?? -1
    self.beginDate = beginDateDecode ?? ""
    self.adquisitionDate = adquisitionDateDecode ?? ""
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    byDevicePurchase = try container.decodeIfPresent(Bool.self, forKey: .byDevicePurchase) ?? false
    byDeviceAccount = try container.decodeIfPresent(Bool.self, forKey: .byDeviceAccount) ?? false
    byPurchase = try container.decodeIfPresent(Bool.self, forKey: .byPurchase) ?? false
    enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled) ?? false
    expirationDate = try container.decodeIfPresent(String.self, forKey: .expirationDate) ?? ""
    expirationHours = try container.decodeIfPresent(Int.self, forKey: .expirationHours) ?? -1
    beginDate = try container.decodeIfPresent(String.self, forKey: .beginDate) ?? ""
    adquisitionDate = try container.decodeIfPresent(String.self, forKey: .adquisitionDate) ?? ""
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(byDevicePurchase, forKey: .byDevicePurchase)
    try codingKeys.encode(byDeviceAccount, forKey: .byDeviceAccount)
    try codingKeys.encode(byPurchase, forKey: .byPurchase)
    try codingKeys.encode(enabled, forKey: .enabled)
    try codingKeys.encode(expirationDate, forKey: .expirationDate)
    try codingKeys.encode(expirationHours, forKey: .expirationHours)
    try codingKeys.encode(beginDate, forKey: .beginDate)
    try codingKeys.encode(adquisitionDate, forKey: .adquisitionDate)
  }
}
