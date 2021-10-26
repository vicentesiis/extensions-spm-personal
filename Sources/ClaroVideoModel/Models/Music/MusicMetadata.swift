//
//  MusicMetadata.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 12/07/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

public struct MusicMetadata {
  public var id: Int?
  public var entity: String?
  public var trackName: String?
  public var duration: String?
  public var artist: [MusicBasic]?
  public var album: MusicBasic?
  
  public var durationInSeconds: Double {
    guard let durationString = self.duration else {return 0}
    
    var interval:Double = 0
    let parts = durationString.split(separator: ":")
    for (index, part) in parts.reversed().enumerated() {
      interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
    }
    
    return interval
  }
  
  public init() {
    id = 0
    entity = ""
    trackName = ""
    duration = ""
    artist = nil
    album = nil
  }
  
  public init(from decoder: Decoder) throws {
    self.init()
    let codingKeys = try decoder.container(keyedBy: CodingKeys.self)
    let metadata = try codingKeys.nestedContainer(keyedBy: CodingKeys.self, forKey: .metadata)
    id = try? metadata.decode(Int.self, forKey: .id)
    entity = try? metadata.decode(String.self, forKey: .entity)
    let comman = try? metadata.nestedContainer(keyedBy: CodingKeys.self, forKey: .common)
    trackName = try? comman?.decode(String.self, forKey: .name)
    duration = try? comman?.decode(String.self, forKey: .duration)
  }
}
