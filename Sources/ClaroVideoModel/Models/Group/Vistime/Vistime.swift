//
//  Vistime.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/15/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class Vistime : NSObject, NSCoding {
  
  public var viewed: String
  public var duration: Record
  public var last: Record
  public var max: Record
  
  public override init() {
    self.viewed = ""
    self.duration = Record()
    self.last = Record()
    self.max = Record()
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(viewed, forKey: coding.viewed.rawValue)
    coder.encode(duration, forKey: coding.duration.rawValue)
    coder.encode(last, forKey: coding.last.rawValue)
    coder.encode(max, forKey: coding.max.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let viewedDecode = coder.decodeObject(forKey: coding.viewed.rawValue) as? String
    let durationDecode = coder.decodeObject(forKey: coding.duration.rawValue) as? Record
    let lastDecode = coder.decodeObject(forKey: coding.last.rawValue) as? Record
    let maxDecode = coder.decodeObject(forKey: coding.max.rawValue) as? Record
    self.init()
    self.viewed = viewedDecode ?? ""
    self.duration = durationDecode ?? Record()
    self.last = lastDecode ?? Record()
    self.max = maxDecode ?? Record()
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    viewed = try container.decodeIfPresent(String.self, forKey: .viewed) ?? ""
    duration = try container.decodeIfPresent(Record.self, forKey: .duration) ?? Record()
    last = try container.decodeIfPresent(Record.self, forKey: .last) ?? Record()
    max = try container.decodeIfPresent(Record.self, forKey: .max) ?? Record()
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(viewed, forKey: .viewed)
    try codingKeys.encode(duration, forKey: .duration)
    try codingKeys.encode(last, forKey: .last)
    try codingKeys.encode(max, forKey: .max)
  }
}
