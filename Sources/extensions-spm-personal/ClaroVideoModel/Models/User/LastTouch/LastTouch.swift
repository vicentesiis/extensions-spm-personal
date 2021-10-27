//
//  LastTouch.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/7/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class LastTouch: NSObject {
  public var seen: String?
  public var favorited: String?
  public var purchased: String?
  public var profile: String?
  public var reminder: String?
  public var liveChannel: String?

  override public init() {
    self.seen = nil
    self.favorited = nil
    self.purchased = nil
    self.profile = nil
    self.reminder = nil
    self.liveChannel = nil
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try? decoder.container(keyedBy: CodingKeys.self)
    seen = try? container?.decodeIfPresent(String.self, forKey: .seen)
    favorited = try? container?.decodeIfPresent(String.self, forKey: .favorited)
    purchased = try? container?.decodeIfPresent(String.self, forKey: .purchased)
    profile = try? container?.decodeIfPresent(String.self, forKey: .profile)
    reminder = try? container?.decodeIfPresent(String.self, forKey: .reminder)
    liveChannel = try? container?.decodeIfPresent(String.self, forKey: .liveChannel)
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(seen, forKey: .seen)
    try codingKeys.encode(favorited, forKey: .favorited)
    try codingKeys.encode(purchased, forKey: .purchased)
    try codingKeys.encode(profile, forKey: .profile)
    try codingKeys.encode(reminder, forKey: .reminder)
    try codingKeys.encode(liveChannel, forKey: .liveChannel)
  }
}
