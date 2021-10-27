//
//  DecodeBase.swift
//  ClaroVideoServices
//
//  Created by Adrián Salazar G on 09/10/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

struct OptionalObject<Base: Decodable>: Decodable {
  public let value: Base?
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let common = try? container.decode(Base.self, forKey: .common) {
      self.value = common
    } else {
      do {
        let container = try decoder.singleValueContainer()
        self.value = try container.decode(Base.self)
      } catch {
        self.value = nil
      }
    }
  }
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case common     = "common"
  }
}
