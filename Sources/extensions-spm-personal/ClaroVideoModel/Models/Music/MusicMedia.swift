//
//  MusicMedia.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 12/07/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

public struct MusicMedia {
  
  public var trackUrl: String?
  public var licenserUrl: String?
  public var certificateUrl: String?
  public var challenge: [AnyHashable: Any]?
  public var hasMusicSuscription: Bool
  public var metadata: MusicMetadata?
  public var trackingSuccess: MusicTracking?
  public var trackingError: MusicTracking?
  public var trackingTick: MusicTracking?
  
  public init() {
    trackUrl = ""
    licenserUrl = ""
    certificateUrl = ""
    challenge = nil
    hasMusicSuscription = false
    trackingSuccess = nil
    trackingError = nil
    trackingTick = nil
  }
  
  public init(from decoder: Decoder) throws {
    self.init()
    let media = try decoder.container(keyedBy: CodingKeys.self)
    trackUrl = try? media.decode(String.self, forKey: .track_url)
    licenserUrl = try? media.decode(String.self, forKey: .licenser_url)
    certificateUrl = try? media.decode(String.self, forKey: .certificate_url)
  }
}
