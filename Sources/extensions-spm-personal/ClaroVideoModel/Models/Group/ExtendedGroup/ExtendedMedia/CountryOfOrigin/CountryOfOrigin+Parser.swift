//
//  CountryOfOrigin+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/25/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension CountryOfOrigin: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case code = "code"
    case desc = "desc"
  }
}
