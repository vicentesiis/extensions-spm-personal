//
//  ModuleComponent.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/1/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class ModuleComponent: NSObject {
  public var name: String
  public var type: String
  public var properties: Properties
  
  // MARK: - Instance Methods
  public override init() {
    self.name = ""
    self.type = ""
    self.properties = Properties()
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String.self, forKey: .name)
    type = try container.decode(String.self, forKey: .type)
    properties = try container.decode(Properties.self, forKey: .properties)
  }
}
