//
//  Record+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/15/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Record: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case date = "date"
    case lastprogress = "lastprogress"
    case maxprogress = "maxprogress"
    case minutes = "minutes"
    case progress = "progress"
    case seconds = "seconds"
    case time = "time"
  }
}
