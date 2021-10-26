//
//  Parental.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/9/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

@objc(Parental)
public final class Parental: NSObject, NSCoding {
  
  public var requiresValidation: Bool
  public var sha1Pincode: String
  // MARK: - Instance Methods
  public override init() {
    self.requiresValidation = false
    self.sha1Pincode = ""
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(requiresValidation, forKey: coding.requiresValidation.rawValue)
    coder.encode(sha1Pincode, forKey: coding.sha1PinCode.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let requiresValidationDecode = coder.decodeObject(forKey: coding.requiresValidation.rawValue) as? Bool
    let sha1PincodeDecode = coder.decodeObject(forKey: coding.sha1PinCode.rawValue) as? String
    self.init()
    self.requiresValidation = requiresValidationDecode ?? false
    self.sha1Pincode = sha1PincodeDecode ?? ""
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    requiresValidation = try container.decodeIfPresent(Bool.self, forKey: .requiresValidation) ?? false
    sha1Pincode = try container.decodeIfPresent(String.self, forKey: .sha1PinCode) ?? ""
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(requiresValidation, forKey: .requiresValidation)
    try codingKeys.encode(sha1Pincode, forKey: .sha1PinCode)
  }
}
