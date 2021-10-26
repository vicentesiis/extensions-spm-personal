//
//  EPGChannel+Parser.swift
//  ClaroVideoServices
//
//  Created by Luis Salcido on 03/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

extension EPGChannel: Decodable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case channelId = "channel_id"
    case number = "number"
    case id = "id"
    case chanelName = "channel_name"
    case name = "name"
    case imageURL = "channel_image"
    case image = "image"
    case events = "events"
    case channleGroup = "channel_group"
    case group = "group"
    
    case common = "common"
  }
}
