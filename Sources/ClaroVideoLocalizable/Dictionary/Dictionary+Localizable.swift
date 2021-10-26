//
//  Dictionary+Localizable.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 20/10/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value: Any {
  public func localizedObject() -> Any {
    let region = LocalizableCache.shared.region
    let lowerRegion = region.lowercased()
    let upperRegion = region.uppercased()
    let capitalizedRegion = region.capitalized
    if let lowerLocalized = self[lowerRegion] {
      return lowerLocalized
    } else if let upperLocalized = self[upperRegion] {
      return upperLocalized
    } else if let capitalizedLocalized = self[capitalizedRegion] {
      return capitalizedLocalized
    } else if let defaultObject = self["default"] {
      return defaultObject
    }
    return self
  }
  
  public func localized() -> [String:Any] {
    // this validation is for metadata.translations
    if let languajeDict = self["language"] as? [String:Any] {
      return languajeDict.localized()
    }
    if let localizedDict = self.localizedObject() as? [String:Any] {
      return localizedDict
    }
    return self
  }
  
  public func localizedString() -> String? {
    if let languajeDict = self["language"] as? [String:Any] {
      return languajeDict.localizedString()
    }
    if let localized = self.localizedObject() as? String {
      return localized
    }
    return nil
  }
  
  public func localizedArray() -> [String] {
    if let localizedArray = self.localizedObject() as? [String] {
      return localizedArray
    }
    return []
  }
}

