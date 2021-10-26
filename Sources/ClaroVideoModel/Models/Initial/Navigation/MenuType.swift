//
//  MenuType.swift
//  ClaroVideoServices
//
//  Created by Alejandro Hernandez Tapia on 10/10/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public enum MenuType: String {
  case classic = "classic"
  case secondMenu = "second_menu"
  
  func transformToString() -> String {
    switch self {
    case .classic:
      return "classic"
    default:
      return "second_menu"
    }
  }
}
