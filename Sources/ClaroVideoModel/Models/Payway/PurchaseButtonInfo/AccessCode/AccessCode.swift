//
//  AccessCode.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/21/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class AccessCode: NSObject {
  public var enabled: Bool
  public var msgAccessCode: String
  
  public init(enabled: Bool = false, msgAccessCode: String = "") {
    self.enabled = enabled
    self.msgAccessCode = msgAccessCode
  }
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    enabled = try container.decodeIfPresent(Bool.self, forKey: .enabled) ?? false
    msgAccessCode = try container.decodeIfPresent(String.self, forKey: .msgAccessCode) ?? ""
  }
}
