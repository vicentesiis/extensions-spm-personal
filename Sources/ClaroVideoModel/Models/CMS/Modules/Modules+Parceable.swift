//
//  Modules2+Parceable.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/1/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Modules: Parceable {
  public static func parseObject(dictionary: [String : Any]) -> Result<Modules, NetworkError> {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      // here "jsonData" is the dictionary encoded in JSON data
      let modules = try JSONDecoder().decode(Modules.self, from: jsonData)
      return .success(modules)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
}

extension Modules: Decodable {
  enum CodingKeys: String, CodingKey { // declaring our keys
    case module = "module"
  }
}
