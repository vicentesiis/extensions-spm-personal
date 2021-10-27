//
//  EPGChannel.swift
//  ClaroVideoServices
//
//  Created by Luis Salcido on 03/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

public final class EPGChannel: NSObject {
  public var channelId: Int
  public var number: String
  public var name: String
  public var imageURL: URL?
  public var events: [EPGEvent]
  public var currentEventPlaying: EPGEvent?
  public var group: Group
  
  // MARK: - Instance Methods
  public override init() {
    self.channelId = 0
    self.number = ""
    self.name = ""
    self.imageURL = nil
    self.events = []
    self.currentEventPlaying = nil
    self.group = Group()
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let channelIdStr = try? container.decode(String.self, forKey: .channelId) {
      channelId = Int(channelIdStr) ?? 0
    } else if let id = try? container.decode(String.self, forKey: .id) {
      channelId = Int(id) ?? 0
    }
    if let numberStr = try? container.decode(String.self, forKey: .number) {
      number = numberStr
    }
    name = try container.decodeIfPresent(String.self, forKey: .name) ?? (try container.decodeIfPresent(String.self, forKey: .chanelName) ?? "")
    if let groupJson = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .group),
      let groupDecode = try? groupJson.decode(Group.self, forKey: .common) {
      group = groupDecode
    } else if let channelGroup = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .channleGroup),
      let groupDecode = try? channelGroup.decode(Group.self, forKey: .common) {
      group = groupDecode
    }
    if let eventsArray = try? container.decode([EPGEvent].self, forKey: .events) {
      events =  eventsArray
    }
    if let channelImage = try? container.decodeIfPresent(URL.self, forKey: .imageURL) {
      imageURL = channelImage
    } else if let image = try? container.decodeIfPresent(URL.self, forKey: .image) {
      imageURL = image
    } else if !self.group.group_id.isEmpty,
      !self.group.imageSmall.isEmpty {
      imageURL = URL(string: self.group.imageSmall)
    } else {
      imageURL = URL(string: "https://clarovideocdn7.clarovideo.net/pregeneracion/cms/apa/52f50ed0e4b053d3a195affb/vcard_live_event_default_landscape.png?1517253218")
    }
    if let currentEvent = try? EPGEvent.init(from: decoder) {
      if currentEvent.extEventImageName.isEmpty {
        currentEvent.extEventImageName = !group.imageBaseHorizontal.isEmpty ? group.imageBaseHorizontal : "vcard_live_event_default_landscape"
      }
      currentEventPlaying = currentEvent
    }
  }
  
}
