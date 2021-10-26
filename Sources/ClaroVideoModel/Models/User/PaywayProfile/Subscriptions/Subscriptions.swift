//
//  Subscriptions.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/7/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class Subscriptions: NSObject {
  public var name: String?
  public var key: String?
  public var paymentMethod: PaymentMethods?
  
  // MARK: - Instance Methods
  public override init() {
    self.name = nil
    self.key = nil
    self.paymentMethod = nil
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try? container.decodeIfPresent(String.self, forKey: .name)
    key = try? container.decodeIfPresent(String.self, forKey: .key)
    paymentMethod = try? container.decodeIfPresent(PaymentMethods.self, forKey: .paymentMethod)
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(name, forKey: .name)
    try codingKeys.encode(key, forKey: .key)
    try codingKeys.encode(paymentMethod, forKey: .paymentMethod)
  }
  
}
