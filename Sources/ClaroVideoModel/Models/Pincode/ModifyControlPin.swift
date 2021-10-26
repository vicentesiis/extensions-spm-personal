//
//  ModifyControlPin.swift
//  ClaroVideoServices
//
//  Created by Juan Carlos  Carrera on 23/04/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public struct ModifyControlPin: Codable {
  public let purchasesPin: Int
  public let parentalPin: Int
  public let channelPin: Int
  public let updatedPin: Int?
  public let newPinCode: String?
}

public struct ModifyControlPinParameters {
  public let statusPurchasePin: Int
  public let statusParentalPin: Int
  public let statusChannelPin: Int
  public let accesssParentalCode: Int
  public let pin: String

  public init(statusPurchasePin: Int, statusParentalPin: Int, statusChannelPin: Int, accesssParentalCode: Int, pin: String) {
    self.statusPurchasePin = statusPurchasePin
    self.statusParentalPin = statusParentalPin
    self.statusChannelPin = statusChannelPin
    self.accesssParentalCode = accesssParentalCode
    self.pin = pin
  }
}
