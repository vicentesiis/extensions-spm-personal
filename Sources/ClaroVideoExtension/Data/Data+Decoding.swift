//
//  Dictionary+CVUtils.swift
//  Clarovideo
//
//  Created by alonso.salcido on 25/09/17.
//  Copyright © 2017 AMCO. All rights reserved.
//

import Foundation

/// Extension for making base64 representations of `Data` safe for
/// transmitting via URL query parameters
public extension Data {
  
  /// Instantiates data by decoding a base64url string into base64
  ///
  /// - Parameter string: A base64url encoded string
  init?(base64URLEncoded string: String) {
    self.init(base64Encoded: string.toggleBase64URLSafe(on: false))
  }
  
  /// Encodes the string into a base64url safe representation
  ///
  /// - Returns: A string that is base64 encoded but made safe for passing
  ///            in as a query parameter into a URL string
  func base64URLEncodedString() -> String {
    return self.base64EncodedString().toggleBase64URLSafe(on: true)
  }
  
}
