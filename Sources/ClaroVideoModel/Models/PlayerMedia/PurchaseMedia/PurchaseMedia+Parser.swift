//
//  PurchaseMedia+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/10/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension PurchaseMedia: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case acquisitionDate = "adquisition_date"
    case expirationDate = "expiration_date"
  }
}
