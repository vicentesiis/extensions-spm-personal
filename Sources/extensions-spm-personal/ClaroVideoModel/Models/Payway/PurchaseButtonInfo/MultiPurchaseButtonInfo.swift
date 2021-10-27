//
//  MultiPurchaseButtonInfo.swift
//  ClaroVideoServices
//
//  Created by Juan Carlos  Carrera on 12/07/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public struct MultiPurchaseButtonInfo: Decodable {
  public var listButtons: [String:MultiPurchaseButton]?
}
