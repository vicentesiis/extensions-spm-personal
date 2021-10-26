//
//  MusicBasic+Parceable.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 15/07/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

extension MusicBasic: Parceable {
  
  public static func parseObject(dictionary: [String : Any]) -> Result<MusicBasic, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
      let musicBasicModel = try JSONDecoder().decode(MusicBasic.self, from: jsonData)
      return .success(musicBasicModel)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
  
}
