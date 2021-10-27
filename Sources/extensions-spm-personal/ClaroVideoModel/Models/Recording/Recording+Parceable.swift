//
//  Recording+Parceable.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 12/11/18.
//  Copyright © 2018 AMCO. All rights reserved.
//

import Foundation

extension Recording: Parceable {
  public static func parseObject(dictionary: [String : Any]) -> Result<Recording, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
      // here "jsonData" is the dictionary encoded in JSON data

      var recording = try JSONDecoder().decode(Recording.self, from: jsonData)
      let actions = dictionary["actions"] as? [String:Any] ?? [:]
      recording.actions = actions
      return .success(recording)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
}

extension Recording: Decodable {

  enum CodingKeys: String, CodingKey {
    case record_id
    case provider_id
    case pack_id
    case status

    case channel
    case id
    case name
    case group_id
    case image

    case event
    case date_begin
    case extSeasonId = "ext_season_id"
    case date_end
    case extSerieId = "ext_series_id"
    case extEpisodeId = "ext_episode_id"
    case extEventImageName = "ext_eventimage_name"
    case duration
  }

  public static func decodable(jsonDictionary: [AnyHashable: Any]) -> Recording? {
    if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDictionary, options: []){
      var recording = try? JSONDecoder().decode(Recording.self, from: jsonData)
      let actions = jsonDictionary["actions"] as? [String:Any] ?? [:]
      recording?.actions = actions
      return recording
    }
    return nil
  }

}
