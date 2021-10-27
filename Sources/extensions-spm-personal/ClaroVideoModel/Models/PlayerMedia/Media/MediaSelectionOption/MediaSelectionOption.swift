//
//  MediaSelectionOption.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/10/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

@objc(MediaSelectionOption)
public final class MediaSelectionOption: NSObject, NSCoding {
  
  public var identifier: String
  public var internalOption: String
  public var externalOption: String
  
  // MARK: - Instance Methods
  public override init() {
    self.identifier = ""
    self.internalOption = ""
    self.externalOption = ""
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(identifier, forKey: coding.identifier.rawValue)
    coder.encode(internalOption, forKey: coding.internalOption.rawValue)
    coder.encode(externalOption, forKey: coding.externalOption.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let identifierDecode = coder.decodeObject(forKey: coding.identifier.rawValue) as? String
    let internalOptionDecode = coder.decodeObject(forKey: coding.internalOption.rawValue) as? String
    let externalOptionDecode = coder.decodeObject(forKey: coding.externalOption.rawValue) as? String
    self.init()
    self.identifier = identifierDecode ?? ""
    self.internalOption = internalOptionDecode ?? ""
    self.externalOption = externalOptionDecode ?? ""
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    identifier = try container.decodeIfPresent(String.self, forKey: .identifier) ?? ""
    internalOption = try container.decodeIfPresent(String.self, forKey: .internalOption) ?? ""
    externalOption = try container.decodeIfPresent(String.self, forKey: .externalOption) ?? ""
  }
  
  static func getAudios(responseObject: [String: Any]) -> [MediaSelectionOption] {
    let audiosArray = swapAudioOptionListArray(responseObject: responseObject)
    let audios = audiosArray.map { (value) -> MediaSelectionOption in
      let audio = ParserHelper.parseObject(of: MediaSelectionOption.self, data: value)
      switch audio {
      case .success(let mediaOption):
        return mediaOption
      case .failure(_):
        return MediaSelectionOption()
      }
    }
    return audios
  }
  
  static func getSubtitles(responseObject: [String: Any]) -> [MediaSelectionOption] {
    let subtitlesArray = swapSubtitleOptionListArray(responseObject: responseObject)
    let subtitles = subtitlesArray.map { (value) -> MediaSelectionOption in
      let subtitle = ParserHelper.parseObject(of: MediaSelectionOption.self, data: value)
      switch subtitle {
      case .success(let mediaOption):
        return mediaOption
      case .failure(_):
        return MediaSelectionOption()
      }
    }
    return subtitles
  }
  
  private static func swapAudioOptionListArray(responseObject: [String: Any]) -> [[String:String]] {
    var newArray = [[String:String]]()
    for (code, currentValue) in responseObject {
      // Valid if currentValue is a String
      if let newValue = currentValue as? String {
        let newDictionary = ["identifier":code,
                             "internalOption":newValue]
        newArray.append(newDictionary)
      }
    }
    return newArray
  }
  
  private static func swapSubtitleOptionListArray(responseObject: [String: Any]) -> [[String:String]] {
    var newArray = [[String:String]]()
    for (code, currentValue) in responseObject {
      // Valid if the currentValue is a String with the typification [String:String]
      if let currentDictionary = currentValue as? [String : String] {
        var newDictionary = ["identifier" : code]
        if let internalOption = currentDictionary["internal"] {
          newDictionary["internalOption"] = internalOption
        }
        if let externalOption = currentDictionary["external"] {
          newDictionary["externalOption"] = externalOption
        }
        newArray.append(newDictionary)
      }
    }
    return newArray
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(identifier, forKey: .identifier)
    try codingKeys.encode(internalOption, forKey: .internalOption)
    try codingKeys.encode(externalOption, forKey: .externalOption)
  }
}
