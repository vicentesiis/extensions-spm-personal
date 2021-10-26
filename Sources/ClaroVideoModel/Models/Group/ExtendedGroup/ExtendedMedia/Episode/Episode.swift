//
//  Episode.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/25/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class Episode: NSObject, NSCoding {
  
  public var season: String
  public var number: String
  
  public override init() {
    self.season = ""
    self.number = ""
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(season, forKey: coding.season.rawValue)
    coder.encode(number, forKey: coding.number.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let seasonDecode = coder.decodeObject(forKey: coding.season.rawValue) as? String
    let numberDecode = coder.decodeObject(forKey: coding.number.rawValue) as? String
    self.init()
    self.season = seasonDecode ?? ""
    self.number = numberDecode ?? ""
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    season = try container.decodeIfPresent(String.self, forKey: .season) ?? ""
    number = try container.decodeIfPresent(String.self, forKey: .number) ?? ""
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(season, forKey: .season)
    try codingKeys.encode(number, forKey: .number)
  }
}
