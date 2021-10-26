//
//  Recording.swift
//  Clarovideo
//
//  Created by alonso.salcido on 20/02/18.
//  Copyright © 2018 AMCO. All rights reserved.
//

import Foundation

public struct Recording {
  
  // MARK: - Properties
  //MyContentItem property
  public var recordId: Int
  public var providerId: Int
  public var packId: Int
  public var dateBegin: Date
  public var dateEnd: Date
  public var groupId: Int
  public var status: RecordingStatus
  public var name: String
  public var channelImage: URL?
  public var actions: [String:Any]
  public var channelId: Int
  public var eventId: Int
  public var eventName: String
  public var extSeasonId: Int
  public var eventSerieId: Int?
  public var eventEpisodeId: Int?
  public var eventImage: URL?
  public var eventDuration: Int?
  
  public init() {
    self.recordId = 0
    self.providerId = 0
    self.packId = 0
    self.dateBegin = Date()
    self.dateEnd = Date()
    self.groupId = 0
    self.status = .none
    self.name = ""
    self.channelImage = nil
    self.actions = [:]
    self.channelId = 0
    self.eventId = 0
    self.eventName = ""
    self.extSeasonId = 0
    self.eventSerieId = nil
    self.eventEpisodeId = nil
    self.eventImage = nil
    self.eventDuration = nil
  }
  
  public init(from decoder: Decoder) throws {
    self.init()
    let codingKeys = try decoder.container(keyedBy: CodingKeys.self)
    if let recordIdDecode = try? codingKeys.decode(Int.self, forKey: .record_id) {
      self.recordId = recordIdDecode
    }
    providerId = try codingKeys.decode(Int.self, forKey: .provider_id)
    if let id = try? codingKeys.decode(Int.self, forKey: .pack_id) {
      packId = id
    }
    let statusString = try codingKeys.decode(String.self, forKey: .status)
    status = RecordingStatus.getRecordingStatusFrom(string: statusString)
    
    let channelKeys = try codingKeys.nestedContainer(keyedBy: CodingKeys.self, forKey: .channel)
    channelId = try channelKeys.decode(Int.self, forKey: .id)
    let groupIdDecode = try channelKeys.decode(Int.self, forKey: .group_id)
    self.groupId = groupIdDecode
    name = try channelKeys.decode(String.self, forKey: .name)
    channelImage = try? channelKeys.decode(URL.self, forKey: .image)
    
    
    let eventKeys = try channelKeys.nestedContainer(keyedBy: CodingKeys.self, forKey: .event)
    eventId = try eventKeys.decode(Int.self, forKey: .id)
    let dateBegin = try eventKeys.decode(Int.self, forKey: .date_begin)
    self.dateBegin = Date(timeIntervalSince1970: TimeInterval(dateBegin))
    let dateEnd = try eventKeys.decode(Int.self, forKey: .date_end)
    self.dateEnd = Date(timeIntervalSince1970: TimeInterval(dateEnd))
    eventName = try eventKeys.decode(String.self, forKey: .name)
    extSeasonId = try eventKeys.decode(Int.self, forKey: .extSeasonId)
    eventSerieId = try? eventKeys.decodeIfPresent(Int.self, forKey: .extSerieId)
    eventEpisodeId = try? eventKeys.decodeIfPresent(Int.self, forKey: .extEpisodeId)
    eventImage = try? eventKeys.decode(URL.self, forKey: .extEventImageName)
    eventDuration = try? eventKeys.decodeIfPresent(Int.self, forKey: .duration)
  }
  
}
