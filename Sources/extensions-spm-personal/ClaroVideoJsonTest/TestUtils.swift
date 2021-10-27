//
//  TestUtils.swift
//  ClaroVideoServices
//
//  Created by Erick  Cienfuegos on 14/10/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public class TestUtils {
  
  fileprivate static func readLocalFile(forName name: String, in bundle: Bundle) -> Data? {
    do {
      if let bundlePath = bundle.path(forResource: name, ofType: "json"),
         let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
        return jsonData
      }
    } catch {
      print(error)
    }
    return nil
  }

  public static func loadLocalJson<T: Decodable>(fileName: String, in bundle: Bundle = Bundle(for: TestUtils.self)) -> T? {
    guard let data = readLocalFile(forName: fileName, in: bundle) else{ return nil }
    do {
      let decoder = JSONDecoder()
      let jsonData = try decoder.decode(T.self, from: data)
      return jsonData
    } catch {
      print("error:\(error)")
    }
    return nil
  }

}
