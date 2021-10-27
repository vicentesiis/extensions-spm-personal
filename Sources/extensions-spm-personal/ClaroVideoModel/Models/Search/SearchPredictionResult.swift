//
//  SearchPredictionResult.swift
//  ClaroVideoServices
//
//  Created by Luis Salcido on 14/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

public final class SearchPredictionResult: NSObject {

  public var talents: [Talent]?
  public var externalTalents: [Talent]?
  public var genres: [Params]?
  public var providers: [SearchProviderResult] = []
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let genresKey = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .genres) {
      genres = try? genresKey.decode([Params].self, forKey: .genre)
    }
    if let talentsKey = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .talents) {
      talents = try? talentsKey.decode([Talent].self, forKey: .talent)
    }
    let amcoResults = SearchProviderResult()
    var addProvider = false
    if let seriesKey = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .series) {
      amcoResults.series = try? seriesKey.decode([Group].self, forKey: .serie)
      addProvider = true
    }
    if let moviesKey = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .movies) {
      amcoResults.movies = try? moviesKey.decode([Group].self, forKey: .movie)
      addProvider = true
    }
    if let liveChannelsKey = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .liveChannels) {
      amcoResults.channels = try? liveChannelsKey.decode([Group].self, forKey: .liveChannel)
      addProvider = true
    }
    if let epgs = try? container.decode(SearchProviderResult.self, forKey: .epgs) {
      amcoResults.liveEvents = epgs.liveEvents
      amcoResults.futureEvents = epgs.futureEvents
      amcoResults.pastEvents = epgs.pastEvents
      addProvider = true
    }
    if addProvider {
      amcoResults.provider = "default"
      providers.append(amcoResults)
    }
  }
}
