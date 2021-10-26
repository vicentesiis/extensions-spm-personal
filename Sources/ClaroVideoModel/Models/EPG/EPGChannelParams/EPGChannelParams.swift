//
//  EPGChannelParams.swift
//  ClaroVideoServices
//
//  Created by Luis Salcido on 11/02/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

public final class EPGChannelParams: NSObject {
  public var dateFrom: String
  public var dateTo: String
  public var filterInactive: Int
  public var channelList: String?
  public var nodeId: String?
  
  public init(dateFrom: String, dateTo: String, filterInactive: Int = 1, channelList: String? = nil, nodeId: String? = nil) {
    self.dateFrom = dateFrom
    self.dateTo = dateTo
    self.filterInactive = filterInactive
    self.channelList = channelList?.lowercased()
    self.nodeId = nodeId
  }
  
}
