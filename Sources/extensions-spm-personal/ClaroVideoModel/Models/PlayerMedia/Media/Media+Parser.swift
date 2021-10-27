//
//  Media+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/9/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Media: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case videoUrl = "video_url"
    case certificateURL = "certificate_url"
    case serverUrl = "server_url"
    case challenge = "challenge"
    case analyticsUrl = "analytics_url"
    case initialPlaybackSecond = "initial_playback_in_seconds"
    case duration = "duration"
    case audios = "audio"
    case subtitles = "subtitles"
  }
  enum AudioSubtitlesCodingKeys: String, CodingKey {
    case options = "options"
  }
}
