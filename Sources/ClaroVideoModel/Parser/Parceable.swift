//
//  Parceable.swift
//  cv-ios-parser
//
//  Created by Adrian Salazar on 11/13/18.
//  Copyright © 2018 AMCO. All rights reserved.
//

import Foundation

/// Parceable
public protocol Parceable {
  
  /// Parser object
  ///
  /// - Parameter dictionary: [String: AnyObject]
  /// - Returns: ParserResult<Self, NetworkError>
  static func parseObject(dictionary: [String: Any]) -> Result<Self, NetworkError>
}
