//
//  PaymentMethods+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/7/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension PaymentMethods: Codable {
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case gateway = "gateway"
    case gatewayText = "gateway_text"
    case status = "status"
    case userCategoryText = "user_category_text"
    case account = "account"
    case userCategory = "user_category"
  }
}
