//
//  MusicItem+Parceable.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 24/07/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

extension MusicItem: Parceable {
  
  public static func parseObject(dictionary: [String : Any]) -> Result<MusicItem, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
      var musicItemModel = try JSONDecoder().decode(MusicItem.self, from: jsonData)
      if let type = dictionary["type"] as? String {
        musicItemModel.type = MusicItemType.transformToString(text: type)
      }
      musicItemModel.properties = MusicProperty.deserealizeResponse(jsonDictionary: dictionary)
      return .success(musicItemModel)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
  
}

extension MusicItem: Decodable {
  
  public enum CodingKeys: String, CodingKey {
    case type
    case entity
    case entity_id
    case img
    case action
    case service_url
    case phonogramId
  }
  
  /// Deserialize json dictionary for level music
  ///
  /// - Parameter jsonDictionary: [AnyHashable: Any]
  /// - Returns: [MusicItem]
  public static func deserializeResponse(jsonDictionary: [[AnyHashable: Any]]) -> [MusicItem] {
    var arrayMusicItem: [MusicItem] = []
    
    // Deserialize
    for dictionary in jsonDictionary {
      if var musicItem = MusicItem.decodable(jsonDictionary: dictionary) {
        if let type = dictionary["type"] as? String {
          musicItem.type = MusicItemType.transformToString(text: type)
        }
        musicItem.properties = MusicProperty.deserealizeResponse(jsonDictionary: dictionary)
        arrayMusicItem.append(musicItem)
      }
    }
    
    // Return value
    return arrayMusicItem
  }
  
  public static func decodable(jsonDictionary: [AnyHashable: Any]) -> MusicItem? {
    if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDictionary, options: []),
      let musicItemModel = try? JSONDecoder().decode(MusicItem.self, from: jsonData) {
      return musicItemModel
    }
    return nil
  }
  
}
