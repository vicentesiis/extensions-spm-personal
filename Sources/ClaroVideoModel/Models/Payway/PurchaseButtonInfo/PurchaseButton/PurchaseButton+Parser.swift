//
//  PurchaseButton+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/21/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension PurchaseButton: Decodable {
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case waspurchased
    case purchasechecked
    case price
    case offerid
    case currency
    case purchaseid
    case oneoffertype
    case linkworkflowstart
    case gateway
    case oneofferdesc
    case producttype
    case key
    case bannerpromo
    case family
    case banner
    case includes
    case buy
    case style
    case periodicity
    case bonus
    case visible
    case paywayToken = "payway_token"
    case frequency
    case paymentMethod = "paymentmethod"
    case advertisement
  }
}
