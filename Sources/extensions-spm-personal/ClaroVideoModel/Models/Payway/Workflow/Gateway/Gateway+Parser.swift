//
//  Gateway+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/26/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Gateway: Decodable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case name = "gateway"
    case text = "gatewaytext"
    case buyLink = "buyLink"
    case productId = "product_id"
    case accessCode = "accessCode"
    case msgAccessCode = "msgAccessCode"
    case productType = "producttye"
  }
}
