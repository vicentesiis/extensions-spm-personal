//
//  SeriesRecording.swift
//  ClaroVideoServices
//
//  Created by Adrián Salazar G on 25/08/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public struct SeriesRecording {
  public var serieName: String
  public var userSerieId: String
  public var serieId: Int
  public var seasonId: Int
  public var language: Int
  public var groupId: Int
  public var image: String
  public var packId: Int
  public var records: [Int]
  public var actions: [String:Any]
  
  init() {
    serieName = ""
    userSerieId = ""
    serieId = 0
    seasonId = 0
    language = 0
    groupId = 0
    image = ""
    packId = 0
    records = []
    actions = [:]
  }
  
  public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    serieName     = try container.decodeIfPresent(String.self, forKey: .serieName) ?? ""
    userSerieId   = try container.decodeIfPresent(String.self, forKey: .userSerieId) ?? ""
    serieId       = try container.decodeIfPresent(Int.self, forKey: .serieId) ?? 0
    seasonId      = try container.decodeIfPresent(Int.self, forKey: .seasonId) ?? 0
    language      = try container.decodeIfPresent(Int.self, forKey: .language) ?? 0
    groupId       = try container.decodeIfPresent(Int.self, forKey: .groupId) ?? 0
    image         = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
    packId        = try container.decodeIfPresent(Int.self, forKey: .packId) ?? 0
    records       = try container.decodeIfPresent([Int].self, forKey: .records) ?? []
    if let actions = try? container.decodeIfPresent([String:Any].self, forKey: .actions) {
      self.actions = actions
    }
  }
}
