//
//  SocialData.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/7/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class SocialData: NSObject {
  public var id: String?
  public var birthday: String?
  public var email: String?
  public var firstName: String?
  public var gender: String?
  public var lastName: String?
  public var urlLink: String?
  public var locale: String?
  public var name: String?
  public var timezone: Int
  public var updatedTime: String?
  public var verified: Bool
  public var imagenProfile: String?
  public var token: String?
  public var tokenExpireDate: TokenExpireDate?
  
  // MARK: - Instance Methods
  public override init() {
    self.id = nil
    self.birthday = nil
    self.email = nil
    self.firstName = nil
    self.gender = nil
    self.lastName = nil
    self.urlLink = nil
    self.locale = nil
    self.name = nil
    self.timezone = 0
    self.updatedTime = nil
    self.verified = false
    self.imagenProfile = nil
    self.token = nil
    self.tokenExpireDate = nil
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(String.self, forKey: .id)
    birthday = try container.decodeIfPresent(String.self, forKey: .birthday)
    email = try container.decodeIfPresent(String.self, forKey: .email)
    firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
    gender = try container.decodeIfPresent(String.self, forKey: .gender)
    lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
    urlLink = try container.decodeIfPresent(String.self, forKey: .urlLink)
    locale = try container.decodeIfPresent(String.self, forKey: .locale)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    if let timezoneInt = try? container.decode(Int.self, forKey: .timezone) {
           timezone = timezoneInt
    }
    updatedTime = try container.decodeIfPresent(String.self, forKey: .updatedTime)
    if let verifiedBool = try? container.decode(Bool.self, forKey: .verified) {
           verified = verifiedBool
    }
    imagenProfile = try container.decodeIfPresent(String.self, forKey: .imagenProfile)
    token = try container.decodeIfPresent(String.self, forKey: .token)
    tokenExpireDate = try container.decodeIfPresent(TokenExpireDate.self, forKey: .tokenExpireDate)
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(id, forKey: .id)
    try codingKeys.encode(birthday, forKey: .birthday)
    try codingKeys.encode(email, forKey: .email)
    try codingKeys.encode(firstName, forKey: .firstName)
    try codingKeys.encode(gender, forKey: .gender)
    try codingKeys.encode(lastName, forKey: .lastName)
    try codingKeys.encode(urlLink, forKey: .urlLink)
    try codingKeys.encode(locale, forKey: .locale)
    try codingKeys.encode(name, forKey: .name)
    try codingKeys.encode(timezone, forKey: .timezone)
    try codingKeys.encode(updatedTime, forKey: .updatedTime)
    try codingKeys.encode(verified, forKey: .verified)
    try codingKeys.encode(imagenProfile, forKey: .imagenProfile)
    try codingKeys.encode(token, forKey: .token)
    try codingKeys.encode(tokenExpireDate, forKey: .tokenExpireDate)
  }
}
