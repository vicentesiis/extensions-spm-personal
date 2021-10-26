//
//  CVProfileAvatar+Decodable.swift
//  Clarovideo
//
//  Created by Adrian Salazar on 5/28/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

extension CVProfileAvatar: Parceable {
  public static func parseObject(dictionary: [String : Any]) -> Result<CVProfileAvatar, NetworkError> {
    do {
      let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
      let avatar = try JSONDecoder().decode(CVProfileAvatar.self, from: data)
      return .success(avatar)
    } catch let error {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
}

extension CVProfileAvatar: Decodable {
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case userImage = "user_image"
    case apaAssetVersion = "apa_asset_version"
    case isDefault = "default"
  }
  
  public init(from decoder: Decoder) throws {
    let codingKeys = try decoder.container(keyedBy: CodingKeys.self)
    id = try codingKeys.decode(Int.self, forKey: .id)
    name = try codingKeys.decode(String.self, forKey: .name)
    userImage = try codingKeys.decode(URL.self, forKey: .userImage)
    apaAssetVersion = try? codingKeys.decode(String.self, forKey: .apaAssetVersion)
    isDefault = try codingKeys.decode(Bool.self, forKey: .isDefault)
  }
  
  static public func decodeAvatar(jsonDic:[String: Any]) -> [CVProfileAvatar] {
    var arrayAvatarModel: [CVProfileAvatar] = []
    if let avatars = jsonDic["avatars"] as? [[String: Any]],
       let data = try? JSONSerialization.data(withJSONObject: avatars, options: []),
       let arrayAvatar = try? JSONDecoder().decode([CVProfileAvatar].self, from: data) {
      arrayAvatarModel = arrayAvatar
    }
    return arrayAvatarModel
  }
  
}
