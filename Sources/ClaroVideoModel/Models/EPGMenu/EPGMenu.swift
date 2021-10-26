//
//  EPGMenu.swift
//  ClaroVideoServices
//
//  Created by Miguel Perera on 10/02/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

public struct EPGMenu {
  
  public var id: String
  public var idParent: String
  public var code: String
  public var text: String
  public var menuId: String?
  public var image: String?
  public var imageOver: String?
  public var level: Int
  public var type: String?
  public var order: String?
  public var status: String?
  public var appBehaviour: [String:Any]?
  
  
  // MARK: - Instance Methods
  public init(id:String = "", idParent:String = "", code:String = "",
              text:String = "", menuId:String? = nil, image:String? = nil,
              imageOver:String? = nil, level:Int = -1, type:String? = nil,
              order:String? = nil, status:String? = nil , appBehaviour:[String:Any]? = nil) {
    self.id = id
    self.idParent = idParent
    self.code = code
    self.text = text
    self.menuId = menuId
    self.image = image
    self.imageOver = imageOver
    self.level = level
    self.type = type
    self.order = order
    self.status = status
    self.appBehaviour = appBehaviour
  }
  
  public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
    idParent = try container.decodeIfPresent(String.self, forKey: .idParent) ?? ""
    code = try container.decodeIfPresent(String.self, forKey: .code) ?? ""
    text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""
    menuId = try container.decodeIfPresent(String.self, forKey: .menuID)
    image = try container.decodeIfPresent(String.self, forKey: .image)
    imageOver = try container.decodeIfPresent(String.self, forKey: .imageOver)
    level = try container.decodeIfPresent(Int.self, forKey: .level) ?? 0
    type = try container.decodeIfPresent(String.self, forKey: .type)
    order = try container.decodeIfPresent(String.self, forKey: .order)
    status = try container.decodeIfPresent(String.self, forKey: .status)
    if let appBehaviour = try? container.decodeIfPresent([String:Any].self, forKey: .appBehaviour) {
      self.appBehaviour = appBehaviour
    }
  }
}

extension EPGMenu: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id, forKey: .id)
    try container.encode(idParent, forKey: .idParent)
    try container.encode(code, forKey: .code)
    try container.encode(text, forKey: .text)
    try container.encode(image, forKey: .image)
    try container.encode(imageOver, forKey: .imageOver)
    try container.encode(level, forKey: .level)
    try container.encode(type, forKey: .type)
    try container.encode(order, forKey: .order)
    try container.encode(status, forKey: .status)
  }
}
