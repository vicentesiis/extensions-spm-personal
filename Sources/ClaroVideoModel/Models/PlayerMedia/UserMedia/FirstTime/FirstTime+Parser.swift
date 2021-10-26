//
//  FirstTime+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/10/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension FirstTime: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case byDevicePurchase = "by_device_purchase"
    case byDeviceAccount = "by_device_account"
    case byPurchase = "by_purchase"
    case enabled = "enabled"
    case expirationDate = "expiration_date"
    case expirationHours = "expiration_hours"
    case beginDate = "begin_date"
    case adquisitionDate = "adquisition_date"
  }
}
