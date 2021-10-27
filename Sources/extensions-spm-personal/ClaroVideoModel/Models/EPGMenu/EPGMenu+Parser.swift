//
//  EPGMenu+Parser.swift
//  ClaroVideoServices
//
//  Created by Miguel Perera on 10/02/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

extension EPGMenu: Decodable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case id = "id"
    case idParent = "id_parent"
    case code = "code"
    case text = "text"
    case menuID = "menu_id"
    case image = "image"
    case imageOver = "image_over"
    case level = "level"
    case type = "type"
    case order = "order"
    case status = "status"
    case appBehaviour = "app_behaviour"
  }
}
