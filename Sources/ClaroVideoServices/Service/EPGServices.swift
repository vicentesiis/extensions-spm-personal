//
//  EPGServices.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 03/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

public final class EPGServices: CVServiceProtocol {
  
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: - Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }
  
  public func getEPGChannel(params: EPGChannelParams, completion: @escaping (Result<[EPGChannel], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: EPGRequest.epgChannel(params: params), baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData, let status = json["status"] as? String,
          status == "0",
          let jsonResponse = json["response"] as? [String: Any],
          let jsonChannels = jsonResponse["channels"] as? [[String: Any]] {
          let filterChannels = jsonChannels.filter({$0["group"] != nil})
          let epgChannel = ParserHelper.parseSimpleObject(of: [EPGChannel].self, data: filterChannels)
          let newEPGChannel = epgChannel?.filter({!$0.events.isEmpty}) ?? []
          completion(.success(newEPGChannel))
        } else {
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func epgMenu(completion: @escaping (Result<[EPGMenu], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: EPGRequest.epgMenu, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
          let response = json["response"] as? [String: Any],
          let nodes = response["nodes"] {
          let parserResult = ParserHelper.parseObject(of: [EPGMenu].self, data: nodes)
          switch parserResult {
          case .success(let data):
            completion(.success(data))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func epgVersion(completion: @escaping (Result<String, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: EPGRequest.epgVersion, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
          let response = json["response"] as? [String: Any],
          let version = response["epg_version"] as? String {
            completion(.success(version))
        } else {
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
