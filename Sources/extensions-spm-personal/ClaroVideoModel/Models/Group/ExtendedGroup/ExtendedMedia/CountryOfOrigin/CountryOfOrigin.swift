//
//  CountryOfOrigin.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/25/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class CountryOfOrigin: NSObject, NSCoding {
  
  public var code: String
  public var desc: String
  
  public override init() {
    self.code = ""
    self.desc = ""
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(code, forKey: coding.code.rawValue)
    coder.encode(desc, forKey: coding.desc.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let codeDecode = coder.decodeObject(forKey: coding.code.rawValue) as? String
    let descDecode = coder.decodeObject(forKey: coding.desc.rawValue) as? String
    self.init()
    self.code = codeDecode ?? ""
    self.desc = descDecode ?? ""
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    code = try container.decodeIfPresent(String.self, forKey: .code) ?? ""
    desc = try container.decodeIfPresent(String.self, forKey: .desc) ?? ""
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(code, forKey: .code)
    try codingKeys.encode(desc, forKey: .desc)
  }
  
}
