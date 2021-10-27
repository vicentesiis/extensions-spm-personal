//
//  OptionLanguage.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/25/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

@objc(OptionLanguage)
final public class OptionLanguage: NSObject, NSCoding {
  
  public var groupId: String
  public var contentId: String
  public var optionId: String
  public var languageId: String
  public var isCurrent: Bool
  public var labelShort: String
  public var labelLarge: String
  public var encodes: [String]
  public var audio: String
  public var subtitle: String
  public var introStart: String
  public var introFinish: String
  
  public override init() {
    self.groupId = ""
    self.contentId = ""
    self.optionId = ""
    self.languageId = ""
    self.isCurrent = false
    self.labelShort = ""
    self.labelLarge = ""
    self.encodes = []
    self.audio = ""
    self.subtitle = ""
    self.introStart = ""
    self.introFinish = ""
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    coder.encode(groupId, forKey: coding.groupId.rawValue)
    coder.encode(contentId, forKey: coding.contentId.rawValue)
    coder.encode(optionId, forKey: coding.optionId.rawValue)
    coder.encode(languageId, forKey: coding.languageId.rawValue)
    coder.encode(isCurrent, forKey: coding.isCurrent.rawValue)
    coder.encode(labelShort, forKey: coding.labelShort.rawValue)
    coder.encode(labelLarge, forKey: coding.labelLarge.rawValue)
    coder.encode(encodes, forKey: coding.encodes.rawValue)
    coder.encode(audio, forKey: coding.audio.rawValue)
    coder.encode(subtitle, forKey: coding.subtitle.rawValue)
    coder.encode(introStart, forKey: coding.introStart.rawValue)
    coder.encode(introFinish, forKey: coding.introFinish.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let groupIdDecode = coder.decodeObject(forKey: coding.groupId.rawValue) as? String
    let contentIdDecode = coder.decodeObject(forKey: coding.contentId.rawValue) as? String
    let optionIdDecode = coder.decodeObject(forKey: coding.optionId.rawValue) as? String
    let languageIdDecode = coder.decodeObject(forKey: coding.languageId.rawValue) as? String
    let isCurrentDecode = coder.decodeObject(forKey: coding.isCurrent.rawValue) as? Bool
    let labelShortDecode = coder.decodeObject(forKey: coding.labelShort.rawValue) as? String
    let labelLargeDecode = coder.decodeObject(forKey: coding.labelLarge.rawValue) as? String
    let encodesDecode = coder.decodeObject(forKey: coding.encodes.rawValue) as? [String]
    let audioDecode = coder.decodeObject(forKey: coding.audio.rawValue) as? String
    let subtitleDecode = coder.decodeObject(forKey: coding.subtitle.rawValue) as? String
    let introStartDecode = coder.decodeObject(forKey: coding.introStart.rawValue) as? String
    let introFinishDecode = coder.decodeObject(forKey: coding.introFinish.rawValue) as? String
    self.init()
    self.groupId = groupIdDecode ?? ""
    self.contentId = contentIdDecode ?? ""
    self.optionId = optionIdDecode ?? ""
    self.languageId = languageIdDecode ?? ""
    self.isCurrent = isCurrentDecode ?? false
    self.labelShort = labelShortDecode ?? ""
    self.labelLarge = labelLargeDecode ?? ""
    self.encodes = encodesDecode ?? []
    self.audio = audioDecode ?? ""
    self.subtitle = subtitleDecode ?? ""
    self.introStart = introStartDecode ?? ""
    self.introFinish = introFinishDecode ?? ""
    
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    groupId = try container.decodeIfPresent(String.self, forKey: .groupId) ?? ""
    contentId = try container.decodeIfPresent(String.self, forKey: .contentId) ?? ""
    optionId = try container.decodeIfPresent(String.self, forKey: .optionId) ?? ""
    languageId = try container.decodeIfPresent(String.self, forKey: .languageId) ?? ""
    isCurrent = try container.decodeIfPresent(Bool.self, forKey: .isCurrent) ?? false
    labelShort = try container.decodeIfPresent(String.self, forKey: .labelShort) ?? ""
    labelLarge = try container.decodeIfPresent(String.self, forKey: .labelLarge) ?? ""
    encodes = try container.decodeIfPresent([String].self, forKey: .encodes) ?? []
    audio = try container.decodeIfPresent(String.self, forKey: .audio) ?? ""
    if let subtitleDecode = try? container.decode(String.self, forKey: .subtitle) {
      subtitle = subtitleDecode
    }
    if let introStartDecode = try? container.decode(String.self, forKey: .introStart) {
      introStart = introStartDecode
    }
    if let introFinishDecode = try? container.decode(String.self, forKey: .introFinish) {
      introFinish = introFinishDecode
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(groupId, forKey: .groupId)
    try codingKeys.encode(contentId, forKey: .contentId)
    try codingKeys.encode(optionId, forKey: .optionId)
    try codingKeys.encode(languageId, forKey: .languageId)
    try codingKeys.encode(isCurrent, forKey: .isCurrent)
    try codingKeys.encode(labelShort, forKey: .labelShort)
    try codingKeys.encode(labelLarge, forKey: .labelLarge)
    try codingKeys.encode(encodes, forKey: .encodes)
    try codingKeys.encode(audio, forKey: .audio)
    try codingKeys.encode(subtitle, forKey: .subtitle)
    try codingKeys.encode(introStart, forKey: .introStart)
    try codingKeys.encode(introFinish, forKey: .introFinish)
  }
}
