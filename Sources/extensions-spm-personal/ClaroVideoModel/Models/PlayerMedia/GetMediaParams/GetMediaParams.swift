//
//  GetMediaParams.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 30/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

public final class GetMediaParams: NSObject {
  var groupId: String
  var contentId: String?
  var isTrailer: String
  var streamType: String
  var region: String?
  var startTime: String?
  var endTime: String?
  var paywayToken: String?
  var userToken: String?
  
  public init(groupId: String = "", contentId: String? = nil, isTrailer: String = "0", streamType: String = "", region: String? = nil, startTime: String? = nil, endTime: String? = nil, paywayToken: String? = nil, userToken: String? = nil) {
    self.groupId = groupId
    self.contentId = contentId
    self.isTrailer = isTrailer
    self.streamType = streamType
    self.region = region
    self.startTime = startTime
    self.endTime = endTime
    self.paywayToken = paywayToken
    self.userToken = userToken
  }
  
}
