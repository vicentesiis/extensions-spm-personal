//
//  PawayProfile.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/7/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class PaywayProfile: NSObject {
  public var subscriptions: [Subscriptions]?
  public var paymentMethods: [PaymentMethods]?
  
  // MARK: - Instance Methods
  public override init() {
    self.subscriptions = nil
    self.paymentMethods = nil
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    subscriptions = try? container.decodeIfPresent([Subscriptions].self, forKey: .subscriptions)
    paymentMethods = try? container.decodeIfPresent([PaymentMethods].self, forKey: .paymentMethods)
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(subscriptions, forKey: .subscriptions)
    try codingKeys.encode(paymentMethods, forKey: .paymentMethods)
  }
}
