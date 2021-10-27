//
//  Group+Parceable.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/1/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Group: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case title = "title"
    case titleEpisode = "title_episode"
    case titleOriginal = "title_original"
    case titleUri = "title_uri"
    case imageSpritesURL = "image_sprites"
    case crest = "crest"
    case date = "date"
    case descriptionLarge = "description_large"
    case largeDescription = "large_description"
    case duration = "duration"
    case episodeNumber = "episode_number"
    case group_description = "description"
    case group_id = "group_id"
    case id = "id"
    case formatTypes = "format_types"
    case imageBaseHorizontal = "image_base_horizontal"
    case imageBaseVertical = "image_base_vertical"
    case proveedorCode = "proveedor_code"
    case imageBackground = "image_background"
    case imageHighlight = "image_highlight"
    case appBehaviour = "app_behaviour"
    case imageLarge = "image_large"
    case imageMedium = "image_medium"
    case imageSmall = "image_small"
    case item_id = "item_id"
    case liveEnabled = "live_enabled"
    case liveRef = "live_ref"
    case liveType = "live_type"
    case preview = "preview"
    case seasonNumber = "season_number"
    case section = "section"
    case special = "special"
    case url = "url"
    case volant = "volant"
    case votesAverage = "votes_average"
    case year = "year"
    case ratingCode = "rating_code"
    
    case imageStill = "image_still"
    case urlImageT1 = "url_imagen_t1"
    case urlImageT2 = "url_imagen_t2"
    case imageBaseSquare = "image_base_square"
    case imageCleanHorizontal = "image_clean_horizontal"
    case imageCleanVertical = "image_clean_vertical"
    case imageCleanSquare = "image_clean_square"
    case imageFrames = "image_frames"
    case channelNumber = "channel_number"
    case timeShift = "timeshift"
    case proveedorName = "proveedor_name"
    case encoderTechnology = "encoder_tecnology"
    case recorderTechnology = "recorder_technology"
    case resourceName = "resource_name"
    case isSeries = "is_series"
    case vistime = "vistime"
    case ranking = "ranking"
    case extended = "extendedcommon"
    
    case paywayToken = "paywayToken"
    case subscriptionType = "subscriptionType"
    case gatewayPurchased = "gatewayPurchased"
    case purchaseId = "purchaseId"
    case offerId = "offerId"
    case resumeTime = "resumeTime"
    case oneOfferType = "oneOfferType"
    case isPurchased = "isPurchased"
    case wasPurchased = "wasPurchased"
    case startdate = "startdate"
    case fromRibbon = "fromRibbon"
    case offerDescription = "offerDescription"
    case offerPrice = "offerPrice"
    case canPlay = "canPlay"
    case startTime = "startTime"
    case endTime = "endTime"
    case externalData = "externalData"
    case type = "type"
  }
}