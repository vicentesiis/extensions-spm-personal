//
//  Launcher+Parser.swift
//  ClaroVideoModels
//
//  Created by alonso.salcido on 12/5/18.
//  Copyright © 2018 AMCO. All rights reserved.
//

import Foundation

extension Launcher: Parceable, Codable {

  public static func parseObject(dictionary: [String : Any]) -> Result<Launcher, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      let launcher = try JSONDecoder().decode(Launcher.self, from: jsonData)
      return .success(launcher)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
}

extension Launcher {
  enum CodingKeys: String, CodingKey {
    case akamaiMfwk = "akamai_mfwk"
    case appStoreLink = "appStoreLink"
    case appVersionAllowed = "appVersionAllowed"
    case domain = "domain"
    case domainFrontEnd = "domainFrontEnd"
    case ipNetworkPublicAddress = "ipNetworkPublicAddress"
    case ipNetworkTrusted = "ipNetworkTrusted"
    case osVersionAllowed = "osVersionAllowed"
    case playerEncodingApn = "player_encoding_apn"
    case playerEncodingWifi = "player_encoding_wifi"
    case playerTypeApn = "player_type_apn"
    case playerTypeWifi = "player_type_wifi"
  }
  
  public convenience init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    akamaiMfwk = try container.decode(String.self, forKey: .akamaiMfwk)
    appStoreLink = try container.decodeIfPresent(String.self, forKey: .appStoreLink)
    if let appVersionAllowedString = try? container.decode(String.self, forKey: .appVersionAllowed) {
      appVersionAllowed = Bool(appVersionAllowedString) ?? false
    } else if let appVersionAllowedBool = try? container.decode(Bool.self, forKey: .appVersionAllowed) {
      appVersionAllowed = appVersionAllowedBool
    }
    domain = try container.decode(String.self, forKey: .domain)
    domainFrontEnd = try container.decode(URL.self, forKey: .domainFrontEnd)
    ipNetworkPublicAddress = try container.decode(String.self, forKey: .ipNetworkPublicAddress)
    if let ipNetworkTrustedString = try? container.decode(String.self, forKey: .ipNetworkTrusted) {
      ipNetworkTrusted = Bool(ipNetworkTrustedString) ?? false
    } else if let ipNetworkTrustedBool = try? container.decode(Bool.self, forKey: .ipNetworkTrusted) {
      ipNetworkTrusted = ipNetworkTrustedBool
    }
    
    if let osVersionAllowedString = try? container.decode(String.self, forKey: .osVersionAllowed) {
      osVersionAllowed = Bool(osVersionAllowedString) ?? false
    }else if let osVersionAllowedBool = try? container.decode(Bool.self, forKey: .osVersionAllowed) {
      osVersionAllowed = osVersionAllowedBool
    }
    playerEncodingApn = try container.decode(String.self, forKey: .playerEncodingApn)
    
    playerEncodingWifi = try container.decode(String.self, forKey: .playerEncodingWifi)
    playerTypeApn = try container.decode(String.self, forKey: .playerTypeApn)
    playerTypeWifi = try container.decode(String.self, forKey: .playerTypeWifi)
  }
  
  public func encode(to encoder: Encoder) throws {
    var codingKeys = encoder.container(keyedBy: CodingKeys.self)
    try codingKeys.encode(akamaiMfwk, forKey: .akamaiMfwk)
    try codingKeys.encode(appStoreLink, forKey: .appStoreLink)
    try codingKeys.encode(appVersionAllowed, forKey: .appVersionAllowed)
    try codingKeys.encode(domain, forKey: .domain)
    try codingKeys.encode(domainFrontEnd, forKey: .domainFrontEnd)
    try codingKeys.encode(ipNetworkPublicAddress, forKey: .ipNetworkPublicAddress)
    try codingKeys.encode(ipNetworkTrusted, forKey: .ipNetworkTrusted)
    try codingKeys.encode(osVersionAllowed, forKey: .osVersionAllowed)
    try codingKeys.encode(playerEncodingApn, forKey: .playerEncodingApn)
    try codingKeys.encode(playerEncodingWifi, forKey: .playerEncodingWifi)
    try codingKeys.encode(playerTypeApn, forKey: .playerTypeApn)
    try codingKeys.encode(playerTypeWifi, forKey: .playerTypeWifi)
  }
}

