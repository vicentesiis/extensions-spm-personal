//
//  CVProfileGroup+Decodable.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 21/08/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

extension CVProfileGroup: Parceable {
  
  public static func parseObject(dictionary: [String : Any]) -> Result<CVProfileGroup, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      let profileGroup = try JSONDecoder().decode(CVProfileGroup.self, from: jsonData)
      return .success(profileGroup)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
  
}

extension CVProfileGroup: Codable {
  enum CodingKeys: String, CodingKey {
    case userId = "user_id"
    case parentId = "parent_id"
    case firstname
    case gamificationId = "gamification_id"
    case userToken = "user_token"
    case data
    case id
    case title
    case description
    case totalMembers
    case creationDate
    case maxMembers
    case type
    case members
    case lastTouch = "lasttouch"
  }
  
  public init(from decoder: Decoder) throws {
    let codingKeys = try decoder.container(keyedBy: CodingKeys.self)
    userId = try? codingKeys.decode(Int.self, forKey: .userId)
    parentId = try? codingKeys.decode(Int.self, forKey: .parentId)
    name = try? codingKeys.decode(String.self, forKey: .firstname)
    gamificationId = try? codingKeys.decode(String.self, forKey: .gamificationId)
    userToken = try? codingKeys.decode(String.self, forKey: .userToken)
    let dataCodingKey = try codingKeys.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    id = try dataCodingKey.decode(String.self, forKey: .id)
    title = try dataCodingKey.decode(String.self, forKey: .title)
    groupDescription = try dataCodingKey.decode(String.self, forKey: .description)
    totalMembers = try dataCodingKey.decode(Int.self, forKey: .totalMembers)
    creationDate = try dataCodingKey.decode(String.self, forKey: .creationDate)
    maxMembers = try dataCodingKey.decode(Int.self, forKey: .maxMembers)
    type = try dataCodingKey.decode(String.self, forKey: .type)
    if let arrayMemebers = try? dataCodingKey.decode([CVProfileMember].self, forKey: .members) {
      members = arrayMemebers
    } else {
      members = []
    }
    lastTouch = try codingKeys.decodeIfPresent(LastTouch.self, forKey: .lastTouch)
    
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(userId, forKey: .userId)
    try codingKeys.encode(parentId, forKey: .parentId)
    try codingKeys.encode(name, forKey: .firstname)
    try codingKeys.encode(gamificationId, forKey: .gamificationId)
    try codingKeys.encode(userToken, forKey: .userToken)
    var dataCodingKey = codingKeys.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
    try dataCodingKey.encode(id, forKey: .id)
    try dataCodingKey.encode(title, forKey: .title)
    try dataCodingKey.encode(groupDescription, forKey: .description)
    try dataCodingKey.encode(totalMembers, forKey: .totalMembers)
    try dataCodingKey.encode(creationDate, forKey: .creationDate)
    try dataCodingKey.encode(maxMembers, forKey: .maxMembers)
    try dataCodingKey.encode(type, forKey: .type)
    try dataCodingKey.encode(members, forKey: .members)
  }
  
  static public func decode(jsonDic: [AnyHashable: Any]) -> CVProfileGroup?{
    if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDic, options: []){
      return self.decode(data: jsonData)
    }
    return nil
  }
  
  static public func decode(data: Data) -> CVProfileGroup?{
    if let groupProfile = try? JSONDecoder().decode(CVProfileGroup.self, from: data) {
      return groupProfile
    }
    return nil
  }
}
