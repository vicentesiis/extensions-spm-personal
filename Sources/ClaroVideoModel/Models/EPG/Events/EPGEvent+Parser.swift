//
//  EPGEvent+Parser.swift
//  ClaroVideoServices
//
//  Created by Luis Salcido on 03/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

extension EPGEvent: Decodable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case eventId = "id"
    case name = "name"
    case eventDescription = "description"
    case dateBegin = "date_begin"
    case dateEnd = "date_end"
    case beginTime = "begintime"
    case endTime = "endtime"
    case talent = "talent"
    case extOriginalName = "ext_original_name"
    case extCatchup = "ext_catchup"
    case extStartover = "ext_startover"
    case extRecordable = "ext_recordable"
    case extSeriesId = "ext_series_id"
    case extSeasonId = "ext_season_id"
    case extEpisodeId = "ext_episode_id"
    case parentalRating = "parental_rating"
    case contentGenres = "dvb_content"
    case duration = "duration"
    case extEventimageName = "ext_eventimage_name"
    case image = "image"
    case type = "type"
  }
}
