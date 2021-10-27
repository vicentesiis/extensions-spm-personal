//
//  Quality+Parceable.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/13/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Quality: Decodable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case id = "id"
    case label = "label"
  }
}
