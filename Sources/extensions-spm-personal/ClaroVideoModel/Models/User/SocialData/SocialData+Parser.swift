//
//  SocialData+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/7/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension SocialData: Codable {
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case id = "id"
    case birthday = "birthday"
    case email = "email"
    case firstName = "first_name"
    case gender = "gender"
    case lastName = "last_name"
    case urlLink = "link"
    case locale = "locale"
    case name = "name"
    case timezone = "timezone"
    case updatedTime = "updated_time"
    case verified = "verified"
    case imagenProfile = "imagen_profile"
    case token = "token"
    case tokenExpireDate = "token_expire_date"
  }
}

