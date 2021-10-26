//
//  Episode+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/25/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Episode: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case season = "season"
    case number = "number"
  }
}
