//
//  MusicMedia+Parceable.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 24/07/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

extension MusicMedia: Parceable {
  public static func parseObject(dictionary: [String : Any]) -> Result<MusicMedia, NetworkError> {
    var musicMedia: MusicMedia = MusicMedia()
    // Decodable
    //Media
    if let jsonMedia = dictionary["media"] as? [String:Any],
      let jsonData = try? JSONSerialization.data(withJSONObject: jsonMedia, options: []),
      let musicMediaDec = try? JSONDecoder().decode(MusicMedia.self, from: jsonData) {
      musicMedia = musicMediaDec
      //challenge
      if let challenge = jsonMedia["challenge"] as? [AnyHashable:Any] {
        musicMedia.challenge = challenge
      }
    }
    //Metadata
    let metadata = MusicMetadata.parseObject(dictionary: dictionary)
    switch metadata {
    case .success(let metadataSuccess):
      musicMedia.metadata = metadataSuccess
    default:
      break
    }
    //Tracking
    if let tracking = dictionary["tracking"] as? [AnyHashable: Any] {
      if let trackingSuccess = tracking["success"] as? [String: Any] {
        musicMedia.trackingSuccess = MusicTracking.deserializeResponse(jsonDictionary: trackingSuccess)
      }
      if let trackingError = tracking["error"] as? [String: Any] {
        musicMedia.trackingError = MusicTracking.deserializeResponse(jsonDictionary: trackingError)
      }
      if let trackingTrick = tracking["tick"] as? [String: Any] {
        musicMedia.trackingTick = MusicTracking.deserializeResponse(jsonDictionary: trackingTrick)
      }
    }
    return .success(musicMedia)
  }
  
  
}

extension MusicMedia: Decodable {
  
  public enum CodingKeys: String, CodingKey {
    case track_url
    case licenser_url
    case certificate_url
  }
  
  /// Deserialize json dictionary for MusicMedia
  ///
  /// - Parameter jsonDictionary: [AnyHashable: Any]
  /// - Returns: MusicMedia
  public static func deserializeResponse(jsonDictionary: [AnyHashable: Any]) -> MusicMedia {
    var musicMedia: MusicMedia = MusicMedia()
    
    // Decodable
    //Media
    if let jsonMedia = jsonDictionary["media"] as? [AnyHashable:Any],
      let musicMediaDecod = MusicMedia.decodable(jsonDictionary: jsonMedia) {
      musicMedia = musicMediaDecod
      //challenge
      if let challenge = jsonMedia["challenge"] as? [AnyHashable:Any] {
        musicMedia.challenge = challenge
      }
    }
    //Metadata
    musicMedia.metadata = MusicMetadata.deserializeResponse(jsonDictionary: jsonDictionary)
    //Tracking
    if let tracking = jsonDictionary["tracking"] as? [AnyHashable: Any] {
      if let trackingSuccess = tracking["success"] as? [String: Any] {
        musicMedia.trackingSuccess = MusicTracking.deserializeResponse(jsonDictionary: trackingSuccess)
      }
      if let trackingError = tracking["error"] as? [String: Any] {
        musicMedia.trackingError = MusicTracking.deserializeResponse(jsonDictionary: trackingError)
      }
      if let trackingTrick = tracking["tick"] as? [String: Any] {
        musicMedia.trackingTick = MusicTracking.deserializeResponse(jsonDictionary: trackingTrick)
      }
    }
    
    // Return value
    return musicMedia
  }
  
  public  static func decodable(jsonDictionary: [AnyHashable: Any]) -> MusicMedia? {
    if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDictionary, options: []){
      let musicMedia = try? JSONDecoder().decode(MusicMedia.self, from: jsonData)
      return musicMedia
    }
    return nil
  }
  
}
