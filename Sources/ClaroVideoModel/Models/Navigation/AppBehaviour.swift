//
//  AppBehaviour.swift
//  ClaroVideoServices
//
//  Created by Alejandro Hernandez Tapia on 10/4/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public struct AppBehaviour {
  public let layout: String?
  public let nodeConfig: NodeConfig
}

extension AppBehaviour: Decodable {
  enum AppBehaviourKeys: String, CodingKey {
    case layout
    case nodeConfig = "node_config"
  }
}
