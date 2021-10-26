//
//  TokenExpireData+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/7/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension TokenExpireDate: Codable {
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case date = "date"
    case timezone = "timezone"
    case timezoneType = "timezone_type"
  }
}
