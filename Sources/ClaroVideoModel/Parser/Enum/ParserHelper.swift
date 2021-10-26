//
//  ParserHelper.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import Foundation

public final class ParserHelper {
  
  /// Parse result to array
  ///
  /// - Parameters:
  ///   - data: Data
  ///   - completion: Result<[T], ParserErrorResult>
  public static func parse<T: Parceable>(data: Data, completion : (Result<[T], ParserErrorResult>) -> Void) {
    
    do {
      
      if let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [AnyObject] {
        
        // init final result
        var finalResult : [T] = []
        
        
        for object in result {
          if let dictionary = object as? [String : AnyObject] {
            
            // check foreach dictionary if parseable
            switch T.parseObject(dictionary: dictionary) {
            case .failure(_):
              continue
            case .success(let newModel):
              finalResult.append(newModel)
              break
            }
          }
        }
        
        completion(.success(finalResult))
        
      } else {
        // not an array
        completion(.failure(.parser(string: "Json data is not an array")))
      }
    } catch {
      // can't parse json
      completion(.failure(.parser(string: "Error while parsing json data")))
    }
  }
  
  /// Parse result to a dictionary
  ///
  /// - Parameters:
  ///   - data: Data
  ///   - completion: Result<[T], ParserErrorResult>
  public static func parse<T: Parceable>(data: Data, completion : (Result<T, NetworkError>) -> Void) {
    
    do {
      
      if let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] {
        
        // init final result
        // check foreach dictionary if parseable
        switch T.parseObject(dictionary: dictionary) {
        case .failure(let error):
          completion(.failure(error))
          break
        case .success(let newModel):
          completion(.success(newModel))
          break
        }
        
        
      } else {
        // not an array
        completion(.failure(NetworkError.errorForParseFailed(error: "Json data is not an array")))
      }
    } catch {
      // can't parse json
      completion(.failure(NetworkError.errorForParseFailed(error: "Error while parsing json data")))
    }
  }
  
  public static func parseObject<T: Decodable>(of type: T.Type, data: Any, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> Result<T, NetworkError> {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = keyDecodingStrategy
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
      let object = try decoder.decode(T.self, from: jsonData)
      return .success(object)
    } catch {
      return .failure(NetworkError.errorForParseFailed(error: error.localizedDescription))
    }
  }
    
    public static func parseSimpleObject<T: Decodable>(of type: T.Type, data: Any) -> T? {
      guard let jsonData = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted),
        let object = try? JSONDecoder().decode(T.self, from: jsonData) else {return nil}
      return object
    }
  
  public static func parse<T>(data: String) -> T? {
    var dictonary: T?
    if let data = data.data(using: String.Encoding.utf8) {
      do {
        dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? T
      } catch {
        return nil
      }
    }
    return dictonary
  }
  
  public static func encodeObject(data: Any?) -> String? {
    guard let d = data else {
      return ""
    }
    do {
      let jsonData = try! JSONSerialization.data(withJSONObject: d, options: .prettyPrinted)
      let strValue:String? = String(data: jsonData, encoding: .utf8)
      return strValue
    }
  }
  
}
