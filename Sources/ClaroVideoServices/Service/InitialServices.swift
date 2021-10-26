//
//  InitialServices.swift
//  ClaroVideoServices
//
//  Created by alonso.salcido on 11/20/18.
//  Copyright © 2018 amco. All rights reserved.
//

import Foundation

public final class InitialServices: CVServiceProtocol {
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: - Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }
  
  //MARK: Service methods
  public func getStartHeaderInfo(completion: @escaping (Result<StartHeaderInfo,NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request:  InitialServicesRequest.startHeaderInfo, baseParams: baseParameters) { result in
      switch(result) {
      // valiate success
      case .success(let response):
        if let jsonResponse = response.jsonData {
          //Validate status it can be string or int
          let stringStatus = jsonResponse["status"] as? String ?? ""
          let intStatus = jsonResponse["status"] as? Int ?? 0
          if stringStatus == "0" || intStatus == 0 {
            let responce = jsonResponse["response"]
            //Maping object
            let parserResult = StartHeaderInfo.parseObject(dictionary: responce as! [String : AnyObject])
            switch parserResult {
            //(Maping success
            case .success(let startHeaderInfo):
              completion(.success(startHeaderInfo))
            //Maping error
            case .failure(let error):
              completion(.failure(error))
            }
          } else {
            //Status error
            //TODO: deserialize error
            completion(.failure(NetworkError.errorForWrongStructure()))
          }
        }else {
          // error in response json
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
      //send error
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func getApaMetadata(completion: @escaping (Result<Metadata,NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: InitialServicesRequest.apaMetadata, baseParams: baseParameters) { result in
      switch(result) {
      // valiate success
      case .success(let response):
        if let jsonResponse = response.jsonData {
          //Maping object
          let parserResult = Metadata.parseObject(dictionary: jsonResponse as [String : AnyObject])
          switch parserResult {
          //(Maping success
          case .success(let metadata):
            completion(.success(metadata))
          //Maping error
          case .failure(let error):
            completion(.failure(error))
          }
        }else {
          // error in response json
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
      //send error
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func getMetadataTranslations(completion: @escaping (Result<MetadataTranslations,NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: InitialServicesRequest.metadataTranslations, baseParams: baseParameters) { result in
      switch(result) {
      // valiate success
      case .success(let response):
        if let jsonResponse = response.jsonData {
          //Maping object
          let parserResult = MetadataTranslations.parseObject(dictionary: jsonResponse as [String : AnyObject])
          switch parserResult {
          //(Maping success
          case .success(let translations):
            completion(.success(translations))
          //Maping error
          case .failure(let error):
            completion(.failure(error))
          }
        }else {
          // error in response json
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
      //send error
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func getApaAsset(completion: @escaping (Result<Asset,NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: InitialServicesRequest.apaAsset, baseParams: baseParameters) { result in
      switch(result) {
      // valiate success
      case .success(let response):
        if let jsonResponse = response.jsonData {
          //Maping object
          let parserResult = Asset.parseObject(dictionary: jsonResponse as [String : AnyObject])
          switch parserResult {
          //(Maping success
          case .success(let asset):
            completion(.success(asset))
          //Maping error
          case .failure(let error):
            completion(.failure(error))
          }
        }else {
          // error in response json
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
      //send error
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func getLauncher(completion: @escaping (Result<Launcher,NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: InitialServicesRequest.launcher, baseParams: baseParameters) { result in
      switch(result) {
      // valiate success
      case .success(let response):
        self.mapLauncher(jsonData: response.jsonData, completion: completion)
      //send error
      case .failure(let launcherError):
        // Map launcher to validate app version
        self.mapLauncher(jsonData: launcherError.jsonResponse) { (mapResult) in
          switch(mapResult) {
            case .success(let launcher):
              // If app version is not allowed send success
              if !launcher.appVersionAllowed {
                completion(.success(launcher))
              } else {
                completion(.failure(launcherError))
              }
            case .failure:
              completion(.failure(launcherError))
          }
        }
      }
    }
  }
  
  public func getNavData(completion: @escaping (Result<[Node],NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: InitialServicesRequest.nav, baseParams: baseParameters) { result in
      switch result {
      case .success(let response):
        if let json = response.jsonData, let response = json["response"] as? [String: Any],
          let nodes = response["nodes"] as? [[String: Any]] {
          // Mapping object
          let parserResult = Node.parseArrayObject(dictionary: nodes)
          switch parserResult {
          case .success(let nodes):
            completion(.success(nodes))
          case .failure(let error):
            completion(.failure(error))
          }
        } else {
          // Error in response json
          completion(.failure(NetworkError.errorForWrongStructure()))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  
  private func mapLauncher(jsonData: [String: Any]?, completion: @escaping (Result<Launcher,NetworkError>) -> Void) {
    if let json = jsonData, let response = json["response"] as? [String : Any]{
      //Maping object
      let parserResult = Launcher.parseObject(dictionary: response)
      switch parserResult {
      //(Maping success
      case .success(let launcher):
        completion(.success(launcher))
      //Maping error
      case .failure(let error):
        completion(.failure(error))
      }
    }else {
      // error in response json
      completion(.failure(NetworkError.errorForWrongStructure()))
    }
  }
}
