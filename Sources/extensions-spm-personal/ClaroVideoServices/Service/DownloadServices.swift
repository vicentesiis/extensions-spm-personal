//
//  DownloadServices.swift
//  ClaroVideoServices
//
//  Created by Luis Salcido on 04/02/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation

public final class DownloadServices: CVServiceProtocol {
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: - Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }
  
  //MARK: Service methods
  public func getMedia(params: GetMediaParams, completion: @escaping (Result<PlayerMedia, NetworkError>) -> Void) -> URLSessionDataTask? {
    
    let downloadGetMediaRequest = DownloadRequest.getMedia(getMediaParams: params)
    
    let dataTask = NetworkDispatcher(environment: environment).fetchSync(request: downloadGetMediaRequest, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
          let response = json["response"] as? [String: Any] {
          let parserResult = PlayerMedia.parseObject(dictionary: response as [String : AnyObject])
          switch parserResult {
          case .success(let playerMedia):
            completion(.success(playerMedia))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
    return dataTask
  }
  
  public func getlicense(params: GetMediaParams, completion: @escaping (Result<PlayerMedia, NetworkError>) -> Void) -> URLSessionDataTask? {
    
    let downloadLicenseRequest = DownloadRequest.getLicense(getMediaParams: params)
    
    let dataTask = NetworkDispatcher(environment: environment).fetchSync(request: downloadLicenseRequest, baseParams: baseParameters) { (result) in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
          let response = json["response"] as? [String: Any] {
          let parserResult = PlayerMedia.parseObject(dictionary: response as [String : AnyObject])
          switch parserResult {
          case .success(let playerMedia):
            completion(.success(playerMedia))
          case .failure(let error):
            completion(.failure(error))
          }
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
    return dataTask
  }
}
