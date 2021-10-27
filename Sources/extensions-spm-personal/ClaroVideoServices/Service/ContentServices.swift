//
//  ContentServices.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/5/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class ContentServices: CVServiceProtocol {
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: - Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }
  
  //MARK: Service methods
  public func getContentList(path: String, completion: @escaping (Result<(Int, [Group]), NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: ContentRequest.contentList(path: path), baseParams: baseParameters) { result in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
           let response = json["response"] as? [String: Any],
           let groups = response["groups"] {
          let parserResult = ParserHelper.parseObject(of: [Group].self, data: groups)
          let total = (response["total"] as? Int) ?? 0
          switch parserResult {
          case .success(let groups):
            completion(.success((total, groups)))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func getRecommendations(path: String, completion: @escaping (Result<[Group], NetworkError>) -> Void) {
    let request = ContentRequest.contentRecommendations(path: path)
    NetworkDispatcher(environment: environment).fetch(request: request, baseParams: baseParameters) { result in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
           let response = json["response"] as? [String: Any],
           let groups = response["groups"] {
          let parserResult = ParserHelper.parseObject(of: [Group].self, data: groups)
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
  
  public func getData(groupId: String, provider: String = "", completion: @escaping (Result<Group, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: ContentRequest.data(groupId: groupId), baseParams: baseParameters) { result in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
           let response = json["response"] as? [String: Any],
           let group = response["group"] as? [String: Any],
           let common = group ["common"] {
          var externalData: ExternalData? = nil
          let parserResult = ParserHelper.parseObject(of: Group.self, data: common)
          // Check if it comes with External Data
          if let external = group["external"] as? [String: Any],
             let providerGroup = external[provider] as? [String: Any]  {
            let externalDataParse = ExternalData.parseObject(dictionary: providerGroup as [String : AnyObject])
            switch externalDataParse {
            case .success(let data):
              externalData = data
            case .failure(let error):
              completion(.failure(error))
              return
            }
          }
          switch parserResult {
          case .success(let data):
            data.externalData = externalData
            completion(.success(data))
          case .failure(let error):
            completion(.failure(error))
          }
        } else {
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func getSerie(groupId: String, completion: @escaping (Result<[SerieSeason], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: ContentRequest.serie(groupId: groupId), baseParams: baseParameters) { result in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
           let response = json["response"] as? [String: Any],
           let seasons = response["seasons"] {
          let parserResult = ParserHelper.parseObject(of: [SerieSeason].self, data: seasons)
          switch parserResult {
          case .success(let seasons):
            completion(.success(seasons))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func getRecommendations(groupId: String, completion: @escaping (Result<[Group], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: ContentRequest.recommendations(groupId: groupId), baseParams: baseParameters) { result in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
           let response = json["response"] as? [String: Any],
           let groups = response["groups"] {
          let parserResult = ParserHelper.parseObject(of: [Group].self, data: groups)
          switch parserResult {
          case .success(let groups):
            completion(.success(groups))
          case .failure(let error):
            completion(.failure(error))
          }
        // In case the response is not parseable or empty.
        } else {
          completion(.failure(NetworkError.errorForParseFailed(error: "can not parse reponse: ")))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
