//
//  JSONCodable.swift
//  Clarovideo
//
//  Created by Lech H. Conde on 14/02/18.
//  Copyright © 2018 AMCO. All rights reserved.
//

import Foundation

typealias JSONCodable = JSONEncodable & JSONDecodable

public protocol JSONEncodable: Encodable {}

extension JSONEncodable {
  public var dictionary: [String: Any]? {
    guard let data = self.data else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
  
  public var jsonString: String? {
    guard let data = self.data else { return nil }
    return String(data: data, encoding: .utf8)
  }
  
  private var data: Data? {
    return try? JSONEncoder().encode(self)
  }
}

public protocol JSONDecodable: Decodable {}

extension JSONDecodable {
 public init?(from dictionary: [String: Any]) {
    guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else {
      return nil
    }
    self.init(from: data)
  }
  
 public init?(from json: String) {
    guard let data = json.data(using: .utf8) else { return nil }
    self.init(from: data)
  }
  
 public init?(from data: Data) {
    guard let instance = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
    self = instance
  }
}
