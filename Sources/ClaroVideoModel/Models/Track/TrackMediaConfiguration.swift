//
//  TrackMediaConfiguration.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 11/03/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public final class TrackMediaConfiguration: NSObject {
  public var playerMedia: PlayerMedia?
  public var isTrailer: Bool = false
  public var isUserLogged: Bool = false
  public var isOfflinePlayback: Bool = false
  public var isLive: Bool = false
}

public enum CVTrackRequestType {
  case trackPause
  case trackStop
  case trackSeek
  case trackBack
  case trackResume
  case trackView
  case trackEpisodeChange
  case trackQualityChange
  case trackDubSubChange
  case trackPlayerError
  case trackCompletion
  case trackCredits
  case trackDownload
  case trackTick
  case none
}
