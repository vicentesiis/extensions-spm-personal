//
//  TokenExpireDate.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/7/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class TokenExpireDate: NSObject {
  public var date: String?
  public var timezoneType: Int
  public var timezone: String?
  
  // MARK: - Instance Methods
  public override init() {
    self.date = nil
    self.timezoneType = 0
    self.timezone = nil
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    date = try container.decodeIfPresent(String.self, forKey: .date)
    timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
    if let timezoneTypeInt = try? container.decode(Int.self, forKey: .timezoneType) {
        timezoneType = timezoneTypeInt
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(date, forKey: .date)
    try codingKeys.encode(timezoneType, forKey: .timezoneType)
    try codingKeys.encode(timezone, forKey: .timezone)
  }
}
