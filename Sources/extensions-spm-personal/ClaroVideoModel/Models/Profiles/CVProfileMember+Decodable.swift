//
//  CVProfileMember+Decodable.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 21/08/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

extension CVProfileMember: Parceable {
  public static func parseObject(dictionary: [String : Any]) -> Result<CVProfileMember, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
      let memberProfile = try JSONDecoder().decode(CVProfileMember.self, from: jsonData)
      return .success(memberProfile)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
  
}

extension CVProfileMember: Codable {
  
  enum CodingKeys: String, CodingKey {
    case gamificationId = "gamification_id"
    case username
    case userImage = "user_image"
    case rol
    case admin
    case changeName = "change_name"
    case partnerUserId
    case userHash = "user_hash"
    case lastTouch = "lasttouch"
    case isKid = "is_kids"
  }
  
  public init(from decoder: Decoder) throws {
    let codingKeys = try decoder.container(keyedBy: CodingKeys.self)
    gamificationId = try codingKeys.decode(String.self, forKey: .gamificationId)
    userName = try codingKeys.decode(String.self, forKey: .username)
    userImage = try codingKeys.decode(String.self, forKey: .userImage)
    rol = try codingKeys.decode(MemberRol.self, forKey: .rol)
    let adminValue = try? codingKeys.decode(Bool.self, forKey: .admin)
    admin = adminValue ?? false
    changeName = try codingKeys.decode(Bool.self, forKey: .changeName)
    partnerUserId = try codingKeys.decode(String.self, forKey: .partnerUserId)
    userHash = try codingKeys.decode(String.self, forKey: .userHash)
    lastTouch = try codingKeys.decodeIfPresent(LastTouch.self, forKey: .lastTouch)
    isKid = try codingKeys.decodeStringToBool(forKey: .isKid)
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(gamificationId, forKey: .gamificationId)
    try codingKeys.encode(userName, forKey: .username)
    try codingKeys.encode(userImage, forKey: .userImage)
    try codingKeys.encode(rol, forKey: .rol)
    try codingKeys.encode(admin, forKey: .admin)
    try codingKeys.encode(changeName, forKey: .changeName)
    try codingKeys.encode(partnerUserId, forKey: .partnerUserId)
    try codingKeys.encode(userHash, forKey: .userHash)
    try codingKeys.encodeIfPresent(lastTouch, forKey: .lastTouch)
    try codingKeys.encodeIfPresent(isKid, forKey: .isKid)
  }
  
  public static func decode(jsonDic: [String: Any]) -> CVProfileMember?{
    if let jsonData = try? JSONSerialization.data(withJSONObject: jsonDic, options: []){
      let memberProfile = try? JSONDecoder().decode(CVProfileMember.self, from: jsonData)
      return memberProfile
    }
    return nil
  }
  
}
