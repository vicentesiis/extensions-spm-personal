//
//  StartHeaderInfo.swift
//  ClaroVideoModels
//
//  Created by alonso.salcido on 11/30/18.
//  Copyright © 2018 AMCO. All rights reserved.
//

import Foundation
public final class StartHeaderInfo: NSObject {
  
  public var region : String? = nil
  public var sessionStringValue: String? = nil
  public var sessionParameterName: String? = nil
  public var date: String? = nil
  public var time: String? = nil
  public var networkTv: Bool? = false
  
  public init(region: String? = nil, sessionStringValue: String? = nil,sessionParameterName: String? = nil,date:String? = nil, time: String? = nil, networkTv: Bool? = false) {
    self.region = region
    self.sessionStringValue = sessionStringValue
    self.sessionParameterName = sessionParameterName
    self.date = date
    self.time = time
    self.networkTv = networkTv
  }
}
