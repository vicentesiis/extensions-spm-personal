//
//  LanguageFormat.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/25/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class LanguageFormat: NSObject, NSCoding {
  
  public var language_id: String
  public var desc: String
  
  public override init() {
    self.language_id = ""
    self.desc = ""
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(language_id, forKey: coding.language_id.rawValue)
    coder.encode(desc, forKey: coding.desc.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let languageIdDecode = coder.decodeObject(forKey: coding.language_id.rawValue) as? String
    let descDecode = coder.decodeObject(forKey: coding.desc.rawValue) as? String
    self.init()
    self.language_id = languageIdDecode ?? ""
    self.desc = descDecode ?? ""
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    language_id = try container.decodeIfPresent(String.self, forKey: .language_id) ?? ""
    desc = try container.decodeIfPresent(String.self, forKey: .desc) ?? ""
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(language_id, forKey: .language_id)
    try codingKeys.encode(desc, forKey: .desc)
  }
}
