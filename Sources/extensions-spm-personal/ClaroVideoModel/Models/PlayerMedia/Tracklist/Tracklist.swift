//
//  Tracklist.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/10/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

@objc(Tracklist)
public final class Tracklist: NSObject, NSCoding {
  
  public var additionalTrackingParameters: [String: Any]
  public var tickInterval: Int
  public var retries: Int
  public var tickURL: String
  public var errorURL: String
  public var viewURL: String
  public var stopURL: String
  public var timecodeURL: String
  public var completionURL: String
  public var intervalURL: String
  public var dubsubchangeURL: String
  public var qualitychangeURL: String
  public var episodechangeURL: String
  public var seekURL: String
  public var pauseURL: String
  public var resumeURL: String
  public var downloadURL: String
  public var creditsURL: String
  public var trackSuccess: MusicTracking?
  
  // MARK: - Instance Methods
  public override init() {
    self.additionalTrackingParameters = [:]
    self.tickInterval = -1
    self.retries = -1
    self.tickURL = ""
    self.errorURL = ""
    self.viewURL = ""
    self.stopURL = ""
    self.timecodeURL = ""
    self.completionURL = ""
    self.intervalURL = ""
    self.dubsubchangeURL = ""
    self.qualitychangeURL = ""
    self.episodechangeURL = ""
    self.seekURL = ""
    self.pauseURL = ""
    self.resumeURL = ""
    self.downloadURL = ""
    self.creditsURL = ""
    self.trackSuccess = nil
  }
  
  public func encode(with coder: NSCoder) {
    let codingPolicies = PoliciesCodingKeys.self
    
    coder.encode(tickInterval, forKey: codingPolicies.tickInterval.rawValue)
    coder.encode(retries, forKey: codingPolicies.retries.rawValue)
    
    let codingUrlsCoding = UrlsCodingKeys.self
    coder.encode(tickURL, forKey: codingUrlsCoding.tickURL.rawValue)
    coder.encode(errorURL, forKey: codingUrlsCoding.errorURL.rawValue)
    coder.encode(viewURL, forKey: codingUrlsCoding.viewURL.rawValue)
    coder.encode(stopURL, forKey: codingUrlsCoding.stopURL.rawValue)
    coder.encode(timecodeURL, forKey: codingUrlsCoding.timecodeURL.rawValue)
    coder.encode(completionURL, forKey: codingUrlsCoding.completionURL.rawValue)
    coder.encode(intervalURL, forKey: codingUrlsCoding.intervalURL.rawValue)
    coder.encode(dubsubchangeURL, forKey: codingUrlsCoding.dubsubchangeURL.rawValue)
    coder.encode(qualitychangeURL, forKey: codingUrlsCoding.qualitychangeURL.rawValue)
    coder.encode(episodechangeURL, forKey: codingUrlsCoding.episodechangeURL.rawValue)
    coder.encode(seekURL, forKey: codingUrlsCoding.seekURL.rawValue)
    coder.encode(pauseURL, forKey: codingUrlsCoding.pauseURL.rawValue)
    coder.encode(resumeURL, forKey: codingUrlsCoding.resumeURL.rawValue)
    coder.encode(downloadURL, forKey: codingUrlsCoding.downloadURL.rawValue)
    coder.encode(creditsURL, forKey: codingUrlsCoding.creditsURL.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let codingPolice = PoliciesCodingKeys.self
    
    let tickIntervalDecode = coder.decodeObject(forKey: codingPolice.tickInterval.rawValue) as? Int
    let retricesDecode = coder.decodeObject(forKey: codingPolice.retries.rawValue) as? Int
    
    let codingUrlsCoding = UrlsCodingKeys.self
    let downloadURLDecode = coder.decodeObject(forKey: codingUrlsCoding.downloadURL.rawValue) as? String
    self.init()
    self.tickInterval = tickIntervalDecode ?? -1
    self.retries = retricesDecode ?? -1
    self.downloadURL = downloadURLDecode ?? ""
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    if let policiesContainer = try? container.nestedContainer(keyedBy: PoliciesCodingKeys.self, forKey: .policies) {
      tickInterval = try policiesContainer.decodeIfPresent(Int.self, forKey: .tickInterval) ?? -1
      retries = try policiesContainer.decodeIfPresent(Int.self, forKey: .retries) ?? -1
    }
    if let urlsContainer = try? container.nestedContainer(keyedBy: UrlsCodingKeys.self, forKey: .urls) {
      tickURL = try urlsContainer.decodeIfPresent(String.self, forKey: .tickURL) ?? ""
      errorURL = try urlsContainer.decodeIfPresent(String.self, forKey: .errorURL) ?? ""
      viewURL = try urlsContainer.decodeIfPresent(String.self, forKey: .viewURL) ?? ""
      stopURL = try urlsContainer.decodeIfPresent(String.self, forKey: .stopURL) ?? ""
      timecodeURL = try urlsContainer.decodeIfPresent(String.self, forKey: .timecodeURL) ?? ""
      completionURL = try urlsContainer.decodeIfPresent(String.self, forKey: .completionURL) ?? ""
      intervalURL = try urlsContainer.decodeIfPresent(String.self, forKey: .intervalURL) ?? ""
      dubsubchangeURL = try urlsContainer.decodeIfPresent(String.self, forKey: .dubsubchangeURL) ?? ""
      qualitychangeURL = try urlsContainer.decodeIfPresent(String.self, forKey: .qualitychangeURL) ?? ""
      episodechangeURL = try urlsContainer.decodeIfPresent(String.self, forKey: .episodechangeURL) ?? ""
      seekURL = try urlsContainer.decodeIfPresent(String.self, forKey: .seekURL) ?? ""
      pauseURL = try urlsContainer.decodeIfPresent(String.self, forKey: .pauseURL) ?? ""
      resumeURL = try urlsContainer.decodeIfPresent(String.self, forKey: .resumeURL) ?? ""
      downloadURL = try urlsContainer.decodeIfPresent(String.self, forKey: .downloadURL) ?? ""
      creditsURL = try urlsContainer.decodeIfPresent(String.self, forKey: .creditsURL) ?? ""
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    var policiesContainer = codingKeys.nestedContainer(keyedBy: PoliciesCodingKeys.self, forKey: .policies)
    try policiesContainer.encode(tickInterval, forKey: .tickInterval)
    try policiesContainer.encode(retries, forKey: .retries)
        
    var urlsContainer = codingKeys.nestedContainer(keyedBy: UrlsCodingKeys.self, forKey: .urls)
    try urlsContainer.encode(tickURL, forKey: .tickURL)
    try urlsContainer.encode(errorURL, forKey: .errorURL)
    try urlsContainer.encode(viewURL, forKey: .viewURL)
    try urlsContainer.encode(stopURL, forKey: .stopURL)
    try urlsContainer.encode(timecodeURL, forKey: .timecodeURL)
    try urlsContainer.encode(completionURL, forKey: .completionURL)
    try urlsContainer.encode(intervalURL, forKey: .intervalURL)
    try urlsContainer.encode(dubsubchangeURL, forKey: .dubsubchangeURL)
    try urlsContainer.encode(qualitychangeURL, forKey: .qualitychangeURL)
    try urlsContainer.encode(episodechangeURL, forKey: .episodechangeURL)
    try urlsContainer.encode(seekURL, forKey: .seekURL)
    try urlsContainer.encode(pauseURL, forKey: .pauseURL)
    try urlsContainer.encode(resumeURL, forKey: .resumeURL)
    try urlsContainer.encode(creditsURL, forKey: .creditsURL)
  }
}
