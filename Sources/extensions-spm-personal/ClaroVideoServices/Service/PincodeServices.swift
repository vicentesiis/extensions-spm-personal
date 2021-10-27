//
//  PincodeServices.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 22/04/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public enum TypeControlPin: String {
  case add
  case delete
  case check
  case list
}

public final class PincodeServices: CVServiceProtocol {
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: - Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }

  // MARK: - Pin services
  public func statusControlPin(userHash: String, completion: @escaping(Result<StatusControlPinResponse, NetworkError>) -> Void){  
    NetworkDispatcher(environment: environment).fetch(request: PincodeRequest.statusControlPin(userHash: userHash), baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let jsonData = response.jsonData, let response = jsonData["response"] as? [String: Any] {
          completion(ParserHelper.parseObject(of: StatusControlPinResponse.self, data: response, keyDecodingStrategy: .convertFromSnakeCase))
        }else {
          completion(.failure(.errorForParseFailed(error: "Error in dictionary")))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  public func sendControlpinChannel(userHash: String, groupId: String, typeControlPin: TypeControlPin, completion: @escaping(Result<Bool, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: PincodeRequest.sendControlpinChannel(userHash: userHash, groupId: groupId, typeControlPin: typeControlPin), baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
           let _ = json["response"] as? String {
          completion(.success(true))
        } else if let json = response.jsonData,
                let response = json["response"] as? Bool {
          completion(.success(response))
        } else {
          completion(.failure(.errorForParseFailed(error: "Error in parse")))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func checkControlPin(controlPin: String, completion: @escaping(Result<Bool, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: PincodeRequest.checkControlPin(controlPin: controlPin), baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
                let response = json["response"] as? Bool {
          completion(.success(response))
        }else {
          completion(.failure(.errorForParseFailed(error: "Error in parse")))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func getListChannelsBlock(userHash: String, completion: @escaping(Result<[String], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: PincodeRequest.sendControlpinChannel(userHash: userHash, groupId: "", typeControlPin: .list), baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
           let response = json["response"] as? [String:Any],
           let groups = response["groups"] as? [[String:Any]]
        {
          let channels:[String] = groups.map { _group in
            _group["id"] as? String ?? "\(_group["id"] ?? 0)"
          }
          completion(.success(channels))
        } else {
          completion(.failure(.errorForParseFailed(error: "Error in parse")))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  public func modifyControlPin(parameters: ModifyControlPinParameters, completion: @escaping(Result<ModifyControlPin, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: PincodeRequest.modifycontrolpin(parameters: parameters), baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let jsonData = response.jsonData,
           let response = jsonData["response"] as? [String: Any],
           let accomplishmentStatus = response["update_accomplishment_status"] as? [String:Any] {
          completion(ParserHelper.parseObject(of: ModifyControlPin.self, data: accomplishmentStatus, keyDecodingStrategy: .convertFromSnakeCase))
        }else {
          completion(.failure(.errorForParseFailed(error: "Error in dictionary")))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func reminderControlPin(completion: @escaping(Result<Bool, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: PincodeRequest.remindcontrolpin, baseParams: baseParameters) { (result) in
      switch result {
        case .success(let response):
          if let json = response.jsonData,
             let response = json["response"] as? [String: Any],
             let sendCode = response["email_sent"] as? Bool {
            completion(.success(sendCode))
          } else {
            completion(.failure(.errorForParseFailed(error: "Error in parse")))
          }
        case .failure(let error):
          completion(.failure(error))
      }
    }
  }
  
}
