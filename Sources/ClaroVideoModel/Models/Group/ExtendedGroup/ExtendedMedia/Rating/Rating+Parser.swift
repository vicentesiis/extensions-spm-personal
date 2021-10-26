//
//  Rating+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/25/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Rating: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case code = "code"
    case desc = "desc"
    case rating_id = "id"
  }
}
