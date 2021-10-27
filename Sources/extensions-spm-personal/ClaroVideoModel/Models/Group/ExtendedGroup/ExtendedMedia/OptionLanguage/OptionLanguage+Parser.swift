//
//  OptionLanguage+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/25/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension OptionLanguage: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case groupId = "group_id"
    case contentId = "content_id"
    case optionId = "option_id"
    case languageId = "id"
    case isCurrent = "is_current"
    case labelShort = "label_short"
    case labelLarge = "label_large"
    case encodes = "encodes"
    case audio = "audio"
    case subtitle = "subtitle"
    case introStart = "intro_start_time"
    case introFinish = "intro_finish_time"
  }
}
