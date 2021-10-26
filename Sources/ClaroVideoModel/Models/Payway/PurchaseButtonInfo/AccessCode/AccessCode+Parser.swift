//
//  AccessCode+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/21/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension AccessCode: Decodable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case enabled = "enabled"
    case msgAccessCode = "msgAccessCode"
  }
}
