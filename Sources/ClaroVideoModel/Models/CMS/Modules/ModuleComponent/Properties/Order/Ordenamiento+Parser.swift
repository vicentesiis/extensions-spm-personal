//
//  Ordenamiento+Parser.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 17/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

extension Ordenamiento: Decodable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case order = "order"
    case label = "label"
  }
}
