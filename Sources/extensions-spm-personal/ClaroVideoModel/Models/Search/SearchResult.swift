//
//  SearchResult.swift
//  ClaroVideoServices
//
//  Created by Luis Salcido on 14/01/20.
//  Copyright © 2020 amco. All rights reserved.
//


import Foundation

public final class SearchResult: NSObject {

  // MARK: Properties
  public var suggest: [Group]?
  public var prediction: SearchPredictionResult?
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let groupJson = try? container.decode([OptionalObject<Group>].self, forKey: .suggest) {
      suggest = groupJson.compactMap(\.value).filter{ !$0.group_id.isEmpty }
    }
    self.prediction = try? container.decode(SearchPredictionResult.self, forKey: .prediction)
  }
}
