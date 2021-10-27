//
//  ExternalData.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/29/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class ExternalData: NSObject, NSCoding  {
  
  public var id: String
  public var providerId: String
  public var providerCode: String
  public var title: String
  public var externalDescription: String
  public var duration: String
  public var publishyear: String
  public var officialUrl: String
  public var rating: String
  public var cast: [Params]
  public var genres: [String]
  
  
  public override init() {
    self.id = ""
    self.providerId = ""
    self.providerCode = ""
    self.title = ""
    self.externalDescription = ""
    self.duration = ""
    self.publishyear = ""
    self.officialUrl = ""
    self.rating = ""
    self.cast = []
    self.genres = []
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(id, forKey: coding.id.rawValue)
    coder.encode(providerId, forKey: coding.providerId.rawValue)
    coder.encode(providerCode, forKey: coding.providerCode.rawValue)
    coder.encode(title, forKey: coding.title.rawValue)
    coder.encode(externalDescription, forKey: coding.externalDescription.rawValue)
    coder.encode(duration, forKey: coding.duration.rawValue)
    coder.encode(publishyear, forKey: coding.publishyear.rawValue)
    coder.encode(officialUrl, forKey: coding.officialUrl.rawValue)
    coder.encode(rating, forKey: coding.rating.rawValue)
    coder.encode(cast, forKey: coding.cast.rawValue)
    coder.encode(genres, forKey: coding.genres.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let idDecode = coder.decodeObject(forKey: coding.id.rawValue) as? String
    let providerIdDecode = coder.decodeObject(forKey: coding.providerId.rawValue) as? String
    let providerCodeDecode = coder.decodeObject(forKey: coding.providerCode.rawValue) as? String
    let titleDecode = coder.decodeObject(forKey: coding.title.rawValue) as? String
    let externalDescriptionDecode = coder.decodeObject(forKey: coding.externalDescription.rawValue) as? String
    let durationDecode = coder.decodeObject(forKey: coding.duration.rawValue) as? String
    let publishyearDecode = coder.decodeObject(forKey: coding.publishyear.rawValue) as? String
    let officialUrlDecode = coder.decodeObject(forKey: coding.officialUrl.rawValue) as? String
    let ratingDecode = coder.decodeObject(forKey: coding.rating.rawValue) as? String
    let castDecode = coder.decodeObject(forKey: coding.cast.rawValue) as? [Params]
    let genresDecode = coder.decodeObject(forKey: coding.genres.rawValue) as? [String]
    self.init()
    self.id = idDecode ?? ""
    self.providerId = providerIdDecode ?? ""
    self.providerCode = providerCodeDecode ?? ""
    self.title = titleDecode ?? ""
    self.externalDescription = externalDescriptionDecode ?? ""
    self.duration = durationDecode ?? ""
    self.publishyear = publishyearDecode ?? ""
    self.officialUrl = officialUrlDecode ?? ""
    self.rating = ratingDecode ?? ""
    self.cast = castDecode ?? []
    self.genres = genresDecode ?? []
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
    providerId = try container.decodeIfPresent(String.self, forKey: .providerId) ?? ""
    providerCode = try container.decodeIfPresent(String.self, forKey: .providerCode) ?? ""
    title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
    externalDescription = try container.decodeIfPresent(String.self, forKey: .externalDescription) ?? ""
    duration = try container.decodeIfPresent(String.self, forKey: .duration) ?? ""
    publishyear = try container.decodeIfPresent(String.self, forKey: .publishyear) ?? ""
    officialUrl = try container.decodeIfPresent(String.self, forKey: .officialUrl) ?? ""
    rating = try container.decodeIfPresent(String.self, forKey: .rating) ?? ""
    genres = try container.decodeIfPresent([String].self, forKey: .genres) ?? []
    cast = try container.decodeIfPresent([Params].self, forKey: .cast) ?? []
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(id, forKey: .id)
    try codingKeys.encode(providerId, forKey: .providerId)
    try codingKeys.encode(providerCode, forKey: .providerCode)
    try codingKeys.encode(title, forKey: .title)
    try codingKeys.encode(externalDescription, forKey: .externalDescription)
    try codingKeys.encode(duration, forKey: .duration)
    try codingKeys.encode(publishyear, forKey: .publishyear)
    try codingKeys.encode(officialUrl, forKey: .officialUrl)
    try codingKeys.encode(rating, forKey: .rating)
    try codingKeys.encode(cast, forKey: .cast)
    try codingKeys.encode(genres, forKey: .genres)
  }
}
