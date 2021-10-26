//
//  MusicMetadata+Parceable.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 12/07/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

extension MusicMetadata: Parceable {
  
  public static func parseObject(dictionary: [String : Any]) -> Result<MusicMetadata, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
      var musicMetadata = try JSONDecoder().decode(MusicMetadata.self, from: jsonData)
      if let metadata = dictionary["metadata"] as? [String: Any],
        let common = metadata["common"] as? [String: Any],
        let artistArrayDic = common["artists"] as? [[AnyHashable:Any]],
        let albumDic = common["album"] as? [AnyHashable: Any] {
        musicMetadata.artist = MusicBasic.deserializeResponse(jsonArrayDictionary: artistArrayDic)
        musicMetadata.album = MusicBasic.deserializeResponse(jsonDictionary: albumDic)
      }
      return .success(musicMetadata)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
  
}

extension MusicMetadata : Decodable {
  
  public enum CodingKeys: String, CodingKey {
    case metadata
    case id
    case entity
    case common
    case name
    case duration
  }
  
  /// Deserialize json dictionary for MusicMetadata
  ///
  /// - Parameter jsonDictionary: [AnyHashable: Any]
  /// - Returns: MusicMedia
  public static func deserializeResponse(jsonDictionary: [AnyHashable: Any]) -> MusicMetadata {
    let musicMetadata: MusicMetadata = MusicMetadata.decodable(jsonDictionary: jsonDictionary) ?? MusicMetadata()
    // Return value
    return musicMetadata
  }
  
  public static func decodable(jsonDictionary: [AnyHashable: Any]) -> MusicMetadata? {
    if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDictionary, options: []){
      var musicMetadata = try? JSONDecoder().decode(MusicMetadata.self, from: jsonData)
      if let metadata = jsonDictionary["metadata"] as? [String: Any],
        let common = metadata["common"] as? [String: Any],
        let artistArrayDic = common["artists"] as? [[AnyHashable:Any]],
        let albumDic = common["album"] as? [AnyHashable: Any] {
        musicMetadata?.artist = MusicBasic.deserializeResponse(jsonArrayDictionary: artistArrayDic)
        musicMetadata?.album = MusicBasic.deserializeResponse(jsonDictionary: albumDic)
      }
      return musicMetadata
    }
    return nil
  }
  
}
