//
//  LanguageFormat+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/25/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension LanguageFormat: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case language_id = "id"
    case desc = "desc"
  }
}
