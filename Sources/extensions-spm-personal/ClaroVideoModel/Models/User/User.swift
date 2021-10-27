//
//  IsLogegdIn.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/7/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class User: NSObject {
  
  public var isUserLoggedIn: Int = 0
  public var userId: String? = nil
  public var username: String? = nil
  public var parentId: String? = nil
  public var admin: Bool = false
  public var email: String? = nil
  public var firstName: String? = nil
  public var lastName: String? = nil
  public var countryCode: String? = nil
  public var region: String? = nil
  public var subRegion: String? = nil
  public var city: String? = nil
  public var sessionServerName: String? = nil
  public var sessionStringValue: String? = nil
  public var sessionParameterName: String? = nil
  public var sessionUserHash: String? = nil
  public var socialData: SocialData? = nil
  public var hasSavedPayway: Int = 0
  public var hasUserSusc: Int = 0
  public var superhighlight: [String]? = nil
  public var lastTouch: LastTouch? = nil
  public var gamificationId: String? = nil
  public var acceptedTerms: Int = 0
  public var paymentMethods: [[String: Any]]? = nil
  public var subscriptions: [[String: Any]]? = nil
  public var userDetectWS: String? = nil
  public var counterValidEmail: Int = 0
  public var validEmail: Bool = false
  public var socialNetworks: [SocialNetworks]? = nil
  public var userToken: String? = nil
  public var userSession: String? = nil
  public var pswWarning: Bool = false
  public var paywayProfile: PaywayProfile? = nil
  public var language : String? = nil
  public var status : String? = nil
  public var subscriptionsInfo: [SubscriptionInfo]? = nil
  public var paymentMethodForTenantCode: [String: Any]? = nil
  public var cmAccessToken: String? = nil
  public var hasMusicSuscription: Bool = false
  public var isAdmin: Bool = false
  public var logoutUrl: String? = nil
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let isLoggedIn = try? container.decode(Int.self, forKey: .isUserLoggedIn) {
        isUserLoggedIn = isLoggedIn
    }
    userId = try container.decodeIfPresent(String.self, forKey: .userId)
    username = try container.decodeIfPresent(String.self, forKey: .username)
    parentId = try container.decodeIfPresent(String.self, forKey: .parentId)
    if let adminBool = try? container.decode(Bool.self, forKey: .admin) {
        admin = adminBool
    }
    email = try container.decodeIfPresent(String.self, forKey: .email)
    firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
    lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
    countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode)
    region = try container.decodeIfPresent(String.self, forKey: .region)
    subRegion = try? container.decodeIfPresent(String.self, forKey: .subRegion)
    city = try? container.decodeIfPresent(String.self, forKey: .city)
    sessionServerName = try container.decodeIfPresent(String.self, forKey: .sessionServerName)
    sessionStringValue = try container.decodeIfPresent(String.self, forKey: .sessionStringValue)
    sessionParameterName = try container.decodeIfPresent(String.self, forKey: .sessionParameterName)
    sessionUserHash = try container.decodeIfPresent(String.self, forKey: .sessionUserHash)
    socialData = try? container.decodeIfPresent(SocialData.self, forKey: .socialData)
    if let savedPayway = try? container.decode(Int.self, forKey: .hasSavedPayway) {
        hasSavedPayway = savedPayway
    }
    if let userSusc = try? container.decode(Int.self, forKey: .hasUserSusc) {
        hasUserSusc = userSusc
    }
    superhighlight = try container.decodeIfPresent([String].self, forKey: .superhighlight)
    lastTouch = try container.decodeIfPresent(LastTouch.self, forKey: .lastTouch)
    gamificationId = try container.decodeIfPresent(String.self, forKey: .gamificationId)
    if let terms = try? container.decode(Int.self, forKey: .acceptedTerms) {
        acceptedTerms = terms
    }
    if let paymentMethod = try? container.decode([String: Any].self, forKey: .paymentMethods) {
      paymentMethods = [paymentMethod]
    } else if let paymentMethodStr = try? container.decode(String.self, forKey: .paymentMethods) {
      let parseDicBool: [String: Any] = ParserHelper.parse(data: paymentMethodStr) ?? [:]
      paymentMethods = [parseDicBool]
    } else {
      paymentMethods = try? container.decodeIfPresent([Any].self, forKey: .paymentMethods) as? [[String: Any]] ?? []
    }
    if let subscription = try? container.decode([String: Any].self, forKey: .subscriptions) {
      subscriptions = [subscription]
    } else if let subscriptionsStr = try? container.decode(String.self, forKey: .subscriptions) {
      let parseDicBool: [String: Any] = ParserHelper.parse(data: subscriptionsStr) ?? [:]
      subscriptions = [parseDicBool]
    } else {
      subscriptions = try? container.decodeIfPresent([Any].self, forKey: .subscriptions) as? [[String: Any]] ?? []
    }
    userDetectWS = try? container.decodeIfPresent(String.self, forKey: .userDetectWS)
    if let counterEmail = try? container.decode(Int.self, forKey: .counterValidEmail) {
        counterValidEmail = counterEmail
    }
    if let isValidEmail = try? container.decode(Bool.self, forKey: .validEmail) {
        validEmail = isValidEmail
    }
    socialNetworks = try container.decodeIfPresent([SocialNetworks].self, forKey: .socialNetworks)
    userToken = try container.decodeIfPresent(String.self, forKey: .userToken)
    userSession = try container.decodeIfPresent(String.self, forKey: .userSession)
    if let isPswWarning = try? container.decode(Bool.self, forKey: .pswWarning) {
        pswWarning = isPswWarning
    }
    paywayProfile = try container.decodeIfPresent(PaywayProfile.self, forKey: .paywayProfile)
    
    status = try container.decodeIfPresent(String.self, forKey: .status)
    language = try container.decodeIfPresent(String.self, forKey: .language)
    
    if let subsInfo = try? container.decode([SubscriptionInfo].self, forKey: .subscriptionsInfo) {
      subscriptionsInfo = subsInfo
    }
    if let paymentMethodTenantCodeStr = try? container.decode(String.self, forKey: .paymentMethodForTenantCode) {
      paymentMethodForTenantCode = ParserHelper.parse(data: paymentMethodTenantCodeStr)
    }
    if let cmAccessTokenStr = try? container.decode(String.self, forKey: .cmAccessToken) {
      cmAccessToken = cmAccessTokenStr
    }
    if let hasMusicSubs = try? container.decode(Bool.self, forKey: .hasMusicSuscription) {
      hasMusicSuscription = hasMusicSubs
    }
    if let isAdminBool = try? container.decode(Bool.self, forKey: .isAdmin) {
      isAdmin = isAdminBool
    }
    if let logoutStr = try? container.decode(String.self, forKey: .logoutUrl) {
      logoutUrl = logoutStr
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(isUserLoggedIn, forKey: .isUserLoggedIn)
    try codingKeys.encode(userId, forKey: .userId)
    try codingKeys.encode(username, forKey: .username)
    try codingKeys.encode(parentId, forKey: .parentId)
    try codingKeys.encode(admin, forKey: .admin)
    try codingKeys.encode(email, forKey: .email)
    try codingKeys.encode(firstName, forKey: .firstName)
    try codingKeys.encode(lastName, forKey: .lastName)
    try codingKeys.encode(countryCode, forKey: .countryCode)
    try codingKeys.encode(region, forKey: .region)
    try codingKeys.encode(subRegion, forKey: .subRegion)
    try codingKeys.encode(city, forKey: .city)
    try codingKeys.encode(sessionServerName, forKey: .sessionServerName)
    try codingKeys.encode(sessionStringValue, forKey: .sessionStringValue)
    try codingKeys.encode(sessionParameterName, forKey: .sessionParameterName)
    try codingKeys.encode(sessionUserHash, forKey: .sessionUserHash)
    try codingKeys.encode(socialData, forKey: .socialData)
    try codingKeys.encode(hasSavedPayway, forKey: .hasSavedPayway)
    try codingKeys.encode(hasUserSusc, forKey: .hasUserSusc)
    try codingKeys.encode(superhighlight, forKey: .superhighlight)
    try codingKeys.encode(lastTouch, forKey: .lastTouch)
    try codingKeys.encode(gamificationId, forKey: .gamificationId)
    try codingKeys.encode(acceptedTerms, forKey: .acceptedTerms)
    if let paymentMethodsFirst = paymentMethods?.first {
      let paymentMethodsStr = ParserHelper.encodeObject(data: paymentMethodsFirst)
      try codingKeys.encode(paymentMethodsStr, forKey: .paymentMethods)
    }
    if let subscriptionFirst = subscriptions?.first {
      let subscriptionStr = ParserHelper.encodeObject(data: subscriptionFirst)
      try codingKeys.encode(subscriptionStr, forKey: .subscriptions)
    }
    try codingKeys.encode(userDetectWS, forKey: .userDetectWS)
    try codingKeys.encode(counterValidEmail, forKey: .counterValidEmail)
    try codingKeys.encode(validEmail, forKey: .validEmail)
    try codingKeys.encode(socialNetworks, forKey: .socialNetworks)
    try codingKeys.encode(userToken, forKey: .userToken)
    try codingKeys.encode(userSession, forKey: .userSession)
    try codingKeys.encode(pswWarning, forKey: .pswWarning)
    try codingKeys.encode(paywayProfile, forKey: .paywayProfile)
    try codingKeys.encode(language, forKey: .language)
    try codingKeys.encode(status, forKey: .status)
    try codingKeys.encode(subscriptionsInfo, forKey: .subscriptionsInfo)
    let paymentMethodForTenantCodeStr = ParserHelper.encodeObject(data: paymentMethodForTenantCode)
    try codingKeys.encode(paymentMethodForTenantCodeStr, forKey: .paymentMethodForTenantCode)
    try codingKeys.encode(cmAccessToken, forKey: .cmAccessToken)
    try codingKeys.encode(hasMusicSuscription, forKey: .hasMusicSuscription)
    try codingKeys.encode(isAdmin, forKey: .isAdmin)
    try codingKeys.encode(logoutUrl, forKey: .logoutUrl)
  }
}
