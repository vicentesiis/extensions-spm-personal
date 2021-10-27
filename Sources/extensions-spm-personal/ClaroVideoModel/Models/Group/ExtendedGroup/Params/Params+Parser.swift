//
//  Params+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/22/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Params: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case desc = "desc"
    case est = "est"
    case paramsId = "id"
    case name = "name"
    case media = "media"
    case sellType = "sell_type"
    case types = "types"
    case type = "type"
    case talents = "talents"
    //External Talents
    case roleName = "role_name"
    case roleId = "role_id"
  }
  enum TalentstKeys: String, CodingKey {
    case talent = "talent"
  }
}
