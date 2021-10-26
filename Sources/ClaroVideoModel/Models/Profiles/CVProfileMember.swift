//
//  CVProfileMember.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 21/08/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

public enum MemberRol: String, Codable {
  case admin, secondary
}

public struct CVProfileMember {
  
  public var gamificationId: String
  public var userName: String
  public var userImage: String
  public let rol: MemberRol
  public let admin: Bool
  public let changeName: Bool
  public let partnerUserId: String
  public let userHash: String
  public let lastTouch: LastTouch?
  public var isKid: Bool

  public init(member:CVProfileMember, username: String, userAvatar: String) {
    self.gamificationId = member.gamificationId
    self.userName = username
    self.userImage = userAvatar
    self.rol = member.rol
    self.admin = member.admin
    self.changeName = member.changeName
    self.partnerUserId = member.partnerUserId
    self.userHash = member.userHash
    self.lastTouch = member.lastTouch
    self.isKid = member.isKid
  }
}
