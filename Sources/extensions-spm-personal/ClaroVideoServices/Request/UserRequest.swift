//
//  UserRequest.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/9/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

enum UserRequest: RequestProtocol {
  //Login
  case isLoggedIn
  case pushSession(userId: String, userSession: String)
  case register(firstName:String, lastName:String, accepterms: Bool, email: String, password: String)
  case loginsso(number: String, otp: String?)
  case login(user:String, password:String)
  case loginHash(hash: String, userId: String)
  case loginSocial(userSocialId: String, socialnetwork: String)
  case logout(userId: String)
  case getUserInfo(email: String)
  //Modify
  case modify(firstName:String, lastName:String, email:String, userHash:String)
  //Password
  case sendTemporalCode(email: String)
  //List
  case seenRecommendations(path: String)
  case seen(path: String)
  case deleteSeen(groupId: String)
  case seenGamification(gamificationId: String)
  case purchased(path: String)
  case userRecomendations
  case deleteLinealChannels(groupId: String)
  case liveChannels(path: String)
  //Bookmarks
  case seenlast(groupId: String)
  case bookmark(groupId: String)
  //Acept Terms
  case acceptTerms(password:String, username:String)
  case acceptTermsIp(userHash: String, userId: String)
  
  var path: String {
    switch self {
    case .isLoggedIn:
      return "isloggedin"
    case .pushSession:
      return "push_session"
    case .login, .loginHash:
      return "login"
    case .loginSocial:
      return "sociallogin"
    case .logout:
      return "logout"
    case .register:
      return "register"
    case .loginsso:
      return "loginsso"
    case .getUserInfo:
      return "getuserinfo"
    case .modify:
      return "modify"
    case .sendTemporalCode:
      return "sendtemporalcode"
    case .bookmark:
      return "getbookmark"
    case .userRecomendations:
      return "recommendations"
    case .seenlast:
      return "seenlast"
    case .seenGamification:
      return "seen"
    case .deleteSeen:
      return "seendel"
    case .deleteLinealChannels:
      return "removelivechannel"
    case .liveChannels(let path),
         .seenRecommendations(let path),
         .seen(let path),
         .purchased(let path):
      return path
    case .acceptTerms,
         .acceptTermsIp:
      return "settermsandconditions"
    }
  }
  
  var method: HTTPMethod { 
    switch self {
    case  .isLoggedIn, .loginHash, .loginSocial,
          .seenRecommendations, .seen , .purchased, .logout, .bookmark,.userRecomendations,
          .seenlast, .seenGamification, .acceptTerms, .acceptTermsIp, .deleteSeen, .deleteLinealChannels:
      return .get
    case .pushSession, .register, .loginsso, .modify, .login, .getUserInfo, .sendTemporalCode, .liveChannels:
      return .post
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .isLoggedIn, .pushSession, .login, .loginHash, .loginSocial, .register, .loginsso, .modify,
         .seenRecommendations, .seen, .userRecomendations,  .bookmark, .purchased , .logout, .seenGamification,
         .seenlast, .acceptTerms, .acceptTermsIp, .deleteSeen, .getUserInfo, .sendTemporalCode, .liveChannels, .deleteLinealChannels:
      return ["": ""]
    }
  }
  
  var cachePolicy: NSURLRequest.CachePolicy  {
    switch self {
    case  .isLoggedIn, .pushSession, .login, .loginHash, .loginSocial, .register, .loginsso, .modify,
          .seenRecommendations , .seen, .userRecomendations, .seenGamification, .purchased, .logout, .liveChannels,
          .bookmark, .seenlast, .acceptTerms, .acceptTermsIp, .deleteSeen, .getUserInfo, .sendTemporalCode, .deleteLinealChannels:
      return .reloadIgnoringLocalCacheData
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
    case .isLoggedIn, .pushSession, .login, .loginHash, .loginSocial, .seen, .purchased , .logout,
         .userRecomendations, .seenlast, .acceptTerms, .acceptTermsIp, .deleteSeen, .getUserInfo, .sendTemporalCode, .deleteLinealChannels:
      return 10.0
    case .register, .loginsso, .modify, .seenRecommendations, .bookmark, .seenGamification, .liveChannels:
      return 30.0
    }
  }
  
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .register, .loginsso, .modify, .isLoggedIn, .seenRecommendations, .seen,
         .purchased,.userRecomendations,.login,.sendTemporalCode, .liveChannels:
      break
    case .pushSession(let userId, _):
      baseParams["user_id"] = userId
    case .loginHash(let hash, let userId):
      baseParams["userhash"] = hash
      baseParams["user_id"] = userId
    case .loginSocial(let userSocialId, let socialnetwork):
      baseParams["usersocial_id"] = userSocialId
      baseParams["socialnetwork"] = socialnetwork
    case .logout(let userId):
      baseParams["user_id"] = userId
    case .bookmark(let groupId):
      baseParams["group_id"] = groupId
    case .deleteSeen(let groupId):
      baseParams["object_id"] = groupId
      baseParams["object_type"] = 1
    case .deleteLinealChannels(let groupId):
      baseParams["object_id"] = groupId
    case .seenlast(let groupId):
      baseParams["group_id"] = groupId
    case .seenGamification(let gamificationId):
      baseParams["gamification_id"] = gamificationId
    case .acceptTerms(let password, let username):
      baseParams["username"] = username
      baseParams["password"] = password
    case .acceptTermsIp(let userHash, let userId):
      baseParams["user_id"] = userId
      baseParams["user_hash"] = userHash
    case .getUserInfo(let email):
      baseParams["email"] = email
    }
    return baseParams
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .isLoggedIn, .loginHash, .loginSocial, .seenRecommendations, .seen, .purchased ,
         .logout, .bookmark, .userRecomendations, .seenlast, .seenGamification, .acceptTerms,
         .acceptTermsIp, .deleteSeen, .getUserInfo, .liveChannels, .deleteLinealChannels:
      return baseParams
    case .pushSession( _, let userSession):
      baseParams["user_session"] = userSession
      return baseParams
    case .loginsso(let number, let otpNumber):
      baseParams["numberfield"] = number
      if let otp = otpNumber {
        baseParams["otp"] = otp
      }
      return baseParams
    case .register(let firstName, let lastName, let accepterms, let email, let password):
      baseParams["firstname"] = firstName
      baseParams["lastname"] = lastName
      baseParams["accepterms"] = accepterms
      baseParams["email"] = email
      baseParams["password"] = password
      return baseParams
    case .modify(let firstName, let lastName, let email, let userHash):
      baseParams["firstname"] = firstName
      baseParams["lastname"] = lastName
      baseParams["email"] = email
      baseParams["user_hash"] = userHash
      return baseParams
    case .login(let user, let password):
      baseParams["username"] = user
      baseParams["password"] = password
      return baseParams
    case .sendTemporalCode(let email):
      baseParams["email"] = email
      return baseParams
    }
  }
}
