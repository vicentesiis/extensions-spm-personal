//
//  Subscriptions+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/7/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Subscriptions: Codable {
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case name = "name"
    case key = "key"
    case paymentMethod = "paymentmethod"
  }
}
