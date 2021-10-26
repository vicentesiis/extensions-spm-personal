//
//  Tracklist+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/10/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Tracklist: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case policies = "policies"
    case urls = "urls"
  }
  
  enum PoliciesCodingKeys: String, CodingKey { // declaring our keys
    case tickInterval = "tick_interval"
    case retries = "retries"
  }
  
  enum UrlsCodingKeys: String, CodingKey { // declaring our keys
    case tickURL = "tick"
    case errorURL = "error"
    case viewURL = "view"
    case stopURL = "stop"
    case timecodeURL = "timecode"
    case completionURL = "completion"
    case intervalURL = "interval"
    case dubsubchangeURL = "dubsubchange"
    case qualitychangeURL = "qualitychange"
    case episodechangeURL = "episodechange"
    case seekURL = "seek"
    case pauseURL = "pause"
    case resumeURL = "resume"
    case downloadURL = "download"
    case creditsURL = "credits"
  }
}
