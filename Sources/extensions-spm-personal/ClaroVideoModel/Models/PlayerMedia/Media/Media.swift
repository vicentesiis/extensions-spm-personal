//
//  Media.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/9/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

@objc(Media)
public final class Media: NSObject, NSCoding {
  
  public var videoUrl: URL?
  public var certificateURL: String?
  public var serverUrl: String?
  public var challenge: String?
  public var challengeDictionary: [String: Any]?
  public var analyticsUrl: URL?
  public var initialPlaybackSecond: NSNumber?
  public var duration: CVDuration?
  public var audios: [MediaSelectionOption]
  public var subtitles: [MediaSelectionOption]
  
  // MARK: - Instance Methods
  public override init() {
    self.videoUrl = nil
    self.certificateURL = nil
    self.serverUrl = nil
    self.challenge = nil
    self.challengeDictionary = nil
    self.analyticsUrl = nil
    self.initialPlaybackSecond = -1
    self.duration = nil
    self.audios = []
    self.subtitles = []
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(videoUrl, forKey: coding.videoUrl.rawValue)
    coder.encode(certificateURL, forKey: coding.certificateURL.rawValue)
    coder.encode(serverUrl, forKey: coding.serverUrl.rawValue)
    coder.encode(challenge, forKey: coding.challenge.rawValue)
    coder.encode(challengeDictionary, forKey: "challengeDictionary")
    coder.encode(duration, forKey: coding.duration.rawValue)
    
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let durationDecode = coder.decodeObject(forKey: coding.duration.rawValue) as? CVDuration
    let certificateURLDecode = coder.decodeObject(forKey: coding.certificateURL.rawValue) as? String
    let serverURLDecode = coder.decodeObject(forKey: coding.serverUrl.rawValue) as? String
    let challageDecode = coder.decodeObject(forKey: coding.challenge.rawValue) as? String
    var challageDic:[String: Any]? = [:]
    if let challageStr = challageDecode {
       challageDic = ParserHelper.parse(data: challageStr)
    }
    self.init()
    self.duration = durationDecode
    self.certificateURL = certificateURLDecode
    self.serverUrl = serverURLDecode
    self.challenge = challageDecode
    self.challengeDictionary = challageDic
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let vidUrl = try? container.decode(URL.self, forKey: .videoUrl) {
      videoUrl = vidUrl
    }
    if let certUrl = try? container.decode(String.self, forKey: .certificateURL) {
      certificateURL = certUrl
    }
    if let servUrl = try? container.decode(String.self, forKey: .serverUrl) {
      serverUrl = servUrl
    }
    if let challengeStr = try? container.decode(String.self, forKey: .challenge), !challengeStr.isEmpty {
      challenge = challengeStr
      challengeDictionary = ParserHelper.parse(data: challengeStr)
    }
    if let analUrl = try? container.decode(URL.self, forKey: .analyticsUrl) {
      analyticsUrl = analUrl
    }
    if let initialPlay = try container.decodeIfPresent(Int.self, forKey: .initialPlaybackSecond) {
      initialPlaybackSecond = initialPlay as NSNumber
    }
    if let dur = try? container.decode(CVDuration.self, forKey: .duration) {
      duration = dur
    }
    
    //Getting Audios
    if let audiosContainer = try? container.nestedContainer(keyedBy: AudioSubtitlesCodingKeys.self, forKey: .audios),
      let audiosObject = try? audiosContainer.decode([String: Any].self, forKey: .options) {
      audios = MediaSelectionOption.getAudios(responseObject: audiosObject)
    }
    //Getting Subtitles
    if let subtitlesContainer = try? container.nestedContainer(keyedBy: AudioSubtitlesCodingKeys.self, forKey: .subtitles),
      let subtitlesObject = try? subtitlesContainer.decode([String: Any].self, forKey: .options) {
      subtitles = MediaSelectionOption.getSubtitles(responseObject: subtitlesObject)
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(videoUrl, forKey: .videoUrl)
    try codingKeys.encode(certificateURL, forKey: .certificateURL)
    try codingKeys.encode(serverUrl, forKey: .serverUrl)
    try codingKeys.encode(challenge, forKey: .challenge)
    try codingKeys.encode(analyticsUrl, forKey: .analyticsUrl)
    try codingKeys.encode(Int(truncating:self.initialPlaybackSecond ?? -1), forKey: .initialPlaybackSecond)
    try codingKeys.encode(duration, forKey: .duration)
    
    var subtitleKey = codingKeys.nestedContainer(keyedBy: AudioSubtitlesCodingKeys.self, forKey: .subtitles)
    try subtitleKey.encode(subtitles, forKey: .options)
    var audioKey = codingKeys.nestedContainer(keyedBy: AudioSubtitlesCodingKeys.self, forKey: .audios)
    try audioKey.encode(audios, forKey: .options)
  }
  
  public func meterialId() -> String? {
    let json = (self.challenge ?? "")
    if let dic = json.toDictionary(), let meterialId = dic["material_id"] as? String {
      return meterialId
    }
    return nil
  }
}
