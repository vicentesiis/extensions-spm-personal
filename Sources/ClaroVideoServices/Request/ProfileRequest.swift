//
//  ProfileRequest.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 23/08/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

enum ProfileRequest: RequestProtocol {
  
  case createProfile(name:String, imageUri:String, userToken: String, isKid: Bool)
  case updateProfile(name:String, imageUri:String, userToken: String, gamificationId: String, isKid: Bool)
  case deleteProfile(userToken: String,gamificationId: String)
  case getProfiles(userToken: String, gamificationId: String)
  case getAvatars
  
  var path: String {
    switch self {
    case .createProfile:
      return "profile/create"
    case .updateProfile:
      return "profile/update"
    case .deleteProfile:
      return "profile/delete"
    case .getProfiles:
      return "profile/read"
    case .getAvatars:
      return "profile/avatars"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getProfiles, .getAvatars:
      return .get
    case .createProfile, .updateProfile, .deleteProfile:
      return .post
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    default:
      return ["": ""]
    }
  }
  
  var cachePolicy: URLRequest.CachePolicy {
    switch self {
    default:
      return .reloadIgnoringLocalCacheData
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
    default:
      return 10.0
    }
  }
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .createProfile(let name, _, _, _):
      baseParams["firstname"] = name
      return baseParams
    case .updateProfile(_, _, _, let gamificationId, _):
      baseParams["gamification_id"] = gamificationId
      return baseParams
    case .deleteProfile(_, let gamificationId):
      baseParams["gamification_id"] = gamificationId
      return baseParams
    case .getProfiles(let userToken, let gamificationId):
      baseParams["user_token"] = userToken
      baseParams["gamification_id"] = gamificationId
      return baseParams
    case .getAvatars:
      return baseParams
    }
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .createProfile(_, let imageUri, let userToken, let isKid):
      baseParams["user_token"] = userToken
      baseParams["user_image"] = imageUri
      baseParams["is_kids"] = isKid
      return baseParams
    case .updateProfile(let name, let imageUri, let userToken, _, let isKid):
      baseParams["firstname"] = name
      baseParams["user_token"] = userToken
      baseParams["user_image"] = imageUri
      baseParams["is_kids"] = isKid
      return baseParams
    case .deleteProfile(let userToken, _):
      baseParams["user_token"] = userToken
      return baseParams
    case .getProfiles, .getAvatars:
      return baseParams
    }
  }
  
}
