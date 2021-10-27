//
//  MusicTracking+Parceable.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 16/07/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

extension MusicTracking: Parceable {
  
  public static func parseObject(dictionary: [String : Any]) -> Result<MusicTracking, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
      var musicTracking = try JSONDecoder().decode(MusicTracking.self, from: jsonData)
      let body = dictionary["body"] as? [String:Any] ?? [:]
      let data = dictionary["data"] as? [String:Any] ?? [:]
      musicTracking.body = body
      musicTracking.data = data
      return .success(musicTracking)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
  
}

extension MusicTracking: Decodable {
  
  public enum CodingKeys: String, CodingKey {
    case url
    case body
    case data
    case interval_timer
  }
  
  public static func decodable(jsonDictionary: [AnyHashable: Any]) -> MusicTracking? {
    if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDictionary, options: []){
      var musicTracking = try? JSONDecoder().decode(MusicTracking.self, from: jsonData)
      let body = jsonDictionary["body"] as? [String:Any] ?? [:]
      let data = jsonDictionary["data"] as? [String:Any] ?? [:]
      musicTracking?.body = body
      musicTracking?.data = data
      return musicTracking
    }
    return nil
  }

  
  public static func deserializeResponse(jsonDictionary: [String: Any]) -> MusicTracking {
    let musicTrackingParse = MusicTracking.parseObject(dictionary: jsonDictionary)
    switch musicTrackingParse {
    case .success(let musicTracking):
      return musicTracking
    default:
      return MusicTracking()
    }
  }
}
