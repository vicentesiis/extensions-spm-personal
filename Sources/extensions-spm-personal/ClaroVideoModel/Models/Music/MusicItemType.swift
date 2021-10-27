//
//  MusicItemType.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 12/07/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

public enum MusicItemType: String {
  case poster
  case image
  case text
  case buttonPlay
  case undefined
  
  public static func transformToString(text: String) -> MusicItemType {
    switch text {
    case "POSTER":
      return .poster
    case "IMAGE":
      return .image
    case "TEXT":
      return .text
    case "BUTTON_PLAY":
      return .buttonPlay
    default:
      return .undefined
    }
  }
  
}
