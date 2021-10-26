//
//  StartHeaderInfo+Parser.swift
//  ClaroVideoModels
//
//  Created by alonso.salcido on 12/5/18.
//  Copyright © 2018 AMCO. All rights reserved.
//

import Foundation

extension StartHeaderInfo: Parceable {
  
  public static func parseObject(dictionary: [String : Any]) -> Result<StartHeaderInfo, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      let startHeaderInfo = try JSONDecoder().decode(StartHeaderInfo.self, from: jsonData)
      return .success(startHeaderInfo)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
}

extension StartHeaderInfo: Decodable {
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case region = "region"
    case sessionStringValue = "session_stringvalue"
    case sessionParameterName = "session_parametername"
    case date = "date"
    case time = "time"
    case networkTv = "network_tv"
  }
  
  public convenience init(from decoder: Decoder) throws {
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let region = try container.decode(String.self, forKey: .region)
    let sessionStringValue = try container.decode(String.self, forKey: .sessionStringValue)
    let sessionParameterName = try container.decode(String.self, forKey: .sessionParameterName)
    let date = try container.decode(String.self, forKey: .date)
    let time = try container.decode(String.self, forKey: .time)
    let networkTv = try container.decodeIfPresent(Bool.self, forKey: .networkTv)
    
    self.init(region: region, sessionStringValue: sessionStringValue, sessionParameterName: sessionParameterName, date: date, time:time, networkTv: networkTv)
  }
}

