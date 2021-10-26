//
//  ExtendedGroup+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/22/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension ExtendedGroup: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case keywords = "keywords"
    case genres = "genres"
    case roles = "roles"
    case format = "format"
    case media = "media"
  }
  enum InsideListKeys: String, CodingKey {
    case keyword = "keyword"
    case genre = "genre"
    case role = "role"
  }
}
