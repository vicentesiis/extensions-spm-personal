//
//  Profile+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/25/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Profile: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case audiotype = "audiotype"
    case hd = "hd"
    case screenformat = "screenformat"
    case videotype = "videotype"
  }
  
  enum HDListKeys: String, CodingKey {
    case hdDetail = "detail"
    case hdEnabled = "enabled"
  }
}
