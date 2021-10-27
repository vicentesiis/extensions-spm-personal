//
//  IsLoggedIn+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/7/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension User: Parceable {
  public static func parseObject(dictionary: [String : Any]) -> Result<User, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      // here "jsonData" is the dictionary encoded in JSON data
      let user = try JSONDecoder().decode(User.self, from: jsonData)
      return .success(user)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
}

extension User: Codable {
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case isUserLoggedIn = "is_user_logged_in"
    case userId = "user_id"
    case username = "username"
    case parentId = "parent_id"
    case admin = "admin"
    case email = "email"
    case firstName = "firstname"
    case lastName = "lastname"
    case countryCode = "country_code"
    case region = "region"
    case subRegion = "subregion"
    case city = "city"
    case sessionServerName = "session_servername"
    case sessionStringValue = "session_stringvalue"
    case sessionParameterName = "session_parametername"
    case sessionUserHash = "session_userhash"
    case socialData = "socialdata"
    case hasSavedPayway = "hasSavedPayway"
    case hasUserSusc = "hasUserSusc"
    case superhighlight = "superhighlight"
    case lastTouch = "lasttouch"
    case gamificationId = "gamification_id"
    case acceptedTerms = "accepted_terms"
    case paymentMethods = "paymentMethods"
    case subscriptions = "subscriptions"
    case userDetectWS = "userDetectWS"
    case counterValidEmail = "counterValidEmail"
    case validEmail = "validEmail"
    case socialNetworks = "socialNetworks"
    case userToken = "user_token"
    case userSession = "user_session"
    case pswWarning = "psw_warning"
    case paywayProfile = "paywayProfile"
    case language = "language"
    case status = "status"
    case subscriptionsInfo
    case paymentMethodForTenantCode
    case cmAccessToken
    case hasMusicSuscription
    case isAdmin
    case logoutUrl
  }
  
}
