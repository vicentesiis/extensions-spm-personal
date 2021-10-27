//
//  NSString+Download.swift
//  Clarovideo
//
//  Created by Raul Lopez Martinez on 10/14/17.
//  Copyright © 2017 AMCO. All rights reserved.
//

import Foundation

let manifestConstant = "/Manifest"

public extension String {
  
  /// Add a `/Manifest` prefix
  ///
  /// - Returns: A new string
  func manifest() -> String {
    
    if self.range(of: "manifest") != nil {
      return self
    } else {
      return self + manifestConstant
    }
  }
  
  /// Encode Base 64 string
  ///
  /// - Returns: String base 64
  func encodeBase64() -> String {
    let longstring = self
    let data = (longstring).data(using: String.Encoding.utf8)
    let base64 = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    return base64
  }
}
