//
//  Module2+Parceable.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/1/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Module: Decodable {
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case name = "name"
    case type = "type"
    case components = "components"
  }
  enum ComponentsKeys: String, CodingKey {
    case component = "component"
  }
}
