//
//  Modules.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/1/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final class Modules: NSObject {
  
  public var module: [Module]
  
  // MARK: - Instance Methods
  public init(module: [Module] = [Module]()) {
    self.module = module
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    module = try container.decode([Module].self, forKey: .module)
  }
}
