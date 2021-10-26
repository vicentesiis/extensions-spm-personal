//
//  PlayerMedia.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/10/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

@objc(PlayerMedia)
public final class PlayerMedia: NSObject, NSCoding {
  
  public var media: Media?
  public var userMedia: UserMedia?
  public var tracking: Tracklist?
  public var group: Group?
  public var nextGroup: Group?
  public var purchase: PurchaseMedia?
  public var languageOptions: [OptionLanguage]
  public var nextGroupId: String?
  public var isTrailer: String?
  public var contentId: String?
  public var streamType: String?
  public var offerId: String?
  public var purchaseId: String?
  public var serverIp: String?
  public var requestURL: String?
  public var responseJSON: [String: Any]?
  public var httpHeaders: [String: Any]?
  public var token: String?
  public var certificateURL: String?
  
  
  // MARK: - Instance Methods
  public override init() {
    self.media = nil
    self.userMedia = nil
    self.tracking = nil
    self.group = nil
    self.nextGroup = nil
    self.purchase = nil
    self.languageOptions = []
    self.nextGroupId = nil
    self.isTrailer = nil
    self.contentId = nil
    self.streamType = nil
    self.offerId = nil
    self.purchaseId = nil
    self.serverIp = nil
    self.requestURL = nil
    self.responseJSON = nil
    self.httpHeaders = nil
    self.token = nil
    self.certificateURL = nil
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(media, forKey: coding.media.rawValue)
    coder.encode(userMedia, forKey: coding.userMedia.rawValue)
    coder.encode(tracking, forKey: coding.tracking.rawValue)
    coder.encode(group, forKey: coding.group.rawValue)
    coder.encode(nextGroup, forKey: coding.nextGroup.rawValue)
    coder.encode(purchase, forKey: "newPurchase")
    coder.encode(nextGroupId, forKey: coding.nextGroupId.rawValue)
    coder.encode(isTrailer, forKey: coding.isTrailer.rawValue)
    coder.encode(contentId, forKey: coding.contentId.rawValue)
    coder.encode(streamType, forKey: coding.streamType.rawValue)
    coder.encode(offerId, forKey: coding.offerId.rawValue)
    coder.encode(purchaseId, forKey: coding.purchaseId.rawValue)
    coder.encode(serverIp, forKey: coding.serverIp.rawValue)
    coder.encode(requestURL, forKey: coding.requestURL.rawValue)
    coder.encode(responseJSON, forKey: coding.responseJSON.rawValue)
    coder.encode(httpHeaders, forKey: coding.httpHeaders.rawValue)
    coder.encode(token, forKey: coding.token.rawValue)
    coder.encode(certificateURL, forKey: coding.certificateURL.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let mediaDecode = coder.decodeObject(forKey: coding.media.rawValue) as? Media
    let userMediaDecode = coder.decodeObject(forKey: coding.userMedia.rawValue) as? UserMedia
    let trackDecode = coder.decodeObject(forKey: coding.tracking.rawValue) as? Tracklist
    let groupDecode = coder.decodeObject(forKey: coding.group.rawValue) as? Group
    let nextGroupDecode = coder.decodeObject(forKey: coding.nextGroup.rawValue) as? Group
    let purchaseDecode = coder.decodeObject(forKey: "newPurchase") as? PurchaseMedia
    let nextGroupIdDecode = coder.decodeObject(forKey: coding.nextGroupId.rawValue) as? String
    let isTrailerecode = coder.decodeObject(forKey: coding.isTrailer.rawValue) as? String
    let contentIdDecode = coder.decodeObject(forKey: coding.contentId.rawValue) as? String
    let streamTypeDecode = coder.decodeObject(forKey: coding.streamType.rawValue) as? String
    let offerIdDecode = coder.decodeObject(forKey: coding.offerId.rawValue) as? String
    let purchaseIdDecode = coder.decodeObject(forKey: coding.purchaseId.rawValue) as? String
    let serverIpDecode = coder.decodeObject(forKey: coding.serverIp.rawValue) as? String
    let requestURLDecode = coder.decodeObject(forKey: coding.requestURL.rawValue) as? String
    let responseJSONDecode = coder.decodeObject(forKey: coding.responseJSON.rawValue) as? [String: Any]
    let httpHeadersDecode = coder.decodeObject(forKey: coding.httpHeaders.rawValue) as? [String: Any]
    let tokenDecode = coder.decodeObject(forKey: coding.token.rawValue) as? String
    let certificateURLDecode = coder.decodeObject(forKey: coding.certificateURL.rawValue) as? String
    self.init()
    self.media = mediaDecode
    self.userMedia = userMediaDecode
    self.tracking = trackDecode
    self.group = groupDecode
    self.nextGroup = nextGroupDecode
    self.purchase = purchaseDecode
    self.nextGroupId = nextGroupIdDecode
    self.isTrailer = isTrailerecode
    self.contentId = contentIdDecode
    self.streamType = streamTypeDecode
    self.offerId = offerIdDecode
    self.purchaseId = purchaseIdDecode
    self.serverIp = serverIpDecode
    self.requestURL = requestURLDecode
    self.responseJSON = responseJSONDecode
    self.httpHeaders = httpHeadersDecode
    self.token = tokenDecode
    self.certificateURL = certificateURLDecode
    
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let groupContainer = try? container.nestedContainer(keyedBy: GroupCodingKeys.self, forKey: .group) {
      group = try groupContainer.decodeIfPresent(Group.self, forKey: .common) ?? Group()
    }
    if let languagesContainer = try? container.nestedContainer(keyedBy: LanguageCodingKeys.self, forKey: .language) {
      if let option = try? languagesContainer.decode([OptionLanguage].self, forKey: .options) {
        languageOptions = option
      }
    }
    if let med = try? container.decode(Media.self, forKey: .media) {
      media = med
    }
    if let userMed = try container.decodeIfPresent(UserMedia.self, forKey: .userMedia) {
      userMedia = userMed
    }
    if let track = try container.decodeIfPresent(Tracklist.self, forKey: .tracking) {
      tracking = track
    }
    //Next Group
    if let purch = try container.decodeIfPresent(PurchaseMedia.self, forKey: .purchase) {
      purchase = purch
    }
    if let nextGroid = try container.decodeIfPresent(String.self, forKey: .nextGroupId) {
      nextGroupId = nextGroid
    }
    if let isTra = try container.decodeIfPresent(String.self, forKey: .isTrailer) {
      isTrailer = isTra
    }
    if let contId = try container.decodeIfPresent(String.self, forKey: .contentId) {
      contentId = contId
    }
    if let strType = try container.decodeIfPresent(String.self, forKey: .streamType) {
      streamType = strType
    }
    if let servIp = try container.decodeIfPresent(String.self, forKey: .serverIp) {
      serverIp = servIp
    }
    if let requUrl = try container.decodeIfPresent(String.self, forKey: .requestURL) {
      requestURL = requUrl
    }
    if let respJson = try container.decodeIfPresent([String: Any].self, forKey: .responseJSON) {
      responseJSON = respJson
    }
    if let httpHead = try container.decodeIfPresent([String: Any].self, forKey: .httpHeaders) {
      httpHeaders = httpHead
    }
    if let nextGroupContainer = try? container.nestedContainer(keyedBy: GroupCodingKeys.self, forKey: .nextGroup) {
      nextGroup = try nextGroupContainer.decodeIfPresent(Group.self, forKey: .common)
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(media, forKey: .media)
    try codingKeys.encode(userMedia, forKey: .userMedia)
    try codingKeys.encode(tracking, forKey: .tracking)
    try codingKeys.encode(nextGroup, forKey: .nextGroup)
    try codingKeys.encode(purchase, forKey: .purchase)
    try codingKeys.encode(nextGroupId, forKey: .nextGroupId)
    try codingKeys.encode(isTrailer, forKey: .isTrailer)
    try codingKeys.encode(contentId, forKey: .contentId)
    try codingKeys.encode(streamType, forKey: .streamType)
    try codingKeys.encode(serverIp, forKey: .serverIp)
    try codingKeys.encode(requestURL, forKey: .requestURL)
    
    
    if let purchId = self.purchaseId {
      try codingKeys.encode(purchId, forKey: .purchaseId)
    }
    if let offer = self.offerId {
      try codingKeys.encode(offer, forKey: .offerId)
    }
    if let tok = self.token {
      try codingKeys.encode(tok, forKey: .token)
    }
    if let certURL = certificateURL {
      try codingKeys.encode(certURL, forKey: .certificateURL)
    }
    
    var groupKeys = codingKeys.nestedContainer(keyedBy: GroupCodingKeys.self, forKey: .group)
    try groupKeys.encode(group, forKey: .common)
    
    var languageKey = codingKeys.nestedContainer(keyedBy: LanguageCodingKeys.self, forKey: .language)
    try languageKey.encode(languageOptions, forKey: .options)
  }
  
  public class func deserialize(json: Any) -> PlayerMedia? {
    return ParserHelper.parseSimpleObject(of: PlayerMedia.self, data: json)
  }
}
