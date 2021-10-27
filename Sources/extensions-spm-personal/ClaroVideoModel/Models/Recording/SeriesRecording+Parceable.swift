//
//  SeriesRecording+Parceable.swift
//  ClaroVideoServices
//
//  Created by Adrián Salazar G on 25/08/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

extension SeriesRecording: Decodable {
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case serieName    = "serie_name"
    case userSerieId  = "user_serie_id"
    case serieId      = "serie_id"
    case seasonId     = "season_id"
    case language     = "language"
    case groupId      = "group_id"
    case image        = "image"
    case packId       = "pack_id"
    case records      = "records"
    case actions      = "actions"
  }
  
  public static func decodable(jsonDictionary: [[AnyHashable: Any]]) -> [SeriesRecording] {
    if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDictionary, options: []),
       let serierecording = try? JSONDecoder().decode([SeriesRecording].self, from: jsonData){
      return serierecording
    }
    return []
  }
    
}
