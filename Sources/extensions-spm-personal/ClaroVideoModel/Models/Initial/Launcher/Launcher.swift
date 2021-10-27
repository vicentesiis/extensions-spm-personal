//
//  Launcher.swift
//  ClaroVideoModels
//
//  Created by Adrian Salazar on 11/23/18.
//  Copyright © 2018 AMCO. All rights reserved.
//

import Foundation

public final class Launcher: NSObject {
  
  public var akamaiMfwk: String? = nil
  public var appStoreLink: String? = nil
  public var appVersionAllowed: Bool = false
  public var domain: String? = nil
  public var domainFrontEnd: URL? = nil
  public var ipNetworkPublicAddress: String? = nil
  public var ipNetworkTrusted: Bool = false
  public var osVersionAllowed: Bool = false
  public var playerEncodingApn: String? = nil
  
  public var playerEncodingWifi: String? = nil
  public var playerTypeApn: String? = nil
  public var playerTypeWifi: String? = nil
}
