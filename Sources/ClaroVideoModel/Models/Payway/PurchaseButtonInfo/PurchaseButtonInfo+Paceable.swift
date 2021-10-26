//
//  PurchaseButtonInfo+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/21/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension PurchaseButtonInfo: Parceable {
  public static func parseObject(dictionary: [String : Any]) -> Result<PurchaseButtonInfo, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      // here "jsonData" is the dictionary encoded in JSON data
      let purchaseButtonInfo = try JSONDecoder().decode(PurchaseButtonInfo.self, from: jsonData)
      return .success(purchaseButtonInfo)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }

  public static func parseMultiPurchaseButtonObject(dictionary: [String : Any]) -> Result<MultiPurchaseButtonInfo, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      let multiPurchaseButtonInfo = try JSONDecoder().decode(MultiPurchaseButtonInfo.self, from: jsonData)
      return .success(multiPurchaseButtonInfo)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
}

extension PurchaseButtonInfo: Decodable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case listButtons = "listButtons"
    case downloadButton = "downloadButton"
    case playButton = "playButton"
    case bannerpromo = "bannerpromo"
    case accessCode = "accessCode"
  }
  enum ButtonsKeys: String, CodingKey {
    case button = "button"
  }
}
