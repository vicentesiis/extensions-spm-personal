//
//  PurchaseButtonInfo.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/21/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class PurchaseButtonInfo: NSObject {
  
  public var listButtons: [PurchaseButton]?
  public var downloadButton: PurchaseButton?
  public var playButton: PurchaseButton?
  public var bannerpromo: String
  public var accessCode: AccessCode
  
  // MARK: - Instance Methods
  public init(listButtons: [PurchaseButton]? = nil, downloadButton: PurchaseButton? = nil,
              playButton: PurchaseButton? = nil, bannerpromo: String = "", accessCode: AccessCode = AccessCode()) {
    self.listButtons = listButtons
    self.downloadButton = downloadButton
    self.playButton = playButton
    self.bannerpromo = bannerpromo
    self.accessCode = accessCode
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    downloadButton = try container.decodeIfPresent(PurchaseButton.self, forKey: .downloadButton)
    playButton = try container.decodeIfPresent(PurchaseButton.self, forKey: .playButton)
    bannerpromo = try container.decodeIfPresent(String.self, forKey: .bannerpromo) ?? ""
    accessCode = try container.decodeIfPresent(AccessCode.self, forKey: .accessCode) ?? AccessCode()
    let buttonsContainer = try? container.nestedContainer(keyedBy: ButtonsKeys.self, forKey: .listButtons)
    if let buttonContainer = buttonsContainer {
      listButtons = try buttonContainer.decodeIfPresent([PurchaseButton].self, forKey: .button)
    }
  }
}
