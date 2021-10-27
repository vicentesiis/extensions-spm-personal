//
//  SearchProviderResult+ Parser.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 14/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

extension SearchProviderResult: Decodable {
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case series = "series"
    case serie = "serie"
    
    case movies = "movies"
    case movie = "movie"
    
    case liveChannels = "live_channels"
    case liveChannel = "live_channel"
    
    case epg = "epg"
    case now = "now"
    case past = "past"
    case future = "future"
  }
  
}
