//
//  PawayProfile+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/7/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension PaywayProfile: Codable {
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case subscriptions = "subscriptions"
    case paymentMethods = "paymentMethods"
  }
}
