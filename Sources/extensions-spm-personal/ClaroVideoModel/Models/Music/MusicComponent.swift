//
//  MusicComponent.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 17/07/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

public struct MusicComponent {
  public var type: MusicComponentType
  public var properties: [String:Any]?
  public var items: [MusicItem]?
  
  // MARK: - Instance Methods
  public init() {
    type = .undefined
    properties = nil
    items = nil
  }
  
  public init(type: MusicComponentType,properties:[String:Any]?,items:[MusicItem]?) {
    self.type = type
    self.properties = properties
    self.items = items
  }
}

extension MusicComponent {
  /// Deserialize json dictionary music middleware services
  ///
  /// - Parameter jsonDictionary: [AnyHashable: Any]
  /// - Returns: MusicComponent
  public static func deserializeResponse(jsonDictionary: [[AnyHashable: Any]]) -> [MusicComponent] {
    
    var arrayMusicComponent: [MusicComponent] = []
    
    // Deserialize
    for dictionary in jsonDictionary {
      if let type = dictionary["type"] as? String {
        var musicComponent = MusicComponent()
        
        musicComponent.type = MusicComponentType.transformToString(text: type)
        
        musicComponent.properties = MusicProperty.deserealizeResponse(jsonDictionary: dictionary)
        
        if let itemsDict = dictionary["items"] as? [[AnyHashable: Any]] {
          musicComponent.items = MusicItem.deserializeResponse(jsonDictionary: itemsDict)
        }
        arrayMusicComponent.append(musicComponent)
      }
    }
    
    // Return value
    return arrayMusicComponent
  }
  
}
