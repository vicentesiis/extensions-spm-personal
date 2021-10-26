//
//  MediaSelectionOption+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/10/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension MediaSelectionOption: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case identifier = "identifier"
    case internalOption = "internalOption"
    case externalOption = "externalOption"
  }
}
