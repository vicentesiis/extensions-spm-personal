//
//  SerieSeason.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/25/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class SerieSeason: NSObject, NSCoding {
  
  public var serieSeason_id: String
  public var title: String
  public var number: String
  public var image_large: String
  public var image_medium: String
  public var image_small: String
  public var image_background: String
  public var last_season: String
  public var title_original: String
  public var first_episode: String
  public var episodes: [Group]
  
  
  public override init() {
    self.serieSeason_id = ""
    self.title = ""
    self.number = ""
    self.image_large = ""
    self.image_medium = ""
    self.image_small = ""
    self.image_background = ""
    self.last_season = ""
    self.title_original = ""
    self.first_episode = ""
    self.episodes = []
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(serieSeason_id, forKey: coding.serieSeason_id.rawValue)
    coder.encode(title, forKey: coding.title.rawValue)
    coder.encode(number, forKey: coding.number.rawValue)
    coder.encode(image_large, forKey: coding.image_large.rawValue)
    coder.encode(image_medium, forKey: coding.image_medium.rawValue)
    coder.encode(image_small, forKey: coding.image_small.rawValue)
    coder.encode(image_background, forKey: coding.image_background.rawValue)
    coder.encode(last_season, forKey: coding.last_season.rawValue)
    coder.encode(title_original, forKey: coding.title_original.rawValue)
    coder.encode(first_episode, forKey: coding.first_episode.rawValue)
    coder.encode(episodes, forKey: coding.episodes.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let serieSeasonIdDecode = coder.decodeObject(forKey: coding.serieSeason_id.rawValue) as? String
    let titleDecode = coder.decodeObject(forKey: coding.title.rawValue) as? String
    let numberDecode = coder.decodeObject(forKey: coding.number.rawValue) as? String
    let image_largeDecode = coder.decodeObject(forKey: coding.image_large.rawValue) as? String
    let image_mediumDecode = coder.decodeObject(forKey: coding.image_medium.rawValue) as? String
    let image_smallDecode = coder.decodeObject(forKey: coding.image_small.rawValue) as? String
    let image_backgroundDecode = coder.decodeObject(forKey: coding.image_background.rawValue) as? String
    let last_seasonDecode = coder.decodeObject(forKey: coding.last_season.rawValue) as? String
    let title_originalDecode = coder.decodeObject(forKey: coding.title_original.rawValue) as? String
    let first_episodeDecode = coder.decodeObject(forKey: coding.first_episode.rawValue) as? String
    let episodesDecode = coder.decodeObject(forKey: coding.episodes.rawValue) as? [Group]
    self.init()
    self.serieSeason_id = serieSeasonIdDecode ?? ""
    self.title = titleDecode ?? ""
    self.number = numberDecode ?? ""
    self.image_large = image_largeDecode ?? ""
    self.image_medium = image_mediumDecode ?? ""
    self.image_small = image_smallDecode ?? ""
    self.image_background = image_backgroundDecode ?? ""
    self.last_season = last_seasonDecode ?? ""
    self.title_original = title_originalDecode ?? ""
    self.first_episode = first_episodeDecode ?? ""
    self.episodes = episodesDecode ?? []
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    serieSeason_id = try container.decodeIfPresent(String.self, forKey: .serieSeason_id) ?? ""
    title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
    number = try container.decodeIfPresent(String.self, forKey: .number) ?? ""
    image_large = try container.decodeIfPresent(String.self, forKey: .image_large) ?? ""
    image_medium = try container.decodeIfPresent(String.self, forKey: .image_medium) ?? ""
    image_small = try container.decodeIfPresent(String.self, forKey: .image_small) ?? ""
    image_background = try container.decodeIfPresent(String.self, forKey: .image_background) ?? ""
    last_season = try container.decodeIfPresent(String.self, forKey: .last_season) ?? ""
    title_original = try container.decodeIfPresent(String.self, forKey: .title_original) ?? ""
    first_episode = try container.decodeIfPresent(String.self, forKey: .first_episode) ?? ""
    episodes = try container.decodeIfPresent([Group].self, forKey: .episodes) ?? []
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(serieSeason_id, forKey: .serieSeason_id)
    try codingKeys.encode(title, forKey: .title)
    try codingKeys.encode(number, forKey: .number)
    try codingKeys.encode(image_large, forKey: .image_large)
    try codingKeys.encode(image_medium, forKey: .image_medium)
    try codingKeys.encode(image_small, forKey: .image_small)
    try codingKeys.encode(image_background, forKey: .image_background)
    try codingKeys.encode(last_season, forKey: .last_season)
    try codingKeys.encode(title_original, forKey: .title_original)
    try codingKeys.encode(first_episode, forKey: .first_episode)
    try codingKeys.encode(episodes, forKey: .episodes)
  }
}
