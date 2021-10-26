//
//  MusicComponentType.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 17/07/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

public enum MusicComponentType {
  case grid
  case header
  case botonera
  case tracksTable
  case fullScreenPlayer
  case playerHeader
  case playerTrackDetail
  case playerSeekBar
  case playerButtons
  case ribbon
  case undefined
  
  public static func transformToString(text: String) -> MusicComponentType {
    switch text {
    case "GRID":
      return .grid
    case "HEADER":
      return .header
    case "BOTONERA":
      return .botonera
    case "TRACKS_TABLE":
      return .tracksTable
    case "FULL_SCREEN_PLAYER":
      return .fullScreenPlayer
    case "PLAYER_HEADER":
      return .playerHeader
    case "PLAYER_TRACK_DETAIL":
      return .playerTrackDetail
    case "PLAYER_SEEK_BAR":
      return .playerSeekBar
    case "PLAYER_BUTTONS":
      return .playerButtons
    case "RIBBON":
      return .ribbon
    default:
      return .undefined
    }
  }
}
