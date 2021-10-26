//
//  MetadataTranslations.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 13/01/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public final class MetadataTranslations: NSObject {
  public var translations: [String: Any]? = nil
  public var rawValue: [String: Any]? = nil
}

extension MetadataTranslations: Parceable {
  public static func parseObject(dictionary: [String : Any]) -> Result<MetadataTranslations, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      // here "jsonData" is the dictionary encoded in JSON data
      let metadata = try JSONDecoder().decode(MetadataTranslations.self, from: jsonData)
      if metadata.rawValue == nil {
        metadata.rawValue = dictionary
      }
      return .success(metadata)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
  
}

extension MetadataTranslations: Codable {
  enum translationKeys: String, CodingKey {
    case translations = "translations"
    case rawValue
  }
  
  public convenience init(from decoder: Decoder) throws {
    self.init()
    
    let container = try decoder.container(keyedBy: translationKeys.self) // defining our (keyed) container
    let translationsString = try container.decode(String.self, forKey: .translations)
    translations = ParserHelper.parse(data: translationsString)
    if let rawValueStr = try? container.decode(String.self, forKey: .rawValue) {
      rawValue = ParserHelper.parse(data: rawValueStr)
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: translationKeys.self)
    
    let translationsStr = ParserHelper.encodeObject(data: translations)
    try codingKeys.encode(translationsStr, forKey: .translations)
    let rawValueStr = ParserHelper.encodeObject(data: self.rawValue)
    try codingKeys.encode(rawValueStr, forKey: .rawValue)
  }
}
