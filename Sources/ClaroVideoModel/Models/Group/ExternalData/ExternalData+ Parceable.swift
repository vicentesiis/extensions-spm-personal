//
//  ExternalData+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/29/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension ExternalData: Parceable {
  public static func parseObject(dictionary: [String : Any]) -> Result<ExternalData, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      // here "jsonData" is the dictionary encoded in JSON data
      let externalData = try JSONDecoder().decode(ExternalData.self, from: jsonData)
      return .success(externalData)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
}

extension ExternalData: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case id = "id"
    case providerId = "provider_id"
    case providerCode = "provider_code"
    case title = "title"
    case externalDescription = "description"
    case duration = "duration"
    case publishyear = "publishyear"
    case officialUrl = "official_url"
    case rating = "rating"
    case genres = "genres"
    case cast = "cast"
  }
}

