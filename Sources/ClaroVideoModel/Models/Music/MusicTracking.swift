//
//  MusicTracking.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 16/07/19.
//  Copyright © 2019 AMCO. All rights reserved.
//

import Foundation

public struct MusicTracking {
  
  public var url: String?
  public var body: [AnyHashable: Any]?
  public var data: [AnyHashable: Any]?
  public var intervalTimer: Int
  
  public init() {
    url = ""
    body = nil
    data = nil
    intervalTimer = 0
  }
  
  public init(from decoder: Decoder) throws {
    self.init()
    let codingKeys = try decoder.container(keyedBy: CodingKeys.self)
    url = try? codingKeys.decode(String.self, forKey: .url)
    intervalTimer = try codingKeys.decodeIfPresent(Int.self, forKey: .interval_timer) ?? 0
  }
  
}
