//
//  ExtendedMedia.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/22/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class ExtendedMedia: NSObject, NSCoding {
  
  public var boxoffice: String
  public var description_extended: String
  public var duration: String
  public var haspreview: String
  public var islive: String
  public var liveref: String
  public var livetype: String
  public var originaltitle: String
  public var publishyear: String
  public var rollingcreditstime: String
  public var channelNumber: String
  public var countryOfOritin: CountryOfOrigin
  public var languageFormatDubbing: String
  @objc public var languageFormatOptions: [OptionLanguage]
  public var languageFormatOriginal: LanguageFormat
  public var languageFormatSubtitle: String
  public var proveedorCode: String
  public var profile: Profile
  public var rating: Rating
  public var serieSeason: SerieSeason
  public var serie: SerieSeason
  public var episode: Episode
  
  
  public override init() {
    self.boxoffice = ""
    self.description_extended = ""
    self.duration = ""
    self.haspreview = ""
    self.islive = ""
    self.liveref = ""
    self.livetype = ""
    self.originaltitle = ""
    self.publishyear = ""
    self.rollingcreditstime = ""
    self.channelNumber = ""
    self.countryOfOritin = CountryOfOrigin()
    self.languageFormatDubbing = ""
    self.languageFormatOptions = []
    self.languageFormatOriginal = LanguageFormat()
    self.languageFormatSubtitle = ""
    self.proveedorCode = ""
    self.profile = Profile()
    self.rating = Rating()
    self.serieSeason = SerieSeason()
    self.serie = SerieSeason()
    self.episode = Episode()
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(boxoffice, forKey: coding.boxoffice.rawValue)
    coder.encode(description_extended, forKey: coding.description_extended.rawValue)
    coder.encode(duration, forKey: coding.duration.rawValue)
    coder.encode(haspreview, forKey: coding.haspreview.rawValue)
    coder.encode(islive, forKey: coding.islive.rawValue)
    coder.encode(liveref, forKey: coding.liveref.rawValue)
    coder.encode(livetype, forKey: coding.livetype.rawValue)
    coder.encode(originaltitle, forKey: coding.originaltitle.rawValue)
    coder.encode(publishyear, forKey: coding.publishyear.rawValue)
    coder.encode(rollingcreditstime, forKey: coding.rollingcreditstime.rawValue)
    coder.encode(channelNumber, forKey: coding.channelNumber.rawValue)
    coder.encode(countryOfOritin, forKey: coding.countryOfOritin.rawValue)
    coder.encode(profile, forKey: coding.profile.rawValue)
    coder.encode(rating, forKey: coding.rating.rawValue)
    coder.encode(serieSeason, forKey: coding.serieSeason.rawValue)
    coder.encode(serie, forKey: coding.serie.rawValue)
    coder.encode(episode, forKey: coding.episode.rawValue)
    
    let codingProv = ProveedorCodingKeys.self
    coder.encode(proveedorCode, forKey: codingProv.codigo.rawValue)
    
    let codingLanguage = LanguageCodingKeys.self
    coder.encode(languageFormatDubbing, forKey: codingLanguage.languageFormatDubbing.rawValue)
    coder.encode(languageFormatOriginal, forKey: codingLanguage.languageFormatOriginal.rawValue)
    coder.encode(languageFormatSubtitle, forKey: codingLanguage.languageFormatSubtitle.rawValue)
    
    let codingLanguageOption = LanguageOptionsCodingKeys.self
    coder.encode(languageFormatOptions, forKey: codingLanguageOption.languageFormatOptions.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let boxofficeDecode = coder.decodeObject(forKey: coding.boxoffice.rawValue) as? String
    let descriptionExtendedDecode = coder.decodeObject(forKey: coding.description_extended.rawValue) as? String
    let durationDecode = coder.decodeObject(forKey: coding.duration.rawValue) as? String
    let haspreviewDecode = coder.decodeObject(forKey: coding.haspreview.rawValue) as? String
    let isliveDecode = coder.decodeObject(forKey: coding.islive.rawValue) as? String
    let liverefDecode = coder.decodeObject(forKey: coding.liveref.rawValue) as? String
    let livetypeDecode = coder.decodeObject(forKey: coding.livetype.rawValue) as? String
    let originaltitleDecode = coder.decodeObject(forKey: coding.originaltitle.rawValue) as? String
    let publishyearDecode = coder.decodeObject(forKey: coding.publishyear.rawValue) as? String
    let rollingcreditstimeDecode = coder.decodeObject(forKey: coding.rollingcreditstime.rawValue) as? String
    let channelNumber = coder.decodeObject(forKey: coding.channelNumber.rawValue) as? String
    let countryOfOritinDecode = coder.decodeObject(forKey: coding.countryOfOritin.rawValue) as? CountryOfOrigin
    let profileDecode = coder.decodeObject(forKey: coding.profile.rawValue) as? Profile
    let ratingDecode = coder.decodeObject(forKey: coding.rating.rawValue) as? Rating
    let serieSeasonDecode = coder.decodeObject(forKey: coding.serieSeason.rawValue) as? SerieSeason
    let serieDecode = coder.decodeObject(forKey: coding.serie.rawValue) as? SerieSeason
    let episodeDecode = coder.decodeObject(forKey: coding.episode.rawValue) as? Episode
    
    let codingProv = ProveedorCodingKeys.self
    let proveedorCodeDecode = coder.decodeObject(forKey: codingProv.codigo.rawValue) as? String
    
    let codingLanguage = LanguageCodingKeys.self
    let languageFormatDubbingDecode = coder.decodeObject(forKey: codingLanguage.languageFormatDubbing.rawValue) as? String
    let languageFormatOriginalDecode = coder.decodeObject(forKey: codingLanguage.languageFormatOriginal.rawValue) as? LanguageFormat
    let languageFormatSubtitleDecode = coder.decodeObject(forKey: codingLanguage.languageFormatSubtitle.rawValue) as? String
    
    let codingLanguageOption = LanguageOptionsCodingKeys.self
    let languageFormatOptionsDecode = coder.decodeObject(forKey: codingLanguageOption.languageFormatOptions.rawValue) as? [OptionLanguage]
    self.init()
    
    self.boxoffice = boxofficeDecode ?? ""
    self.description_extended = descriptionExtendedDecode ?? ""
    self.duration = durationDecode ?? ""
    self.haspreview = haspreviewDecode ?? ""
    self.islive = isliveDecode ?? ""
    self.liveref = liverefDecode ?? ""
    self.livetype = livetypeDecode ?? ""
    self.originaltitle = originaltitleDecode ?? ""
    self.publishyear = publishyearDecode ?? ""
    self.rollingcreditstime = rollingcreditstimeDecode ?? ""
    self.countryOfOritin = countryOfOritinDecode ?? CountryOfOrigin()
    self.profile = profileDecode ?? Profile()
    self.rating = ratingDecode ?? Rating()
    self.serieSeason = serieSeasonDecode ?? SerieSeason()
    self.serie = serieDecode ?? SerieSeason()
    self.episode = episodeDecode ?? Episode()
    self.proveedorCode = proveedorCodeDecode ?? ""
    self.channelNumber = channelNumber ?? ""
    self.languageFormatDubbing = languageFormatDubbingDecode ?? ""
    self.languageFormatOriginal = languageFormatOriginalDecode ?? LanguageFormat()
    self.languageFormatSubtitle = languageFormatSubtitleDecode ?? ""
    self.languageFormatOptions = languageFormatOptionsDecode ?? []
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let languageContainer = try? container.nestedContainer(keyedBy: LanguageCodingKeys.self, forKey: .language) {
      languageFormatDubbing = try languageContainer.decodeIfPresent(String.self, forKey: .languageFormatDubbing) ?? ""
      languageFormatOriginal = try languageContainer.decodeIfPresent(LanguageFormat.self, forKey: .languageFormatOriginal) ?? LanguageFormat()
      languageFormatSubtitle = try languageContainer.decodeIfPresent(String.self, forKey: .languageFormatSubtitle) ?? ""
      if let languageOptionsContainer = try? languageContainer.nestedContainer(keyedBy: LanguageOptionsCodingKeys.self, forKey: .options) {
        if let languageFormatOptionsDecode = try? languageOptionsContainer.decode([OptionLanguage].self, forKey: .languageFormatOptions) {
          languageFormatOptions = languageFormatOptionsDecode
        }
      }
    }
    
    if let proveedorContainer = try? container.nestedContainer(keyedBy: ProveedorCodingKeys.self, forKey: .proveedorName) {
      if let proveedorCodeDecode = try? proveedorContainer.decode(String.self, forKey: .codigo) {
        proveedorCode = proveedorCodeDecode
      }
    }
    
    boxoffice = try container.decodeIfPresent(String.self, forKey: .boxoffice) ?? ""
    description_extended = try container.decodeIfPresent(String.self, forKey: .description_extended) ?? ""
    if let durationDecode = try? container.decode(String.self, forKey: .duration) {
      duration = durationDecode
    }
    haspreview = try container.decodeIfPresent(String.self, forKey: .haspreview) ?? ""
    islive = try container.decodeIfPresent(String.self, forKey: .islive) ?? ""
    liveref = try container.decodeIfPresent(String.self, forKey: .liveref) ?? ""
    livetype = try container.decodeIfPresent(String.self, forKey: .livetype) ?? ""
    originaltitle = try container.decodeIfPresent(String.self, forKey: .originaltitle) ?? ""
    if let publishyearDecode = try? container.decode(String.self, forKey: .publishyear) {
      publishyear = publishyearDecode
    }
    rollingcreditstime = try container.decodeIfPresent(String.self, forKey: .rollingcreditstime) ?? ""
    if let int = try? container.decodeIfPresent(Int.self, forKey: .channelNumber) {
      channelNumber = String(int)
    }else {
      channelNumber = try container.decodeIfPresent(String.self, forKey: .channelNumber) ?? ""
    }
    countryOfOritin = try container.decodeIfPresent(CountryOfOrigin.self, forKey: .countryOfOritin) ?? CountryOfOrigin()
    
    if let profileDecode = try? container.decode(Profile.self, forKey: .profile) {
      profile = profileDecode
    }
    rating = try container.decodeIfPresent(Rating.self, forKey: .rating) ?? Rating()
    if let serieSeasonDecode = try? container.decode(SerieSeason.self, forKey: .serieSeason) {
      serieSeason = serieSeasonDecode
    }
    if let serieDecode = try? container.decode(SerieSeason.self, forKey: .serie) {
      serie = serieDecode
    }
    if let episodeDecode = try? container.decode(Episode.self, forKey: .episode) {
      episode = episodeDecode
    }
    
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(boxoffice, forKey: .boxoffice)
    try codingKeys.encode(description_extended, forKey: .description_extended)
    try codingKeys.encode(duration, forKey: .duration)
    try codingKeys.encode(haspreview, forKey: .haspreview)
    try codingKeys.encode(islive, forKey: .islive)
    try codingKeys.encode(liveref, forKey: .liveref)
    try codingKeys.encode(livetype, forKey: .livetype)
    try codingKeys.encode(originaltitle, forKey: .originaltitle)
    try codingKeys.encode(publishyear, forKey: .publishyear)
    try codingKeys.encode(rollingcreditstime, forKey: .rollingcreditstime)
    try codingKeys.encode(channelNumber, forKey: .channelNumber)
    try codingKeys.encode(countryOfOritin, forKey: .countryOfOritin)
    var languageKeys = codingKeys.nestedContainer(keyedBy: LanguageCodingKeys.self, forKey: .language)
    try languageKeys.encode(languageFormatDubbing, forKey: .languageFormatDubbing)
    try languageKeys.encode(languageFormatOriginal, forKey: .languageFormatOriginal)
    try languageKeys.encode(languageFormatSubtitle, forKey: .languageFormatSubtitle)
    var languageOptionsCoding = languageKeys.nestedContainer(keyedBy: LanguageOptionsCodingKeys.self, forKey: .options)
    try? languageOptionsCoding.encode(languageFormatOptions, forKey: .languageFormatOptions)
    try languageKeys.encode(languageFormatOriginal, forKey: .languageFormatOriginal)
    try languageKeys.encode(languageFormatSubtitle, forKey: .languageFormatSubtitle)
    var proveedorCoding = codingKeys.nestedContainer(keyedBy: ProveedorCodingKeys.self, forKey: .proveedorName)
    try proveedorCoding.encode(proveedorCode, forKey: .codigo)
    try? codingKeys.encode(profile, forKey: .profile)
    try codingKeys.encode(rating, forKey: .rating)
    try? codingKeys.encode(serieSeason, forKey: .serieSeason)
    try? codingKeys.encode(serie, forKey: .serie)
    try? codingKeys.encode(episode, forKey: .episode)
  }
}
