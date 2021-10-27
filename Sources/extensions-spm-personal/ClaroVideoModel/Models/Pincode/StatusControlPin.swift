//
//  StatusControlPin.swift
//  ClaroVideoServices
//
//  Created by Erick Pulido Cienfuegos on 22/04/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public struct StatusControlPinResponse: Codable {
  public let pinPurchase : PinPurchase
  public let pinParental : PinParental
  public let pinChannel : PinChannel
}

public struct PinPurchase: Codable {
  public let status: Int
}

public struct PinParental: Codable {
  public let status: Int
  public let info: PinParentalInfo?
}

public struct PinChannel: Codable {
  public let status: Int
  public let info: [String]?
}

public struct PinParentalInfo: Codable {
  public let name: String
  public let description: String
  public let value: Int
}
