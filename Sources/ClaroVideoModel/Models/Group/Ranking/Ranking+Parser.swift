//
//  Ranking+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/22/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Ranking: Codable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case averageVotes = "average_votes"
    case viewsCount = "views_count"
    case votesCount = "votes_count"
  }
}
