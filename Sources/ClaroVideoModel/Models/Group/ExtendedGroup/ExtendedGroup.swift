//
//  ExtendedGroup.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/22/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class ExtendedGroup: NSObject, NSCoding  {
  
  public var keywords: [String]
  public var genres: [Params]
  public var roles: [Params]
  public var format: Params
  public var media: ExtendedMedia
  
  
  public override init() {
    self.keywords = []
    self.genres = []
    self.roles = []
    self.format = Params()
    self.media = ExtendedMedia()
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(keywords, forKey: coding.keywords.rawValue)
    coder.encode(genres, forKey: coding.genres.rawValue)
    coder.encode(roles, forKey: coding.roles.rawValue)
    coder.encode(format, forKey: coding.format.rawValue)
    coder.encode(media, forKey: coding.media.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let keywordsDecode = coder.decodeObject(forKey: coding.keywords.rawValue) as? [String]
    let genresDecode = coder.decodeObject(forKey: coding.genres.rawValue) as? [Params]
    let rolesDecode = coder.decodeObject(forKey: coding.roles.rawValue) as? [Params]
    let formatDecode = coder.decodeObject(forKey: coding.format.rawValue) as? Params
    let mediaDecode = coder.decodeObject(forKey: coding.media.rawValue) as? ExtendedMedia
    self.init()
    self.keywords = keywordsDecode ?? []
    self.genres = genresDecode ?? []
    self.roles = rolesDecode ?? []
    self.format = formatDecode ?? Params()
    self.media = mediaDecode ?? ExtendedMedia()
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let genresContainer = try? container.nestedContainer(keyedBy: InsideListKeys.self, forKey: .genres) {
      if let genresDecode = try? genresContainer.decode([Params].self, forKey: .genre) {
        genres = genresDecode
      }
    }
    if let rolesContainer = try? container.nestedContainer(keyedBy: InsideListKeys.self, forKey: .roles) {
      if let rolesDecode = try? rolesContainer.decode([Params].self, forKey: .role) {
        roles = rolesDecode
      }
    }
    
    if let keywordsContainer = try? container.nestedContainer(keyedBy: InsideListKeys.self, forKey: .keywords),
      let keywordsDecode = try? keywordsContainer.decode([String].self, forKey: .keyword) {
      keywords = keywordsDecode
    }
    if let formatDecode = try? container.decode(Params.self, forKey: .format) {
      format = formatDecode
    }
    if let mediaDecode = try? container.decode(ExtendedMedia.self, forKey: .media) {
      media = mediaDecode
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(format, forKey: .format)
    try codingKeys.encode(media, forKey: .media)
    
    var genresKey = codingKeys.nestedContainer(keyedBy: InsideListKeys.self, forKey: .genres)
    try genresKey.encode(genres, forKey: .genre)
    var rolesKey = codingKeys.nestedContainer(keyedBy: InsideListKeys.self, forKey: .roles)
    try rolesKey.encode(roles, forKey: .role)
    var keywordsKey = codingKeys.nestedContainer(keyedBy: InsideListKeys.self, forKey: .keywords)
    try keywordsKey.encode(keywords, forKey: .keyword)
    
    
  }
}
