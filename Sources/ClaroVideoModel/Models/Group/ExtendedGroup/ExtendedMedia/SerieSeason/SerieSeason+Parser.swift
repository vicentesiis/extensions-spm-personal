//
//  SerieSeason+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/25/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension SerieSeason: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case serieSeason_id = "id"
    case title = "title"
    case number = "number"
    case image_large = "image_large"
    case image_medium = "image_medium"
    case image_small = "image_small"
    case image_background = "image_background"
    case last_season = "last_season"
    case title_original = "title_original"
    case first_episode = "first_episode"
    case episodes = "episodes"
  }
  
  public class func createOrUpdate(value:Any) -> [SerieSeason]? {
    return ParserHelper.parseSimpleObject(of: [SerieSeason].self, data: value)
  }
}
