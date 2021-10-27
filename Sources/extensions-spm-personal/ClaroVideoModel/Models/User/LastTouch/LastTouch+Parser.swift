//
//  LastTouch+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/7/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension LastTouch: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case seen = "seen"
    case favorited = "favorited"
    case purchased = "purchased"
    case profile = "profile"
    case reminder = "reminder"
    case liveChannel = "livechannel"
  }
}
