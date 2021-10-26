//
//  LocalizableCache.swift
//  ClaroVideoServices
//
//  Created by Miguel Angel Olmedo Perez on 17/01/17.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

private var xoAssociationKey: UInt8 = 0
public typealias ClosureString = (String)->()

public protocol Localizable {
  /// The localized description
  var localized: String { get }
}

enum LocalizableError: Error {
  case keyNotFound(String)
}


public class LocalizableCache {
  public var metadataTranslates: [String: Any]?
  public var region: String = "default"
  public var translates = [String: String]()
  public var listLocalizedWaiting: [String: ClosureString] = [:]
  public static let shared = LocalizableCache()
  private init() {
    NotificationCenter.default.addObserver(self, selector: #selector(reloadLoadedLocalizations), name: Notification.Name("appaMetadataLoaded"), object: nil)
  }
  
  @objc func reloadLoadedLocalizations() {
    for localizable in listLocalizedWaiting {
      listLocalizedWaiting.removeValue(forKey: localizable.key)
      localizable.value(localizable.key.localized)
    }
  }
  
  public func setLocalData(_ metadataTranslate: [String: Any]?, region: String) {
    self.translates.removeAll()
    self.metadataTranslates = metadataTranslate
    self.region = region
  }
}
