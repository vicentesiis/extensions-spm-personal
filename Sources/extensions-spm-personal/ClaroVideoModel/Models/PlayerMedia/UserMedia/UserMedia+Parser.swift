//
//  UserMedia+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/9/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension UserMedia: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case parentalRating = "parental_rating"
    case firstView = "first_view"
    case lasttouch = "lasttouch"
  }
}
