//
//  ParserErrorResult.swift
//  cv-ios-parser
//
//  Created by Adrian Salazar on 11/13/18.
//  Copyright © 2018 AMCO. All rights reserved.
//

import Foundation

/// Enum of case parser error result
///
/// - network: String
/// - parser: String
/// - custom: String
public enum ParserErrorResult: Error {
  case network(string: String)
  case parser(string: String)
  case custom(string: String)
}
