//
//  Ranking.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/22/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class Ranking : NSObject, NSCoding {
  
  public var averageVotes: Int
  public var viewsCount: Int
  public var votesCount: Int
  
  
  public override init() {
    self.averageVotes = 0
    self.viewsCount = 0
    self.votesCount = 0
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(averageVotes, forKey: coding.averageVotes.rawValue)
    coder.encode(viewsCount, forKey: coding.viewsCount.rawValue)
    coder.encode(votesCount, forKey: coding.votesCount.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let averageVotesDecode = coder.decodeObject(forKey: coding.averageVotes.rawValue) as? Int
    let viewCountDecode = coder.decodeObject(forKey: coding.viewsCount.rawValue) as? Int
    let voteCountDecode = coder.decodeObject(forKey: coding.votesCount.rawValue) as? Int
    self.init()
    self.averageVotes = averageVotesDecode ?? -1
    self.viewsCount = viewCountDecode ?? -1
    self.votesCount = voteCountDecode ?? -1
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    averageVotes = Int(try container.decodeIfPresent(Float.self, forKey: .averageVotes) ?? 0)
    viewsCount = try container.decodeIfPresent(Int.self, forKey: .viewsCount) ?? 0
    votesCount = try container.decodeIfPresent(Int.self, forKey: .votesCount) ?? 0
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(averageVotes, forKey: .averageVotes)
    try codingKeys.encode(viewsCount, forKey: .viewsCount)
    try codingKeys.encode(votesCount, forKey: .votesCount)
  }
}
