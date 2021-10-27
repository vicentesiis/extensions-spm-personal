//
//  SearchResult+Parser.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 14/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

extension SearchResult: Decodable {
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case suggest    = "suggest"
    case prediction = "prediction"
  }
  
}
