//
//  SearchServices.swift
//  ClaroVideoServices
//
//  Created by Adrian Salazar on 13/01/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

public final class SearchServices: CVServiceProtocol {
  
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: - Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }
  
  public func getVerticalSearchResults(field: String, value: String, startIndex: Int, quantity: Int, provider: String?, completion: @escaping (Result<[Group], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: SearchRequest.getVerticalSearchResults(field: field, value: value, start: startIndex, quantity: quantity, provider: provider), baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
        let jsonResponse = json["response"] as? [String: Any],
        let groupsDic = jsonResponse["groups"] as? [[String: Any]] {
          let groups = ParserHelper.parseSimpleObject(of: [Group].self, data: groupsDic) ?? []
          completion(.success(groups))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func fetchSearch(searchText: String, externalProvider: String, searchParams: [String: Any], completion: @escaping (Result<SearchResult?, NetworkError>) -> Void) -> URLSessionDataTask? {
    let networkdispatch = NetworkDispatcher(environment: environment)
    
    let dataTask = networkdispatch.fetchSync(request: SearchRequest.fetchSearch(searchText: searchText, searchParams: searchParams), baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
        let jsonResponse = json["response"] as? [String: Any],
        let searchResult = ParserHelper.parseSimpleObject(of: SearchResult.self, data: jsonResponse) {
          if let prediction = jsonResponse["prediction"] as? [String: Any] {
            // Create prediction if not exist
            if searchResult.prediction == nil {
              searchResult.prediction = SearchPredictionResult()
            }
            //External talents parser
            if let externaltalentDic = prediction["external_talents"] as? [String: Any],
            let externalTalentsMetadata = externaltalentDic["\(externalProvider)"] as? [[String: Any]] {
              searchResult.prediction?.externalTalents = ParserHelper.parseSimpleObject(of: [Talent].self, data: externalTalentsMetadata)
            }
            //Exclude keys for amco results
            let excludedKeys = ["external_talents","talents","genres","users","series","movies","live_channels","epgs"]
            //Providers parser
            for (key,value) in prediction {
              if !excludedKeys.contains(key),
              let providerDict = value as? [String:Any],
              let providerresult =  ParserHelper.parseSimpleObject(of: SearchProviderResult.self, data: providerDict) {
                providerresult.provider = key
                searchResult.prediction?.providers.append(providerresult)
              }
            }
          }
          completion(.success(searchResult))
        } else {
          completion(.success(nil))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
    return dataTask
  }
  
  public func getVerticalLookUpResultdsWithString(string: String, fiel: String, start: Int, quantity: Int, completion: @escaping (Result<[Group], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: SearchRequest.getVerticalLookUpResultds(string: string, fiel: fiel, start: start, quantity: quantity), baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
        let jsonResponse = json["response"] as? [String: Any],
        let groupsDic = jsonResponse["groups"] as? [[String: Any]] {
          let groups = ParserHelper.parseSimpleObject(of: [Group].self, data: groupsDic) ?? []
          completion(.success(groups))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  public func linealpredictiveSearch(searchText: String, searchParams: [String: Any], completion: @escaping (Result<SearchResultLinealPredictive, NetworkError>) -> Void) -> URLSessionDataTask? {
    let networkdispatch = NetworkDispatcher(environment: environment)

    let dataTask = networkdispatch.fetchSync(request: SearchRequest.linealpredictive(searchText: searchText, searchParams: searchParams), baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
        let jsonResponse = json["response"] as? [String: Any] {
          completion(ParserHelper.parseObject(of: SearchResultLinealPredictive.self, data: jsonResponse))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
    return dataTask
  }
}
