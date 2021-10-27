//
//  CVDuration+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/10/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension CVDuration: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case string = "string"
    case seconds = "seconds"
  }
}
