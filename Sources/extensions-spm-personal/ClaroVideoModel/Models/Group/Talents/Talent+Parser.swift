//
//  Talent+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/22/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Talent: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case talentId = "id"
    //Gracenote
    case firstName = "first_name"
    case lastName = "last_name"
    case imageUrl = "image"
    case gender
    case birthPlace = "birth_place"
    case birthDate = "birth_date"
    case deathDate = "death_date"
    case internalIds = "internal_ids"
    case awards
    // Default
    case fullName = "fullname"
    case name = "name"
    case surname = "surname"
    
    
    case providerCode = "provider_code"
    case type
  }
}

