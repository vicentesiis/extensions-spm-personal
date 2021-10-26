//
//  Record.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/15/19.
//  Copyright © 2019 amco. All rights reserved.
//  NOTE:- -1 In time cause theres no negative time in real life so its just for inits and if something changed in service

import Foundation

final public class Record : NSObject, NSCoding {
  
  public var date: String
  public var lastprogress: Int
  public var maxprogress: Int
  public var minutes: Int
  public var progress: Int
  public var seconds: Double
  public var time: String
  
  
  public override init() {
    self.date = ""
    self.lastprogress = -1
    self.maxprogress = -1
    self.minutes = -1
    self.progress = -1
    self.seconds = -1
    self.time = ""

  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(date, forKey: coding.date.rawValue)
    coder.encode(lastprogress, forKey: coding.lastprogress.rawValue)
    coder.encode(maxprogress, forKey: coding.maxprogress.rawValue)
    coder.encode(minutes, forKey: coding.minutes.rawValue)
    coder.encode(progress, forKey: coding.progress.rawValue)
    coder.encode(seconds, forKey: coding.seconds.rawValue)
    coder.encode(time, forKey: coding.time.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let dateDecode = coder.decodeObject(forKey: coding.date.rawValue) as? String
    let lastProgressDecode = coder.decodeObject(forKey: coding.date.rawValue) as? Int
    let maxprogressDecode = coder.decodeObject(forKey: coding.maxprogress.rawValue) as? Int
    let minutesDecode = coder.decodeObject(forKey: coding.minutes.rawValue) as? Int
    let progressDecode = coder.decodeObject(forKey: coding.progress.rawValue) as? Int
    let secondsDecode = coder.decodeObject(forKey: coding.seconds.rawValue) as? Double
    let timeDecode = coder.decodeObject(forKey: coding.time.rawValue) as? String
    self.init()
    self.date = dateDecode ?? ""
    self.lastprogress = lastProgressDecode ?? -1
    self.maxprogress = maxprogressDecode ?? -1
    self.minutes = minutesDecode ?? -1
    self.progress = progressDecode ?? -1
    self.seconds = secondsDecode ?? -1
    self.time = timeDecode ?? ""
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
    lastprogress = try container.decodeIfPresent(Int.self, forKey: .lastprogress) ?? -1
    maxprogress = try container.decodeIfPresent(Int.self, forKey: .maxprogress) ?? -1
    minutes = try container.decodeIfPresent(Int.self, forKey: .minutes) ?? -1
    progress = try container.decodeIfPresent(Int.self, forKey: .progress) ?? -1
    seconds = try container.decodeIfPresent(Double.self, forKey: .seconds) ?? -1
    time = try container.decodeIfPresent(String.self, forKey: .time) ?? ""
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(date, forKey: .date)
    try codingKeys.encode(lastprogress, forKey: .lastprogress)
    try codingKeys.encode(maxprogress, forKey: .maxprogress)
    try codingKeys.encode(minutes, forKey: .minutes)
    try codingKeys.encode(progress, forKey: .progress)
    try codingKeys.encode(seconds, forKey: .seconds)
    try codingKeys.encode(time, forKey: .time)
  }
}
