//
//  Quality.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/13/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class Quality: NSObject {
  
  public var id: String
  public var label: String
  
  
  // MARK: - Instance Methods
  public init(id: String = "", label: String = "") {
    self.id = id
    self.label = label
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
    label = try container.decodeIfPresent(String.self, forKey: .label) ?? ""
  }
}
