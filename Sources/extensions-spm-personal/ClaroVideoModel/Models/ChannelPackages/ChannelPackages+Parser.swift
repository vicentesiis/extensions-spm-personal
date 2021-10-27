//
//  ChannelPackages+Parser.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 15/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

extension ChannelPackages: Codable {
  
  enum CodingKeys: String, CodingKey {
    case name
    case offerId = "offerid"
    case purchaseId = "purchaseid"
    case play
    case timeshift
    case npvrstorage
    case groups
    case paywayToken = "payway_token"
    case key
    
    case paymentmethod
    case gateway
  }
  
  public static func decodableArray(jsonDictionary: [[AnyHashable: Any]]) -> [ChannelPackages] {
    if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDictionary, options: []),
      let channelPackages = try? JSONDecoder().decode([ChannelPackages].self, from: jsonData) {
      return channelPackages
    }
    return []
  }
  
}
