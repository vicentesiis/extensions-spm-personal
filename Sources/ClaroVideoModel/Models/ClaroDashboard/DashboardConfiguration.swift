//
//  DashboardConfiguration.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 16/03/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public final class ClaroDashboardConfiguration: NSObject {
  public var playerMedia: PlayerMedia?
  public var languageSelected: OptionLanguage?
  public var currentQualitySelected: Quality?
  public var qualities: [Quality]?
  public var isMultipleAudio: Bool = false
  public var totalStreamTime: Int?
}

public enum ClaroDashboardOperators: String {
  //MARK: Claro dashboard
  case pgm               = "pgm"
  case start             = "start"
  case end               = "end"
  case pause             = "pause"
  case resume            = "resume"
  case stop              = "stop"
  case leave             = "leave"
  case error             = "error"
  case bufferingStart    = "buffering_start"
  case bufferingEnd      = "buffering_end"
  case seek              = "seek"
  case qualityUp         = "quality_up"
  case qualityDown       = "quality_down"
  case language          = "language"
  case episode           = "episode"
  case forward           = "forward"
  case rewind            = "rewind"
  case forward30         = "forward30"
  case rewind30          = "rewind30"
  case quality           = "quality"
  case reBufferingStart  = "rebuffering_start"
  case reBufferingEnd    = "rebuffering_end"
  case bitrate           = "bitrate"
}
