//
//  Params.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/22/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class Params: NSObject, NSCoding {
  
  public var desc: String
  public var est: String
  public var paramsId: String
  public var name: String
  public var sellType: String
  public var types: String
  public var talents: [Talent]?
  
  
  public override init() {
    self.desc = ""
    self.est = ""
    self.paramsId = ""
    self.name = ""
    self.sellType = ""
    self.types = ""
    self.talents = []
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(desc, forKey: coding.desc.rawValue)
    coder.encode(est, forKey: coding.est.rawValue)
    coder.encode(paramsId, forKey: coding.paramsId.rawValue)
    coder.encode(name, forKey: coding.name.rawValue)
    coder.encode(sellType, forKey: coding.sellType.rawValue)
    coder.encode(types, forKey: coding.types.rawValue)
    coder.encode(talents, forKey: coding.talents.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let descDecode = coder.decodeObject(forKey: coding.desc.rawValue) as? String
    let estDecode = coder.decodeObject(forKey: coding.est.rawValue) as? String
    let paramsIdDecode = coder.decodeObject(forKey: coding.paramsId.rawValue) as? String
    let nameDecode = coder.decodeObject(forKey: coding.name.rawValue) as? String
    let sellTypeDecode = coder.decodeObject(forKey: coding.sellType.rawValue) as? String
    let typesDecode = coder.decodeObject(forKey: coding.types.rawValue) as? String
    let talentsDecode = coder.decodeObject(forKey: coding.talents.rawValue) as? [Talent]
    self.init()
    self.desc = descDecode ?? ""
    self.est = estDecode ?? ""
    self.paramsId = paramsIdDecode ?? ""
    self.name = nameDecode ?? ""
    self.sellType = sellTypeDecode ?? ""
    self.types = typesDecode ?? ""
    self.talents = talentsDecode
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let descDecode = try? container.decode(String.self, forKey: .desc) {
      desc = descDecode
    } else if let descDecode = try? container.decode(String.self, forKey: .roleName) {
      desc = descDecode
    }
    if let paramsIdDecode = try? container.decode(String.self, forKey: .paramsId) {
      paramsId = paramsIdDecode
    } else if let paramsIdDecode = try? container.decode(String.self, forKey: .roleId) {
      paramsId = paramsIdDecode
    }
    if let nameDecode = try? container.decode(String.self, forKey: .name) {
      name = nameDecode
    } else if let nameDecode = try? container.decode(String.self, forKey: .roleName) {
      name = nameDecode
    }
    if let estDecode = try? container.decode(String.self, forKey: .est) {
      est = estDecode
    }
    if let sellTypeDecode = try? container.decode(String.self, forKey: .sellType) {
      sellType = sellTypeDecode
    }
    if let typesDecode = try? container.decode(String.self, forKey: .types) {
      types = typesDecode
    } else if let typeDecode = try? container.decode(String.self, forKey: .type) {
      types = typeDecode
    }
    if let talentsContainer = try? container.nestedContainer(keyedBy: TalentstKeys.self, forKey: .talents),
      let talentsDecode = try? talentsContainer.decode([Talent].self, forKey: .talent) {
        talents = talentsDecode
    } else if let talentsDecode = try? container.decode([Talent].self, forKey: .talents) {
        // External Talents
        for talent in talentsDecode {
          talent.providerCode = "3"
        }
        talents = talentsDecode
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(desc, forKey: .desc)
    try codingKeys.encode(est, forKey: .est)
    try codingKeys.encode(paramsId, forKey: .paramsId)
    try codingKeys.encode(name, forKey: .name)
    try codingKeys.encode(sellType, forKey: .sellType)
    try codingKeys.encode(types, forKey: .types)
    var insideListKey = codingKeys.nestedContainer(keyedBy: TalentstKeys.self, forKey: .talents)
    try insideListKey.encode(talents, forKey: .talent)
  }
}
