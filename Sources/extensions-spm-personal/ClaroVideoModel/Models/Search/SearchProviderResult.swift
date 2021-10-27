//
//  SearchProviderResult.swift
//  ClaroVideoServices
//
//  Created by Luis Salcido on 14/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

public final class SearchProviderResult: NSObject {
  public var provider: String?
  public var liveEvents: [EPGChannel]?
  public var pastEvents: [EPGChannel]?
  public var futureEvents: [EPGChannel]?

  public var series: [Group]?
  public var movies: [Group]?
  public var channels: [Group]?
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let seriesKey = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .series) {
      series = try? seriesKey.decode([Group].self, forKey: .serie)
    }
    if let moviesKey = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .movies) {
      movies = try? moviesKey.decode([Group].self, forKey: .movie)
    }
    if let liveChannelsKey = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .liveChannels) {
      channels = try? liveChannelsKey.decode([Group].self, forKey: .liveChannel)
    }
    if let epgKey = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .epg) {
      liveEvents = try? epgKey.decode([EPGChannel].self, forKey: .now)
      pastEvents = try? epgKey.decode([EPGChannel].self, forKey: .past)
      futureEvents = try? epgKey.decode([EPGChannel].self, forKey: .future)
    }
  }
}
