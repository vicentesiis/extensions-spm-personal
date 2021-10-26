//
//  MusicProperty.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 12/07/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

public struct MusicProperty {
  public let value: Any
  public let style: String?
  
  // MARK: - Instance Methods
  public init() {
    value = ""
    style = nil
  }
  
  public init(value:Any, style:String?) {
    self.value = value
    self.style = style
  }
  
  public static func deserealizeResponse(jsonDictionary: [AnyHashable: Any]) -> [String:Any]? {
    guard let propertiesDic = jsonDictionary["properties"] as? [String:Any] else { return nil }
    
    var properties: [String:Any] = [:]
    for (key,value) in propertiesDic {
      var propertyValue: Any? = nil
      var propertyStyle: String? = nil
      
      // If value is dictionary
      if let dictValue = value as? [String:Any] {
        propertyValue = dictValue["text"]
        
        if propertyValue == nil {
          propertyValue = dictValue["image"]
        }
        
        if let style = dictValue["style"] as? String {
          propertyStyle = style
        }
        propertyValue = MusicProperty(value: propertyValue ?? "", style: propertyStyle)
      }else {
        propertyValue = value
      }
      properties[key] = propertyValue
    }
    
    return properties
  }
  
}
