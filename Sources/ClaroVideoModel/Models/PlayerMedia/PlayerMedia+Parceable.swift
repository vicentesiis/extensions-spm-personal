//
//  PlayerMedia+Parceable.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/10/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension PlayerMedia: Parceable {
  public static func parseObject(dictionary: [String : Any]) -> Result<PlayerMedia, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      // here "jsonData" is the dictionary encoded in JSON data
      let playerMedia = try JSONDecoder().decode(PlayerMedia.self, from: jsonData)
      return .success(playerMedia)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
}

extension PlayerMedia: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case media = "media"
    case userMedia = "user"
    case group = "group"
    case nextGroup = "next_group"
    case language = "language"
    case tracking = "tracking"
    case purchase = "purchase"
    case nextGroupId = "next_group_id"
    case responseJSON = "response_json"
    case requestURL = "request_url"
    case serverIp = "server_ip"
    case isTrailer = "isTrailer"
    case contentId = "contentId"
    case streamType = "streamType"
    case httpHeaders = "http_headers"
    case offerId = "offerId"
    case purchaseId = "purchaseId"
    case token = "token"
    case certificateURL = "certificateURL"
  }
  
  enum GroupCodingKeys: String, CodingKey { // declaring our keys
    case common = "common"
  }
  
  enum LanguageCodingKeys: String, CodingKey { // declaring our keys
    case options = "options"
  }
}
