//
//  Module2.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/1/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class Module: NSObject {
  
  public var name: String
  public var type: String
  public var components: [ModuleComponent]
  
  // MARK: - Instance Methods
  public override init() {
    self.name = ""
    self.type = ""
    self.components = []
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    type = try container.decode(String.self, forKey: .type)
    name = try container.decode(String.self, forKey: .name)
    let componentsContainer = try container.nestedContainer(keyedBy: ComponentsKeys.self, forKey: .components)
    components = try componentsContainer.decode([ModuleComponent].self, forKey: .component)
  }
}
