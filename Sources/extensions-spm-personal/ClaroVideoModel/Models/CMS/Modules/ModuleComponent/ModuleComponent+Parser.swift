//
//  ModuleComponent+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/1/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension ModuleComponent: Decodable {
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case name = "name"
    case type = "type"
    case properties = "properties"
  }
}
