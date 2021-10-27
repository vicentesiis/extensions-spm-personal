//
//  Profile.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/25/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class Profile: NSObject, NSCoding {
  
  public var audiotype: String
  public var hdDetail: String
  public var hdEnabled: String
  public var screenformat: String
  public var videotype: String
  
  public override init() {
    self.audiotype = ""
    self.hdDetail = ""
    self.hdEnabled = ""
    self.screenformat = ""
    self.videotype = ""
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(audiotype, forKey: coding.audiotype.rawValue)
    coder.encode(screenformat, forKey: coding.screenformat.rawValue)
    coder.encode(videotype, forKey: coding.videotype.rawValue)
    
    let codeHD = HDListKeys.self
    
    coder.encode(hdDetail, forKey: codeHD.hdDetail.rawValue)
    coder.encode(hdEnabled, forKey: codeHD.hdEnabled.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let audiotypeDecode = coder.decodeObject(forKey: coding.audiotype.rawValue) as? String
    let screenformatDecode = coder.decodeObject(forKey: coding.screenformat.rawValue) as? String
    let videotypeDecode = coder.decodeObject(forKey: coding.videotype.rawValue) as? String
    let codeHD = HDListKeys.self
    let hdDetailDecode = coder.decodeObject(forKey: codeHD.hdDetail.rawValue) as? String
    let hdEnabledDecode = coder.decodeObject(forKey: codeHD.hdEnabled.rawValue) as? String
    self.init()
    self.audiotype = audiotypeDecode ?? ""
    self.hdDetail = hdDetailDecode ?? ""
    self.hdEnabled = hdEnabledDecode ?? ""
    self.screenformat = screenformatDecode ?? ""
    self.videotype = videotypeDecode ?? ""
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let hdContainer = try? container.nestedContainer(keyedBy: HDListKeys.self, forKey: .hd) {
      if let hdDetailDecode = try? hdContainer.decode(String.self, forKey: .hdDetail) {
        hdDetail = hdDetailDecode
      }
      if let hdEnabledDecode = try? hdContainer.decode(String.self, forKey: .hdEnabled) {
        hdEnabled = hdEnabledDecode
      }
    }
    if let audioTypeDecode = try? container.decode(String.self, forKey: .audiotype) {
      audiotype = audioTypeDecode
    }
    if let screenformatDecode = try? container.decode(String.self, forKey: .screenformat) {
      screenformat = screenformatDecode
    }
    if let videotypeDecode = try? container.decode(String.self, forKey: .videotype) {
      videotype = videotypeDecode
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try? codingKeys.encode(audiotype, forKey: .audiotype)
    try? codingKeys.encode(screenformat, forKey: .screenformat)
    try? codingKeys.encode(videotype, forKey: .videotype)
    var hdCodings = codingKeys.nestedContainer(keyedBy: HDListKeys.self, forKey: .hd)
    try? hdCodings.encode(hdDetail, forKey: .hdDetail)
    try? hdCodings.encode(hdEnabled, forKey: .hdEnabled)
  }
}
