//
//  MusicItem.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 12/07/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

public struct MusicItem {
  
  public var type:MusicItemType
  public var entity: String?
  public var id: Int
  public var phonogramId: Int?
  public var image: String?
  public var action: String?
  public var serviceURL: String?
  public var properties: [String:Any]?
  
  // MARK: - Instance Methods
  public init() {
    type = .undefined
    properties = nil
    entity = nil
    id = 0
    phonogramId = 0
    image = nil
    action = nil
    serviceURL = nil
  }
  
  public init(from decoder: Decoder) throws {
    self.init()
    let codingKeys = try decoder.container(keyedBy: CodingKeys.self)
    if let typeString = try? codingKeys.decode(String.self, forKey: .type) {
      type = MusicItemType.transformToString(text: typeString)
    }
    entity = try? codingKeys.decode(String.self, forKey: .entity)
    if let entityId = try? codingKeys.decode(Int.self, forKey: .entity_id) {
      id = entityId
    }
    phonogramId = try? codingKeys.decodeIfPresent(Int.self, forKey: .phonogramId)
    image = try? codingKeys.decode(String.self, forKey: .img)
    action = try? codingKeys.decode(String.self, forKey: .action)
    serviceURL = try? codingKeys.decode(String.self, forKey: .service_url)
  }
  
}
