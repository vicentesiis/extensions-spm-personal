//
//  CVDuration.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/10/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

@objc(Durationa)
public final class CVDuration: NSObject, NSCoding {
  
  public var string: String
  public var seconds: Int
  
  // MARK: - Instance Methods
  public override init() {
    self.string = ""
    self.seconds = -1
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(string, forKey: coding.string.rawValue)
    coder.encode(seconds, forKey: coding.seconds.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let stringDecode = coder.decodeObject(forKey: coding.string.rawValue) as? String
    var secondsDecode = -1
    if let secondDec = coder.decodeObject(forKey: coding.seconds.rawValue) as? Int {
      secondsDecode = secondDec
    }
    self.init()
    self.string = stringDecode ?? ""
    self.seconds = secondsDecode
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    string = try container.decodeIfPresent(String.self, forKey: .string) ?? ""
    seconds = try container.decodeIfPresent(Int.self, forKey: .seconds) ?? -1
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(string, forKey: .string)
    try codingKeys.encode(seconds, forKey: .seconds)
  }
}
