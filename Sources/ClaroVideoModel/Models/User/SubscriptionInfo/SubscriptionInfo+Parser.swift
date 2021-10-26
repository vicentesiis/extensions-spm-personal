//
//  SubscriptionInfo+Parser.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 14/11/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension SubscriptionInfo: Codable {
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case productType = "producttype"
    case offerText = "offer_text"
    case purchaseInfo
    case waspurchase
  }
  
}
