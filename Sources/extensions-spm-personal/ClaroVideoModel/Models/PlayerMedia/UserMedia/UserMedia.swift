//
//  UserMedia.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/9/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

@objc(UserMedia)
public final class UserMedia: NSObject, NSCoding {
  
  public var lasttouch: String?
  public var parentalRating: Parental?
  public var firstView: FirstTime
  // MARK: - Instance Methodsb
  public override init() {
    self.lasttouch = nil
    self.parentalRating = nil
    self.firstView = FirstTime()
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
        
    coder.encode(parentalRating, forKey: coding.parentalRating.rawValue)
    coder.encode(firstView, forKey: coding.firstView.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let parentalDecode = coder.decodeObject(forKey: coding.parentalRating.rawValue) as? Parental
    let firstViewDecode = coder.decodeObject(forKey: coding.firstView.rawValue) as? FirstTime
    self.init()
    self.parentalRating = parentalDecode
    self.firstView = firstViewDecode ?? FirstTime()
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let lastt = try? container.decode(String.self, forKey: .lasttouch) {
      lasttouch = lastt
    }
    if let parent = try? container.decode(Parental.self, forKey: .parentalRating) {
      parentalRating = parent
    }
    if let first = try container.decodeIfPresent(FirstTime.self, forKey: .firstView) {
      firstView = first
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(lasttouch, forKey: .lasttouch)
    try codingKeys.encode(parentalRating, forKey: .parentalRating)
    try codingKeys.encode(firstView, forKey: .firstView)
  }
  
}
