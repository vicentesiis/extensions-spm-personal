//
//  NodeConfig.swift
//  ClaroVideoServices
//
//  Created by Alejandro Hernandez Tapia on 10/4/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public struct NodeConfig {
  public let showNode: Bool
  public let showTitle: Bool
}

extension NodeConfig: Decodable {
  enum NodeConfigKeys: String, CodingKey {
    case showNode = "show_node"
    case showTitle = "show_title"
  }
}
