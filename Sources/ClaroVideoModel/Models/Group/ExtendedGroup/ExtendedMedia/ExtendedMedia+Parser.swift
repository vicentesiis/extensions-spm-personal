//
//  ExtendedMedia+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/22/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension ExtendedMedia: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case boxoffice = "boxoffice"
    case description_extended = "description_extended"
    case duration = "duration"
    case haspreview = "haspreview"
    case islive = "islive"
    case liveref = "liveref"
    case livetype = "livetype"
    case originaltitle = "originaltitle"
    case publishyear = "publishyear"
    case rollingcreditstime = "rollingcreditstime"
    case channelNumber = "channel_number"
    case proveedorName = "proveedor"
    case profile = "profile"
    case rating = "rating"
    case countryOfOritin = "countryoforigin"
    case serie = "serie"
    case serieSeason = "serieseason"
    case episode = "episode"
    case language = "language"
  }
  enum LanguageCodingKeys: String, CodingKey { // declaring our keys
    case languageFormatOriginal = "original"
    case languageFormatDubbing = "dubbed"
    case languageFormatSubtitle = "subbed"
    case options = "options"
  }
  enum LanguageOptionsCodingKeys: String, CodingKey { // declaring our keys
    case languageFormatOptions = "option"
  }
  
  enum ProveedorCodingKeys: String, CodingKey { // declaring our keys
    case codigo = "codigo"
  }
}
