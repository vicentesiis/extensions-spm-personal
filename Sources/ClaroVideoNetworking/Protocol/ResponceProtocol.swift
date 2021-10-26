//
//  ResponceProtocol.swift
//  ClaroVideoNetworking
//
//  Created by alonso.salcido on 10/5/18.
//  Copyright © 2018 amco. All rights reserved.
//

import Foundation

public enum DataType {
  case JSON
  case Data
}

public enum ResponseType {
  case sucess
  case failure
}

public protocol ResponseProtocol {
  var data: Data? {get set}
  var type: ResponseType {get set}
}

public class Response: ResponseProtocol {
  
  // MARK: - Properties
  let request: RequestProtocol?
  public var data: Data?
  public var type: ResponseType
  
  public var jsonData: [String:Any]? {
    if let responceData = data, let json = try? JSONSerialization.jsonObject(with: responceData, options: []) {
      return json as? [String:Any]
    }
    return nil
  }
  
  // MARK: - Initialization
  public init(data: Data?, request: RequestProtocol? = nil) {
    self.data = data
    self.request = request
    self.type = .sucess
  }
}
