//
//  Group.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/1/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation


final public class Group: NSObject, NSCoding {
  
  /* There are two APIs that set the title property:
   *
   *  -> content/list
   *  -> content/data
   *
   * For content/list:
   *  -> a movie title is: "Spiderman"
   *  -> a serie title is: "Breaking Bad"
   *
   * For content/data:
   *  -> a movie title is: "Spiderman"
   *  -> a serie title is: "Breaking Bad - T01-Ep01" (that is because content/data returns a especific episode)
   *
   * If you want to get the name of the content (Spiderman or Breaking Bad), use "titleName" property
   */
  public var title: String
  
  /* Title of the first episode of a serie
   
   * For a movie the value is: null
   * For a serie the value is: "Breaking Bad - T01-Ep01"
   */
  public var titleEpisode: String
  
  /* Original title of the movie or serie
   
   * Example for México: Solo en casa: Original: Home Alone
   */
  public var titleOriginal: String
  
  /* Name of the title for a movie or a serie
   
   * For a movie the value is: "Spiderman"
   * For a serie the value is: "Breaking Bad"
   */
  public var titleName: String
    
  public var titleUri: String
  // MARK:- Content/Data
  public var imageLargeAlt: String
  public var imageMediumAlt: String
  public var imageSmallAlt: String
  public var imageSpritesURL: String
  public var largeDescription: String
  public var mediaType: String
  public var objState: String
  public var objStateDesc: String
  public var objTypeId: String
  public var position: String
  public var smallDescription: String
  public var state: String
  // MARK:- Content/List
  public var crest: String
  public var date: String
  public var descriptionLarge: String
  public var duration: String
  public var episodeNumber: String
  public var group_description: String // Should the be cammel case?
  public var group_id: String  // Should the be cammel case?
  public var formatTypes: String
  // MARK:- EPG/Channel
  public var imageBaseHorizontal: String
  public var imageBaseVertical: String
  /**
   * NOTE!: There are two properties with the name 'proveedorName'
   *
   *  This is set in content/data
   *  group.extended.media.proveedorName
   *
   *  This is set in content/list
   *  group.proveedorName;
   *
   * USE!: [group provider]
   */
  public var proveedorCode: String
  public var imageBackground: String
  public var imageHighlight: String
  public var appBehaviour: String
  public var imageLarge: String
  public var imageMedium: String
  public var imageSmall: String
  public var item_id: String
  public var liveEnabled: String
  public var liveRef: String
  public var liveType: String
  public var preview: String
  public var seasonNumber: String
  public var section: String
  public var special: String
  public var url: String
  public var volant: String
  public var votesAverage: Float
  public var year: String
  public var ratingCode: String
  public var isMusicContent: Int
  public var imageStill: String
  public var urlImageT1: String
  public var urlImageT2: String
  public var imageBaseSquare: String
  public var imageCleanHorizontal: String
  public var imageCleanVertical: String
  public var imageCleanSquare: String
  public var imageFrames: String
  public var channelNumber: String
  public var timeShift: String
  public var proveedorName: String
  public var encoderTechnology: EncoderTechnology?
  public var recorderTechnology: EncoderTechnology?
  public var resourceName: String
  public var isSeries: Bool
  public var vistime: Vistime?
  public var ranking: Ranking?
  public var extended: ExtendedGroup?
  public var externalData: ExternalData?
  public var type: String
  //MARK:- Properties just for tvOS Images
  #if os(tvOS)
  public var statusVerified: Bool = false
  public var cacheElement: Any? = nil
  #endif
  
  public var paywayToken: String?
  public var subscriptionType: String?
  public var gatewayPurchased: String?
  public var purchaseId: String?
  public var offerId: String?
  public var resumeTime: Int = 0
  public var oneOfferType: String?
  public var isPurchased: Bool = false
  public var wasPurchased: Bool = false
  public var startdate: String?
  public var fromRibbon: String?
  public var listButtons: [PurchaseButton]? = []
  public var offerDescription: String?
  public var offerPrice: String?
  public var canPlay: Bool = false
  public var startTime: Date?
  public var endTime: Date?
  public var module: Module?
   
  
  // MARK: - Instance Methods
  public override init() {
    self.title = ""
    self.titleEpisode = ""
    self.titleOriginal = ""
    self.titleName = ""
    self.titleUri = ""
    self.imageLargeAlt = ""
    self.imageMediumAlt = ""
    self.imageSmallAlt = ""
    self.imageSpritesURL = ""
    self.largeDescription = ""
    self.mediaType = ""
    self.objState = ""
    self.objStateDesc = ""
    self.objTypeId = ""
    self.position = ""
    self.smallDescription = ""
    self.state = ""
    self.crest = ""
    self.date = ""
    self.descriptionLarge = ""
    self.duration = ""
    self.episodeNumber = ""
    self.group_description = ""
    self.group_id = ""
    self.formatTypes = ""
    self.imageBaseHorizontal = ""
    self.imageBaseVertical = ""
    self.proveedorCode = ""
    self.imageBackground = ""
    self.imageHighlight = ""
    self.appBehaviour = ""
    self.imageLarge = ""
    self.imageMedium = ""
    self.imageSmall = ""
    self.item_id = ""
    self.liveEnabled = ""
    self.liveRef = ""
    self.liveType = ""
    self.preview = ""
    self.seasonNumber = ""
    self.section = ""
    self.special = ""
    self.url = ""
    self.volant = ""
    self.votesAverage = 0.0
    self.year = ""
    self.ratingCode = ""
    self.isMusicContent = 0
    
    self.imageStill = ""
    self.urlImageT1 = ""
    self.urlImageT2 = ""
    self.imageBaseSquare = ""
    self.imageCleanHorizontal = ""
    self.imageCleanVertical = ""
    self.imageCleanSquare = ""
    self.imageFrames = ""
    self.channelNumber = ""
    self.timeShift = ""
    self.proveedorName = ""
    self.encoderTechnology = nil
    self.recorderTechnology = nil
    self.resourceName = ""
    self.isSeries = false
    self.vistime = nil
    self.ranking = nil
    self.extended = nil
    self.type = ""
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(title, forKey: coding.title.rawValue)
    coder.encode(titleEpisode, forKey: coding.titleEpisode.rawValue)
    coder.encode(titleOriginal, forKey: coding.titleOriginal.rawValue)
    coder.encode(titleUri, forKey: coding.titleUri.rawValue)
    coder.encode(imageSpritesURL, forKey: coding.imageSpritesURL.rawValue)
    coder.encode(largeDescription, forKey: coding.largeDescription.rawValue)
    coder.encode(crest, forKey: coding.crest.rawValue)
    coder.encode(date, forKey: coding.date.rawValue)
    coder.encode(descriptionLarge, forKey: coding.descriptionLarge.rawValue)
    coder.encode(duration, forKey: coding.duration.rawValue)
    coder.encode(episodeNumber, forKey: coding.episodeNumber.rawValue)
    coder.encode(group_description, forKey: coding.group_description.rawValue)
    coder.encode(group_id, forKey: coding.group_id.rawValue)
    coder.encode(formatTypes, forKey: coding.formatTypes.rawValue)
    coder.encode(imageBaseHorizontal, forKey: coding.imageBaseHorizontal.rawValue)
    coder.encode(imageBaseVertical, forKey: coding.imageBaseVertical.rawValue)
    coder.encode(proveedorCode, forKey: coding.proveedorCode.rawValue)
    coder.encode(imageBackground, forKey: coding.imageBackground.rawValue)
    coder.encode(imageHighlight, forKey: coding.imageHighlight.rawValue)
    coder.encode(appBehaviour, forKey: coding.appBehaviour.rawValue)
    coder.encode(imageLarge, forKey: coding.imageLarge.rawValue)
    coder.encode(imageMedium, forKey: coding.imageMedium.rawValue)
    coder.encode(imageSmall, forKey: coding.imageSmall.rawValue)
    coder.encode(item_id, forKey: coding.item_id.rawValue)
    coder.encode(liveEnabled, forKey: coding.liveEnabled.rawValue)
    coder.encode(liveRef, forKey: coding.liveRef.rawValue)
    coder.encode(liveType, forKey: coding.liveType.rawValue)
    coder.encode(preview, forKey: coding.preview.rawValue)
    coder.encode(seasonNumber, forKey: coding.seasonNumber.rawValue)
    coder.encode(section, forKey: coding.section.rawValue)
    coder.encode(special, forKey: coding.special.rawValue)
    coder.encode(url, forKey: coding.url.rawValue)
    coder.encode(volant, forKey: coding.volant.rawValue)
    coder.encode(votesAverage, forKey: coding.votesAverage.rawValue)
    coder.encode(year, forKey: coding.year.rawValue)
    coder.encode(ratingCode, forKey: coding.ratingCode.rawValue)
    coder.encode(imageStill, forKey: coding.imageStill.rawValue)
    coder.encode(urlImageT1, forKey: coding.urlImageT1.rawValue)
    coder.encode(urlImageT2, forKey: coding.urlImageT2.rawValue)
    coder.encode(imageBaseSquare, forKey: coding.imageBaseSquare.rawValue)
    coder.encode(imageCleanHorizontal, forKey: coding.imageCleanHorizontal.rawValue)
    coder.encode(imageCleanVertical, forKey: coding.imageCleanVertical.rawValue)
    coder.encode(imageCleanSquare, forKey: coding.imageCleanSquare.rawValue)
    coder.encode(imageFrames, forKey: coding.imageFrames.rawValue)
    coder.encode(channelNumber, forKey: coding.channelNumber.rawValue)
    coder.encode(timeShift, forKey: coding.timeShift.rawValue)
    coder.encode(proveedorName, forKey: coding.proveedorName.rawValue)
    coder.encode(encoderTechnology, forKey: coding.encoderTechnology.rawValue)
    coder.encode(recorderTechnology, forKey: coding.recorderTechnology.rawValue)
    coder.encode(resourceName, forKey: coding.resourceName.rawValue)
    coder.encode(isSeries, forKey: coding.isSeries.rawValue)
    coder.encode(vistime, forKey: coding.vistime.rawValue)
    coder.encode(ranking, forKey: coding.ranking.rawValue)
    coder.encode(extended, forKey: coding.extended.rawValue)
    coder.encode(externalData, forKey: coding.externalData.rawValue)
    coder.encode(type, forKey: coding.type.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let titleDecode = coder.decodeObject(forKey: coding.title.rawValue) as? String
    let titleEpisodeDecode = coder.decodeObject(forKey: coding.titleEpisode.rawValue) as? String
    let titleOriginalDecode = coder.decodeObject(forKey: coding.titleOriginal.rawValue) as? String
    let titleUriDecode = coder.decodeObject(forKey: coding.titleUri.rawValue) as? String
    let imageSpritesURLDecode = coder.decodeObject(forKey: coding.imageSpritesURL.rawValue) as? String
    let largeDescriptionDecode = coder.decodeObject(forKey: coding.largeDescription.rawValue) as? String
    let crestDecode = coder.decodeObject(forKey: coding.crest.rawValue) as? String
    let dateDecode = coder.decodeObject(forKey: coding.date.rawValue) as? String
    let descriptionLargeDecode = coder.decodeObject(forKey: coding.descriptionLarge.rawValue) as? String
    let durationDecode = coder.decodeObject(forKey: coding.duration.rawValue) as? String
    let episodeNumberDecode = coder.decodeObject(forKey: coding.episodeNumber.rawValue) as? String
    let groupDescriptionDecode = coder.decodeObject(forKey: coding.group_description.rawValue) as? String
    let groupIdDecode = coder.decodeObject(forKey: coding.group_id.rawValue) as? String
    let formatTypesDecode = coder.decodeObject(forKey: coding.formatTypes.rawValue) as? String
    let imageBaseHorizontalDecode = coder.decodeObject(forKey: coding.imageBaseHorizontal.rawValue) as? String
    let imageBaseVerticalDecode = coder.decodeObject(forKey: coding.imageBaseVertical.rawValue) as? String
    let proveedorCodeDecode = coder.decodeObject(forKey: coding.proveedorCode.rawValue) as? String
    let imageBackgroundDecode = coder.decodeObject(forKey: coding.imageBackground.rawValue) as? String
    let imageHighlightDecode = coder.decodeObject(forKey: coding.imageHighlight.rawValue) as? String
    let appBehaviourDecode = coder.decodeObject(forKey: coding.appBehaviour.rawValue) as? String
    let imageLargeDecode = coder.decodeObject(forKey: coding.imageLarge.rawValue) as? String
    let imageMediumDecode = coder.decodeObject(forKey: coding.imageMedium.rawValue) as? String
    let imageSmallDecode = coder.decodeObject(forKey: coding.imageSmall.rawValue) as? String
    let itemIdDecode = coder.decodeObject(forKey: coding.item_id.rawValue) as? String
    let liveEnabledDecode = coder.decodeObject(forKey: coding.liveEnabled.rawValue) as? String
    let liveRefDecode = coder.decodeObject(forKey: coding.liveRef.rawValue) as? String
    let liveTypeDecode = coder.decodeObject(forKey: coding.liveType.rawValue) as? String
    let previewDecode = coder.decodeObject(forKey: coding.preview.rawValue) as? String
    let seasonNumberDecode = coder.decodeObject(forKey: coding.seasonNumber.rawValue) as? String
    let sectionDecode = coder.decodeObject(forKey: coding.section.rawValue) as? String
    let specialDecode = coder.decodeObject(forKey: coding.special.rawValue) as? String
    let urlDecode = coder.decodeObject(forKey: coding.url.rawValue) as? String
    let volantDecode = coder.decodeObject(forKey: coding.volant.rawValue) as? String
    let votesAverageDecode = coder.decodeObject(forKey: coding.votesAverage.rawValue) as? Float
    let yearDecode = coder.decodeObject(forKey: coding.year.rawValue) as? String
    let ratingCodeDecode = coder.decodeObject(forKey: coding.ratingCode.rawValue) as? String
    let imageStillDecode = coder.decodeObject(forKey: coding.imageStill.rawValue) as? String
    let urlImageT1Decode = coder.decodeObject(forKey: coding.urlImageT1.rawValue) as? String
    let urlImageT2Decode = coder.decodeObject(forKey: coding.urlImageT2.rawValue) as? String
    let imageBaseSquareDecode = coder.decodeObject(forKey: coding.imageBaseSquare.rawValue) as? String
    let imageCleanHorizontalDecode = coder.decodeObject(forKey: coding.imageCleanHorizontal.rawValue) as? String
    let imageCleanVerticalDecode = coder.decodeObject(forKey: coding.imageCleanVertical.rawValue) as? String
    let imageCleanSquareDecode = coder.decodeObject(forKey: coding.imageCleanSquare.rawValue) as? String
    let imageFramesDecode = coder.decodeObject(forKey: coding.imageFrames.rawValue) as? String
    let channelNumberDecode = coder.decodeObject(forKey: coding.channelNumber.rawValue) as? String
    let timeShiftDecode = coder.decodeObject(forKey: coding.timeShift.rawValue) as? String
    let proveedorNameDecode = coder.decodeObject(forKey: coding.proveedorName.rawValue) as? String
    let encoderTechnologyDecode = coder.decodeObject(forKey: coding.encoderTechnology.rawValue) as? EncoderTechnology
    let recorderTechnologyDecode = coder.decodeObject(forKey: coding.recorderTechnology.rawValue) as? EncoderTechnology
    let isSeriesDecode = coder.decodeObject(forKey: coding.isSeries.rawValue) as? Bool
    let vistimeDecode = coder.decodeObject(forKey: coding.vistime.rawValue) as? Vistime
    let rankingDecode = coder.decodeObject(forKey: coding.ranking.rawValue) as? Ranking
    let extendedDecode = coder.decodeObject(forKey: coding.extended.rawValue) as? ExtendedGroup
    let externalDataDecode = coder.decodeObject(forKey: coding.externalData.rawValue) as? ExternalData
    let type = coder.decodeObject(forKey: coding.type.rawValue) as? String
    
    self.init()
    self.title = titleDecode ?? ""
    self.titleEpisode = titleEpisodeDecode ?? ""
    self.titleOriginal = titleOriginalDecode ?? ""
    self.titleUri = titleUriDecode ?? ""
    self.imageSpritesURL = imageSpritesURLDecode ?? ""
    self.largeDescription = largeDescriptionDecode ?? ""
    self.crest = crestDecode ?? ""
    self.date = dateDecode ?? ""
    self.descriptionLarge = descriptionLargeDecode ?? ""
    self.duration = durationDecode ?? ""
    self.episodeNumber = episodeNumberDecode ?? ""
    self.group_description = groupDescriptionDecode ?? ""
    self.group_id = groupIdDecode ?? ""
    self.formatTypes = formatTypesDecode ?? ""
    self.imageBaseHorizontal = imageBaseHorizontalDecode ?? ""
    self.imageBaseVertical = imageBaseVerticalDecode ?? ""
    self.proveedorCode = proveedorCodeDecode ?? ""
    self.imageBackground = imageBackgroundDecode ?? ""
    self.imageHighlight = imageHighlightDecode ?? ""
    self.appBehaviour = appBehaviourDecode ?? ""
    self.imageLarge = imageLargeDecode ?? ""
    self.imageMedium = imageMediumDecode ?? ""
    self.imageSmall = imageSmallDecode ?? ""
    self.item_id = itemIdDecode ?? ""
    self.liveEnabled = liveEnabledDecode ?? ""
    self.liveRef = liveRefDecode ?? ""
    self.liveType = liveTypeDecode ?? ""
    self.preview = previewDecode ?? ""
    self.seasonNumber = seasonNumberDecode ?? ""
    self.section = sectionDecode ?? ""
    self.special = specialDecode ?? ""
    self.url = urlDecode ?? ""
    self.volant = volantDecode ?? ""
    self.votesAverage = votesAverageDecode ?? 0.0
    self.year = yearDecode ?? ""
    self.ratingCode = ratingCodeDecode ?? ""
    self.imageStill = imageStillDecode ?? ""
    self.urlImageT1 = urlImageT1Decode ?? ""
    self.urlImageT2 = urlImageT2Decode ?? ""
    self.imageBaseSquare = imageBaseSquareDecode ?? ""
    self.imageCleanHorizontal = imageCleanHorizontalDecode ?? ""
    self.imageCleanVertical = imageCleanVerticalDecode ?? ""
    self.imageCleanSquare = imageCleanSquareDecode ?? ""
    self.imageFrames = imageFramesDecode ?? ""
    self.channelNumber = channelNumberDecode ?? ""
    self.timeShift = timeShiftDecode ?? ""
    self.proveedorName = proveedorNameDecode ?? ""
    self.encoderTechnology = encoderTechnologyDecode
    self.recorderTechnology = recorderTechnologyDecode
    self.isSeries = isSeriesDecode ?? false
    self.vistime = vistimeDecode
    self.ranking = rankingDecode
    self.extended = extendedDecode
    self.externalData = externalDataDecode
    self.type = type ?? ""
    
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
    titleEpisode = try container.decodeIfPresent(String.self, forKey: .titleEpisode) ?? ""
    titleOriginal = try container.decodeIfPresent(String.self, forKey: .titleOriginal) ?? ""
    titleUri = try container.decodeIfPresent(String.self, forKey: .titleUri) ?? ""
    imageSpritesURL = try container.decodeIfPresent(String.self, forKey: .imageSpritesURL) ?? ""
    crest = try container.decodeIfPresent(String.self, forKey: .crest) ?? ""
    date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
    descriptionLarge = try container.decodeIfPresent(String.self, forKey: .largeDescription) ?? (try container.decodeIfPresent(String.self, forKey: .descriptionLarge) ?? "")
    if let durationDecode = try? container.decode(String.self, forKey: .duration) {
      duration = durationDecode
    }
    episodeNumber = try container.decodeIfPresent(String.self, forKey: .episodeNumber) ?? ""
    group_description = try container.decodeIfPresent(String.self, forKey: .group_description) ?? ""
    group_id = try
      container.decodeIfPresent(String.self, forKey: .group_id) ??
      (container.decodeIfPresent(String.self, forKey: .id) ?? "")
    formatTypes = try container.decodeIfPresent(String.self, forKey: .formatTypes) ?? ""
    imageBaseHorizontal = try container.decodeIfPresent(String.self, forKey: .imageBaseHorizontal) ?? ""
    imageBaseVertical = try container.decodeIfPresent(String.self, forKey: .imageBaseVertical) ?? ""
    proveedorCode = try container.decodeIfPresent(String.self, forKey: .proveedorCode) ?? ""
    imageBackground = try container.decodeIfPresent(String.self, forKey: .imageBackground) ?? ""
    imageHighlight = try container.decodeIfPresent(String.self, forKey: .imageHighlight) ?? ""
    appBehaviour = try container.decodeIfPresent(String.self, forKey: .appBehaviour) ?? ""
    imageLarge = try container.decodeIfPresent(String.self, forKey: .imageLarge) ?? ""
    imageMedium = try container.decodeIfPresent(String.self, forKey: .imageMedium) ?? ""
    imageSmall = try container.decodeIfPresent(String.self, forKey: .imageSmall) ?? ""
    item_id = try container.decodeIfPresent(String.self, forKey: .item_id) ?? ""
    liveEnabled = try container.decodeIfPresent(String.self, forKey: .liveEnabled) ?? ""
    if let liveRefDecode = try? container.decode(String.self, forKey: .liveRef) {
      liveRef = liveRefDecode
    }
    
    if let liveTypeDecode = try? container.decode(String.self, forKey: .liveType) {
      liveType = liveTypeDecode
    }
    preview = try container.decodeIfPresent(String.self, forKey: .preview) ?? ""
    seasonNumber = try container.decodeIfPresent(String.self, forKey: .seasonNumber) ?? ""
    section = try container.decodeIfPresent(String.self, forKey: .section) ?? ""
    special = try container.decodeIfPresent(String.self, forKey: .special) ?? ""
    url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    volant = try container.decodeIfPresent(String.self, forKey: .volant) ?? ""
    votesAverage = try container.decodeIfPresent(Float.self, forKey: .votesAverage) ?? 0.0
    year = try container.decodeIfPresent(String.self, forKey: .year) ?? ""
    ratingCode = try container.decodeIfPresent(String.self, forKey: .ratingCode) ?? ""
    if let imageStillDecode = try? container.decode(String.self, forKey: .imageStill) {
      imageStill = imageStillDecode
    }
    urlImageT1 = try container.decodeIfPresent(String.self, forKey: .urlImageT1) ?? ""
    urlImageT2 = try container.decodeIfPresent(String.self, forKey: .urlImageT2) ?? ""
    imageBaseSquare = try container.decodeIfPresent(String.self, forKey: .imageBaseSquare) ?? ""
    imageCleanHorizontal = try container.decodeIfPresent(String.self, forKey: .imageCleanHorizontal) ?? ""
    imageCleanVertical = try container.decodeIfPresent(String.self, forKey: .imageCleanVertical) ?? ""
    imageCleanSquare = try container.decodeIfPresent(String.self, forKey: .imageCleanSquare) ?? ""
    imageFrames = try container.decodeIfPresent(String.self, forKey: .imageFrames) ?? ""
    if let channelNumberDecode = try? container.decode(String.self, forKey: .channelNumber) {
      channelNumber = channelNumberDecode
    }
    if let timeShiftDecode = try? container.decode(String.self, forKey: .timeShift) {
      timeShift = timeShiftDecode
    }
    proveedorName = try container.decodeIfPresent(String.self, forKey: .proveedorName) ?? ""
    if let encoderTechnologyDecode = try? container.decode(EncoderTechnology.self, forKey: .encoderTechnology) {
      encoderTechnology = encoderTechnologyDecode
    }
    if let recorderTechnologyDecode = try? container.decode(EncoderTechnology.self, forKey: .recorderTechnology) {
      recorderTechnology = recorderTechnologyDecode
    }
    if let resourceNameDecode = try? container.decode(String.self, forKey: .resourceName) {
      resourceName = resourceNameDecode
    }
    isSeries = try container.decodeIfPresent(Bool.self, forKey: .isSeries) ?? false
    vistime = try container.decodeIfPresent(Vistime.self, forKey: .vistime)
    ranking = try container.decodeIfPresent(Ranking.self, forKey: .ranking)
    if let extendedDecode = try? container.decode(ExtendedGroup.self, forKey: .extended) {
      extended = extendedDecode
    }
    type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(title, forKey: .title)
    try codingKeys.encode(titleEpisode, forKey: .titleEpisode)
    try codingKeys.encode(titleOriginal, forKey: .titleOriginal)
    try codingKeys.encode(titleUri, forKey: .titleUri)
    try codingKeys.encode(imageSpritesURL, forKey: .imageSpritesURL)
    try codingKeys.encode(crest, forKey: .crest)
    try codingKeys.encode(date, forKey: .date)
    try codingKeys.encode(descriptionLarge, forKey: .descriptionLarge)
    try codingKeys.encode(duration, forKey: .duration)
    try codingKeys.encode(episodeNumber, forKey: .episodeNumber)
    try codingKeys.encode(group_description, forKey: .group_description)
    try codingKeys.encode(group_id, forKey: .group_id)
    try codingKeys.encode(formatTypes, forKey: .formatTypes)
    try codingKeys.encode(imageBaseHorizontal, forKey: .imageBaseHorizontal)
    try codingKeys.encode(imageBaseVertical, forKey: .imageBaseVertical)
    try codingKeys.encode(proveedorCode, forKey: .proveedorCode)
    try codingKeys.encode(imageBackground, forKey: .imageBackground)
    try codingKeys.encode(imageHighlight, forKey: .imageHighlight)
    try codingKeys.encode(appBehaviour, forKey: .appBehaviour)
    try codingKeys.encode(imageLarge, forKey: .imageLarge)
    try codingKeys.encode(imageMedium, forKey: .imageMedium)
    try codingKeys.encode(imageSmall, forKey: .imageSmall)
    try codingKeys.encode(item_id, forKey: .item_id)
    try codingKeys.encode(liveEnabled, forKey: .liveEnabled)
    try codingKeys.encode(liveRef, forKey: .liveRef)
    try codingKeys.encode(liveType, forKey: .liveType)
    try codingKeys.encode(preview, forKey: .preview)
    try codingKeys.encode(seasonNumber, forKey: .seasonNumber)
    try codingKeys.encode(section, forKey: .section)
    try codingKeys.encode(special, forKey: .special)
    try codingKeys.encode(url, forKey: .url)
    try codingKeys.encode(volant, forKey: .volant)
    try codingKeys.encode(votesAverage, forKey: .votesAverage)
    try codingKeys.encode(year, forKey: .year)
    try codingKeys.encode(ratingCode, forKey: .ratingCode)
    try codingKeys.encode(imageStill, forKey: .imageStill)
    try codingKeys.encode(urlImageT1, forKey: .urlImageT1)
    try codingKeys.encode(urlImageT2, forKey: .urlImageT2)
    try codingKeys.encode(imageBaseSquare, forKey: .imageBaseSquare)
    try codingKeys.encode(imageCleanHorizontal, forKey: .imageCleanHorizontal)
    try codingKeys.encode(imageCleanVertical, forKey: .imageCleanVertical)
    try codingKeys.encode(imageCleanSquare, forKey: .imageCleanSquare)
    try codingKeys.encode(imageFrames, forKey: .imageFrames)
    try codingKeys.encode(channelNumber, forKey: .channelNumber)
    try codingKeys.encode(timeShift, forKey: .timeShift)
    try codingKeys.encode(proveedorName, forKey: .proveedorName)
    try codingKeys.encode(type, forKey: .type)
    if let encoderTech = self.encoderTechnology {
      try codingKeys.encode(encoderTech, forKey: .encoderTechnology)
    }
    if let recorderTech = self.recorderTechnology {
      try codingKeys.encode(recorderTech, forKey: .recorderTechnology)
    }
    try codingKeys.encode(resourceName, forKey: .resourceName)
    try codingKeys.encode(isSeries, forKey: .isSeries)
    if let vist = self.vistime {
      try codingKeys.encode(vist, forKey: .vistime)
    }
    if let rank = self.ranking {
      try codingKeys.encode(rank, forKey: .ranking)
    }
    if let exten = self.extended {
      try codingKeys.encode(exten, forKey: .extended)
    }
    if let extData = self.externalData {
      try codingKeys.encode(extData, forKey: .externalData)
    }
    #if os(iOS)
    // THIS ATTRIBUTES IS ONLY FOR IOS
    if let payway = self.paywayToken {
      try codingKeys.encode(payway, forKey: .paywayToken)
    }
    if let subscription = self.subscriptionType {
      try codingKeys.encode(subscription, forKey: .paywayToken)
    }
    if let gatewayPurch = self.gatewayPurchased {
      try codingKeys.encode(gatewayPurch, forKey: .gatewayPurchased)
    }
    if let purchaseid = self.purchaseId {
      try codingKeys.encode(purchaseid, forKey: .purchaseId)
    }
    if let offer = self.offerId {
      try? codingKeys.encode(offer, forKey: .offerId)
    }
    try codingKeys.encode(resumeTime, forKey: .resumeTime)
    if let oneOfferT = self.oneOfferType {
      try codingKeys.encode(oneOfferT, forKey: .oneOfferType)
    }
    try codingKeys.encode(isPurchased, forKey: .isPurchased)
    try codingKeys.encode(wasPurchased, forKey: .wasPurchased)
    if let startD = self.startdate {
      try codingKeys.encode(startD, forKey: .startdate)
    }
    if let fromRib = self.fromRibbon {
      try codingKeys.encode(fromRib, forKey: .fromRibbon)
    }
    if let offerDesc = self.offerDescription {
      try codingKeys.encode(offerDesc, forKey: .offerDescription)
    }
    if let offerPri = self.offerPrice {
      try codingKeys.encode(offerPri, forKey: .offerPrice)
    }
    try codingKeys.encode(canPlay, forKey: .canPlay)
    if let startT = self.startTime {
      try codingKeys.encode(startT, forKey: .startTime)
    }
    if let endT = self.endTime {
      try codingKeys.encode(endT, forKey: .endTime)
    }
    #endif
  }
}
