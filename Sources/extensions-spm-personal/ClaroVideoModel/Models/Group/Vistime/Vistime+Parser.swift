//
//  Vistime+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/15/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Vistime: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case viewed = "viewed"
    case duration = "duration"
    case last = "last"
    case max = "max"
  }
}
