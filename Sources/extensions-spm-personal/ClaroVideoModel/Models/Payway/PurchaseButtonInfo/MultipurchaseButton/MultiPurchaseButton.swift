//
//  MultiPurchaseButton.swift
//  ClaroVideoServices
//
//  Created by Juan Carlos  Carrera on 12/07/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public class MultiPurchaseButton: NSObject, Decodable {
  public var buttons: [PurchaseButton]?
  public var playButton: [PurchaseButton]?

  enum CodingKeys: String, CodingKey {
      case buttons
      case playButton
  }

  required public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    buttons = try? container.decode([PurchaseButton].self, forKey: .buttons)
    playButton = try? container.decode([PurchaseButton].self, forKey: .playButton)
    guard let _ = playButton else {
      if let visible = try? container.decode(VisiblePlayButton.self, forKey: .playButton) {
        playButton = [PurchaseButton(visible: visible.visible)]
      }
      return
    }
  }
}

public struct VisiblePlayButton: Codable {
  public var visible: String
}
