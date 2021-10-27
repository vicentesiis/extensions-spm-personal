//
//  Talent.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/22/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class Talent : NSObject, NSCoding {
  
  public var fullname: String
  public var talentId: String
  public var name: String
  public var surname: String
  public var imageUrl: String
  public var providerCode: String
  public var type: String
  public var gender: String
  public var birthPlace: String
  public var birthDate: String
  public var deathDate: String
  public var internalIds: [Int]?
  public var awards: [Award]?
  
  public override init() {
    self.fullname = ""
    self.talentId = ""
    self.name = ""
    self.surname = ""
    self.imageUrl = ""
    self.providerCode = ""
    self.type = ""
    self.gender = ""
    self.birthPlace = ""
    self.birthDate = ""
    self.deathDate = ""
    self.internalIds = nil
    self.awards = nil
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(fullname, forKey: coding.fullName.rawValue)
    coder.encode(talentId, forKey: coding.talentId.rawValue)
    coder.encode(name, forKey: coding.name.rawValue)
    coder.encode(surname, forKey: coding.surname.rawValue)
    coder.encode(imageUrl, forKey: coding.imageUrl.rawValue)
    coder.encode(providerCode, forKey: coding.providerCode.rawValue)
    coder.encode(type, forKey: coding.type.rawValue)
    coder.encode(gender, forKey: coding.gender.rawValue)
    coder.encode(birthPlace, forKey: coding.birthPlace.rawValue)
    coder.encode(birthDate, forKey: coding.birthDate.rawValue)
    coder.encode(deathDate, forKey: coding.deathDate.rawValue)
    coder.encode(internalIds, forKey: coding.internalIds.rawValue)
    coder.encode(awards, forKey: coding.awards.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let fullNameDecode = coder.decodeObject(forKey: coding.fullName.rawValue) as? String
    let talentIdDecode = coder.decodeObject(forKey: coding.talentId.rawValue) as? String
    let nameDecode = coder.decodeObject(forKey: coding.name.rawValue) as? String
    let surnameDecode = coder.decodeObject(forKey: coding.surname.rawValue) as? String
    let imageUrlDecode = coder.decodeObject(forKey: coding.imageUrl.rawValue) as? String
    let providerCodeDecode = coder.decodeObject(forKey: coding.providerCode.rawValue) as? String
    let type = coder.decodeObject(forKey: coding.type.rawValue) as? String
    let gender = coder.decodeObject(forKey: coding.gender.rawValue) as? String
    let birthPlace = coder.decodeObject(forKey: coding.birthPlace.rawValue) as? String
    let birthDate = coder.decodeObject(forKey: coding.birthDate.rawValue) as? String
    let deathDate = coder.decodeObject(forKey: coding.deathDate.rawValue) as? String
    let internalIds = coder.decodeObject(forKey: coding.internalIds.rawValue) as? [Int]
    let awards = coder.decodeObject(forKey: coding.awards.rawValue) as? [Award]

    self.init()
    self.fullname = fullNameDecode ?? ""
    self.talentId = talentIdDecode ?? ""
    self.name = nameDecode ?? ""
    self.surname = surnameDecode ?? ""
    self.imageUrl = imageUrlDecode ?? ""
    self.providerCode = providerCodeDecode ?? ""
    self.type = type ?? ""
    self.gender = gender ?? ""
    self.birthPlace = birthPlace ?? ""
    self.birthDate = birthDate ?? ""
    self.deathDate = deathDate ?? ""
    self.internalIds = internalIds
    self.awards = awards
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let id = try? container.decode(String.self, forKey: .talentId) {
      talentId = id
    } else if let idInt = try? container.decode(Int.self, forKey: .talentId) {
      talentId = "\(idInt)"
    }
    if let fullName = try? container.decode(String.self, forKey: .fullName) {
      fullname = fullName
    }
    if let firstName = try? container.decode(String.self, forKey: .firstName) {
      name = firstName
    } else if let nameCode = try? container.decode(String.self, forKey: .name) {
      name = nameCode
    }
    if let lastName = try? container.decode(String.self, forKey: .lastName) {
      surname = lastName
    } else if let surName = try? container.decode(String.self, forKey: .surname) {
      surname = surName
    }
    if let image = try? container.decode(String.self, forKey: .imageUrl) {
      imageUrl = image
    }
    if let providerCodeCoding = try? container.decode(String.self, forKey: .providerCode) {
      providerCode = providerCodeCoding
    }
    if let _type = try? container.decode(String.self, forKey: .type) {
      type = _type
    }
    if let _gender = try? container.decode(String.self, forKey: .gender) {
      gender = _gender
    }
    if let _birthPlace = try? container.decode(String.self, forKey: .birthPlace) {
      birthPlace = _birthPlace
    }
    if let _birthDate = try? container.decode(String.self, forKey: .birthDate) {
      birthDate = _birthDate
    }
    if let _deathDate = try? container.decode(String.self, forKey: .deathDate) {
      deathDate = _deathDate
    }
    if let _internalIds = try? container.decode([Int].self, forKey: .internalIds) {
      internalIds = _internalIds
    }
    if let _awards = try? container.decode([Award].self, forKey: .awards) {
      awards = _awards
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(fullname, forKey: .fullName)
    try codingKeys.encode(talentId, forKey: .talentId)
    try codingKeys.encode(name, forKey: .name)
    try codingKeys.encode(surname, forKey: .surname)
    try codingKeys.encode(imageUrl, forKey: .imageUrl)
    try codingKeys.encode(providerCode, forKey: .providerCode)
    try codingKeys.encode(type, forKey: .type)
    try codingKeys.encode(gender, forKey: .gender)
    try codingKeys.encode(birthPlace, forKey: .birthPlace)
    try codingKeys.encode(birthDate, forKey: .birthDate)
    try codingKeys.encode(deathDate, forKey: .deathDate)
    try codingKeys.encode(internalIds, forKey: .internalIds)
    try codingKeys.encode(awards, forKey: .awards)
  }
}

public struct Award: Decodable, Encodable {
  public let award: String?
  public let category: String?
  public let year: String?
}
