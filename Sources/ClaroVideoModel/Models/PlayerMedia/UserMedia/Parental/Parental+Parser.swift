//
//  Parental+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/9/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Parental: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case requiresValidation = "requires_validation"
    case sha1PinCode = "sha1_pincode"
  }
}
