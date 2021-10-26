//
//  PurchaseMedia.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 12/10/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

@objc(PurchaseMedia)
final public class PurchaseMedia: NSObject, NSCoding {
  
  public var acquisitionDate: String?
  public var expirationDate: String?
  
  // MARK: - Instance Methods
  public override init() {
    self.acquisitionDate = nil
    self.expirationDate = nil
  }
  
  public func encode(with coder: NSCoder) {
    let coding = CodingKeys.self
    
    coder.encode(acquisitionDate, forKey: coding.acquisitionDate.rawValue)
    coder.encode(expirationDate, forKey: coding.expirationDate.rawValue)
  }
  
  public convenience init?(coder: NSCoder) {
    let coding = CodingKeys.self
    
    let acquisitionDateDecode = coder.decodeObject(forKey: coding.acquisitionDate.rawValue) as? String
    let expirationDateDecode = coder.decodeObject(forKey: coding.expirationDate.rawValue) as? String
    self.init()
    self.acquisitionDate = acquisitionDateDecode ?? ""
    self.expirationDate = expirationDateDecode ?? ""
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if let acquist = try? container.decode(String.self, forKey: .acquisitionDate) {
      acquisitionDate = acquist
    }
    if let expDate = try container.decodeIfPresent(String.self, forKey: .expirationDate) {
      expirationDate = expDate
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try? codingKeys.encode(acquisitionDate, forKey: .acquisitionDate)
    try? codingKeys.encode(expirationDate, forKey: .expirationDate)
  }
}
