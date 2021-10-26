//
//  NetworkResult.swift
//  ClaroVideoNetworking
//
//  Created by alonso.salcido on 10/10/18.
//  Copyright © 2018 amco. All rights reserved.
//

import Foundation

public struct NetworkError: Error, LocalizedError {
  
  private static let defaultErrorCode = "IOS_API_00001"
  private static let defaultErrorType = "internal"
  
  public let code: String
  public let type: String
  public let error: String
  public let httpCode: Int
  public let jsonResponse: [String:Any]?
  
  public var errorDescription: String? {
    return (error == "" ? code : error)
  }
  
  static func errorForMissingURL() -> NetworkError {
    return NetworkError(code: defaultErrorCode, type: defaultErrorType, error: "URL is nil.", httpCode: 500, jsonResponse: nil)
  }
  
  static func errorForRecuestfailed() -> NetworkError {
    return NetworkError(code: defaultErrorCode, type: defaultErrorType, error: "urlRequest failed.",httpCode: 500, jsonResponse: nil)
  }
  
  public static func errorForWrongStructure() -> NetworkError {
    return NetworkError(code: defaultErrorCode, type: defaultErrorType, error: "wrong structure",httpCode: 500, jsonResponse: nil)
  }
  
  public static func errorForParseFailed(error: String) -> NetworkError {
    return NetworkError(code: defaultErrorCode, type: defaultErrorType, error: error,httpCode: 500, jsonResponse: nil)
  }
  
  public static func errorWithCode(_ code:String) -> NetworkError {
    return NetworkError(code: code, type: defaultErrorType, error: code,httpCode: 500, jsonResponse: nil)
  }
  
  public static func errorWithMessage(_ message:String) -> NetworkError {
    return NetworkError(code: defaultErrorCode, type: defaultErrorType, error: message,httpCode: 500, jsonResponse: nil)
  }
  
  static func mapError(errorResponse: Any, httpCode: Int, jsonResponse: [String:Any]) -> NetworkError
  {
    var errorCode = defaultErrorCode
    var errorType = defaultErrorType
    var errorMessage = defaultErrorCode
    if let errorArray = errorResponse as? [[String: Any]],
      let firstElement = errorArray.first {
      if let message = firstElement["message"] as? String {
        errorMessage = message
      }
      if let errorTypeString = firstElement["type"] as? String {
        errorType = errorTypeString
      }
      if let code = firstElement["code"] as? String {
        errorCode = code
        errorMessage = code
      }
    } else if let errorDict = errorResponse as? [String:Any],
      let code = errorDict["code"] as? String {
      errorCode = code
      errorMessage = code
      if let errorTypeString = errorDict["type"] as? String {
        errorType = errorTypeString
      }
    }
    
    return NetworkError(code: errorCode, type: errorType, error: errorMessage, httpCode: httpCode, jsonResponse: jsonResponse)
  }
}




