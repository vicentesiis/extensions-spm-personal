//
//  MusicBasic.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 15/07/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

public struct MusicBasic {
  
  public var id: String?
  public var entity: String?
  public var name: String?
  public var imageUrl: String?
  
  public init() {
    id = ""
    entity = ""
    name = ""
    imageUrl = ""
  }
  
  public init(from decoder: Decoder) throws {
    self.init()
    let codingKeys = try decoder.container(keyedBy: CodingKeys.self)
    id = try? codingKeys.decode(String.self, forKey: .id)
    entity = try? codingKeys.decode(String.self, forKey: .id)
    let common = try codingKeys.nestedContainer(keyedBy: CodingKeys.self, forKey: .common)
    name = try? common.decode(String.self, forKey: .name)
    if let pictureUrl = try? common.decode(String.self, forKey: .picture) {
      imageUrl = pictureUrl
    } else if let imgCover = try? common.decode(String.self, forKey: .cover) {
      imageUrl = imgCover
    }
  }
  
  /// Deserialize json dictionary for level music
  ///
  /// - Parameter jsonDictionary: [[AnyHashable: Any]]
  /// - Returns: [MusicBasic]
  public static func deserializeResponse(jsonArrayDictionary: [[AnyHashable: Any]]) -> [MusicBasic] {
    var arrayMusicBasic: [MusicBasic] = []
    
    // Deserialize
    for dictionary in jsonArrayDictionary {
      let musicBasic = deserializeResponse(jsonDictionary: dictionary)
      arrayMusicBasic.append(musicBasic)
    }
    
    return arrayMusicBasic
  }
  
  /// Deserialize json dictionary for level music
  ///
  /// - Parameter jsonDictionary: [AnyHashable: Any]
  /// - Returns: [MusicBasic]
  public static func deserializeResponse(jsonDictionary: [AnyHashable: Any]) -> MusicBasic {
    let musicAlbum = MusicBasic.decodable(json: jsonDictionary) ?? MusicBasic()
    return musicAlbum
  }
  
  public static func decodable(json: [AnyHashable: Any]) -> MusicBasic? {
    if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
      let musicBasicModel = try? JSONDecoder().decode(MusicBasic.self, from: jsonData)
      return musicBasicModel
    }
    return nil
  }
  
}

extension MusicBasic : Decodable {
  
  public enum CodingKeys: String, CodingKey {
    case id
    case entity
    case common
    case name
    case picture
    case cover
  }
  
}
