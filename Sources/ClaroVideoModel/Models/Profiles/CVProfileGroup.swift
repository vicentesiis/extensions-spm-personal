//
//  CVProfileGroup.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 21/08/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

public struct CVProfileGroup {
  public var userId: Int?
  public var parentId: Int?
  public var name: String?
  public var gamificationId: String?
  public var userToken: String?
  public var id: String
  public var title: String
  public var groupDescription: String
  public var totalMembers: Int
  public var creationDate: String
  public var maxMembers: Int
  public var type: String
  public var members: [CVProfileMember]
  public var lastTouch: LastTouch? = nil
  
  public init(userId: Int?, parentId: Int?, name: String?, gamificationId: String?, userToken: String?, id: String, title: String, groupDescription: String, totalMembers: Int, creationDate: String, maxMembers: Int, type: String, members: [CVProfileMember], lasttouch: LastTouch?) {
    self.userId = nil
    self.parentId = nil
    self.name = nil
    self.gamificationId = nil
    self.userToken = nil
    self.id = ""
    self.title = ""
    self.groupDescription = ""
    self.totalMembers = 0
    self.creationDate = ""
    self.maxMembers = 0
    self.type = ""
    self.members = members
    self.lastTouch = lasttouch
  }
}
