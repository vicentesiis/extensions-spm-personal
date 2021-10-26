//
//  ChannelPackages.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 15/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

@objc(ChannelPackages)
open class ChannelPackages: NSObject {
  
  public var name: String = ""
  public var offerId: String = ""
  public var purchaseId: String = ""
  public var play: String = ""
  public var npvrstorage: String = ""
  public var timeshift: String = ""
  public var groups: String = ""
  public var paywayToken: String = ""
  public var key: String = ""
  public var gateway: String = ""
  
  //MARK: Init
  override init() {
    super.init()
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let codingKeys = try decoder.container(keyedBy: CodingKeys.self)
    name = try codingKeys.decodeIfPresent(String.self, forKey: .name) ?? ""
    offerId = try codingKeys.decodeIfPresent(String.self, forKey: .offerId) ?? ""
    purchaseId = try codingKeys.decodeIfPresent(String.self, forKey: .purchaseId) ?? ""
    play = try codingKeys.decodeIfPresent(String.self, forKey: .play) ?? ""
    npvrstorage = try codingKeys.decodeIfPresent(String.self, forKey: .npvrstorage) ?? ""
    timeshift = try codingKeys.decodeIfPresent(String.self, forKey: .timeshift) ?? ""
    groups = try codingKeys.decodeIfPresent(String.self, forKey: .groups) ?? ""
    paywayToken = try codingKeys.decodeIfPresent(String.self, forKey: .paywayToken) ?? ""
    key = try codingKeys.decodeIfPresent(String.self, forKey: .key) ?? ""
    
    if let paimenthMethodKeys = try? codingKeys.nestedContainer(keyedBy: CodingKeys.self, forKey: .paymentmethod) {
      gateway = try paimenthMethodKeys.decode(String.self, forKey: .gateway)
    } else if let gatewayCode = try codingKeys.decodeIfPresent(String.self, forKey: .gateway) {
      gateway = gatewayCode
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encodeIfPresent(name, forKey: .name)
    try codingKeys.encodeIfPresent(offerId, forKey: .offerId)
    try codingKeys.encodeIfPresent(purchaseId, forKey: .purchaseId)
    try codingKeys.encodeIfPresent(play, forKey: .play)
    try codingKeys.encodeIfPresent(npvrstorage, forKey: .npvrstorage)
    try codingKeys.encodeIfPresent(timeshift, forKey: .timeshift)
    try codingKeys.encodeIfPresent(groups, forKey: .groups)
    try codingKeys.encodeIfPresent(paywayToken, forKey: .paywayToken)
    try codingKeys.encodeIfPresent(key, forKey: .key)
    try codingKeys.encodeIfPresent(gateway, forKey: .gateway)
  }
}
