//
//  Node.swift
//  ClaroVideoServices
//
//  Created by Alejandro Hernandez Tapia on 10/3/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class Node: NSObject {
  // MARK: - Properties
  public let id: String
  public var parentId: String?
  public let code: String
  public let text: String
  public let menuId: String
  public var iconURL: String?
  public var imageURL: String?
  public var imageOverURL: String?
  public var recommendationsURL: String?
  public var colorKey: String?
  public let level: Int
  public var type: String?
  public let order: String
  public var status: String?
  public var appBehaviour: [String: Any]?
  public var childs: [Node]?
  
  // MARK: - Initialize
  public init(id: String,
              parentId: String?,
              code: String,
              text: String,
              menuId: String,
              iconURL: String?,
              imageURL: String?,
              imageOverURL: String?,
              recommendationsURL: String?,
              colorKey: String?,
              level: Int,
              type: String?,
              order: String,
              status: String?,
              appBehaviour: [String: Any]?,
              childs: [Node]?) {
    self.id = id
    self.parentId = parentId
    self.code = code
    self.text = text
    self.menuId = menuId
    self.iconURL = iconURL
    self.imageURL = imageURL
    self.imageOverURL = imageOverURL
    self.recommendationsURL = recommendationsURL
    self.colorKey = colorKey
    self.level = level
    self.type = type
    self.order = order
    self.status = status
    self.appBehaviour = appBehaviour
    self.childs = childs
  }

  // MARK: - Decode
  required convenience public init(from decoder: Decoder) throws {
    // Get valuess
    let values = try decoder.container(keyedBy: Nodekeys.self)
    let id = try values.decode(String.self, forKey: .id)
    let parentId = try values.decodeIfPresent(String.self, forKey: .parentId)
    let code = try values.decode(String.self, forKey: .code)
    let text = try values.decode(String.self, forKey: .text)
    let menuId = try values.decode(String.self, forKey: .menuId)
    let iconURL = try values.decodeIfPresent(String.self, forKey: .iconURL)
    let imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
    let imageOverURL = try values.decodeIfPresent(String.self, forKey: .imageOverURL)
    let recommendationsURL = try values.decodeIfPresent(String.self, forKey: .recommendationsURL)
    let colorKey = try values.decodeIfPresent(String.self, forKey: .colorKey)
    let level = try values.decode(Int.self, forKey: .level)
    let type = try values.decodeIfPresent(String.self, forKey: .type)
    let order = try values.decode(String.self, forKey: .order)
    let status = try values.decodeIfPresent(String.self, forKey: .status)
    let childs = try values.decodeIfPresent([Node].self, forKey: .childs)
    let appBehaviourString = try values.decodeIfPresent(String.self, forKey: .appBehaviour)
    let appBehaviour: [String: Any]? = ParserHelper.parse(data: appBehaviourString ?? "")
    
    // Initialize
    self.init(
      id: id,
      parentId: parentId,
      code: code,
      text: text,
      menuId: menuId,
      iconURL: iconURL,
      imageURL: imageURL,
      imageOverURL: imageOverURL,
      recommendationsURL: recommendationsURL,
      colorKey: colorKey,
      level: level,
      type: type,
      order: order,
      status: status,
      appBehaviour: appBehaviour,
      childs: childs
    )
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: Nodekeys.self)
    try codingKeys.encode(id, forKey: .id)
    try codingKeys.encodeIfPresent(parentId, forKey: .parentId)
    try codingKeys.encode(code, forKey: .code)
    try codingKeys.encode(text, forKey: .text)
    try codingKeys.encode(menuId, forKey: .menuId)
    try codingKeys.encodeIfPresent(iconURL, forKey: .iconURL)
    try codingKeys.encodeIfPresent(imageURL, forKey: .imageURL)
    try codingKeys.encodeIfPresent(imageOverURL, forKey: .imageOverURL)
    try codingKeys.encodeIfPresent(recommendationsURL, forKey: .recommendationsURL)
    try codingKeys.encodeIfPresent(colorKey, forKey: .colorKey)
    try codingKeys.encode(level, forKey: .level)
    try codingKeys.encodeIfPresent(type, forKey: .type)
    try codingKeys.encode(order, forKey: .order)
    try codingKeys.encode(status, forKey: .status)
    try codingKeys.encodeIfPresent(childs, forKey: .childs)
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: self.appBehaviour ?? [:], options: .prettyPrinted)
      let strAppBehaviour:String? = String(data: jsonData, encoding: .utf8)
      try codingKeys.encode(strAppBehaviour, forKey: .appBehaviour)
    }
  }
}
