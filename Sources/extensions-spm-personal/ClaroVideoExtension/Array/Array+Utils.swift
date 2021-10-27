//
//  Array+Utils.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 21/10/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public extension Collection {
  /// Add validation is not empty
  var isNotEmpty: Bool { !isEmpty }
}

public extension Array where Element == String {
  
  /// Order the subscription array according to the business rules
  func orderToBusinessRules() -> [String] {
    // Sort array to Alphabetic Order
    let providers = self.sorted { $0 < $1 }
    return providers
  }
}
