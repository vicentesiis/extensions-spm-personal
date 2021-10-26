//
//  EPGEvent.swift
//  ClaroVideoServices
//
//  Created by Luis Salcido on 03/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

public final class EPGEvent: NSObject {
  public var eventId: Int
  public var name: String
  public var eventDescription: String
  public var dateBegin: Date
  public var dateEnd: Date
  public var dateBeginInterva: Int
  public var talent: String
  public var type: String
  // Ext properties
  public var extOriginalName: String
  public var extEventImageName: String
  public var extCatchup: String
  public var extStartover: String
  public var extRecordable: String
  public var extSeriesId: String?
  public var extSeasonId: String?
  public var extEpisodeId: String?
  public var parentalRating: String
  public var contentGenres: String
  public var duration: String
  
  // MARK: - Instance Methods
  public override init() {
    self.eventId = 0
    self.name = ""
    self.eventDescription = ""
    self.dateBegin = Date()
    self.dateEnd = Date()
    self.dateBeginInterva = 0
    self.talent = ""
    self.type = ""
    // Ext properties
    self.extOriginalName = ""
    self.extEventImageName = ""
    self.extCatchup = ""
    self.extStartover = ""
    self.extRecordable = ""
    self.parentalRating = ""
    self.contentGenres = ""
    self.duration = ""
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let id = try container.decodeIfPresent(String.self, forKey: .eventId) {
      eventId = Int(id) ?? 0
    }
    if let nameEvent = try? container.decode(String.self, forKey: .name) {
      name = nameEvent
    }
    if let eventDes = try? container.decode(String.self, forKey: .eventDescription) {
      eventDescription =  eventDes
    }
    if let dateBeg = try? container.decode(String.self, forKey: .dateBegin) {
      self.dateBegin = self.responseDateFormatter.date(from: dateBeg) ?? Date()
    } else if let beingTime = try? container.decode(String.self, forKey: .beginTime) {
      self.dateBegin = self.responseDateFormatter.date(from: beingTime) ?? Date()
    }
    if let dateEnd = try? container.decode(String.self, forKey: .dateEnd) {
      self.dateEnd = self.responseDateFormatter.date(from: dateEnd) ?? Date()
    } else if let endTime = try? container.decode(String.self, forKey: .endTime) {
      self.dateEnd = self.responseDateFormatter.date(from: endTime) ?? Date()
    }
    if let tal = try? container.decode(String.self, forKey: .talent) {
      talent = tal
    }
    if let extOriginN = try? container.decode(String.self, forKey: .extOriginalName) {
      extOriginalName =  extOriginN
    }
    if let extCatc = try? container.decode(String.self, forKey: .extCatchup) {
      extCatchup = extCatc
    }
    if let extStar = try? container.decode(String.self, forKey: .extStartover) {
      extStartover =  extStar
    }
    if let extRecod  = try? container.decode(String.self, forKey: .extRecordable) {
      extRecordable = extRecod
    }
    extSeriesId = try? container.decode(String.self, forKey: .extSeriesId)
    extEpisodeId = try? container.decode(String.self, forKey: .extEpisodeId)
    if let parentalRat = try? container.decode(String.self, forKey: .parentalRating) {
      parentalRating = parentalRat
    }
    if let contetGen = try? container.decode(String.self, forKey: .contentGenres) {
      contentGenres = contetGen
    }
    if let dur = try? container.decode(String.self, forKey: .duration) {
      duration = dur
    }
    
    if let eventImage = try? container.decode(String.self, forKey: .extEventimageName) {
      extEventImageName = eventImage
    } else if let channelImage = try? container.decode(String.self, forKey: .image) {
      extEventImageName = channelImage
    }

    if let type =  try? container.decodeIfPresent(String.self, forKey: .type) {
      self.type = type
    }
  }
  
  
  fileprivate lazy var responseDateFormatter: DateFormatter = {
    let responseDateFormatter = DateFormatter()
    responseDateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    responseDateFormatter.locale = Locale(identifier: "es_MX")
    return responseDateFormatter
  }()
  
}
