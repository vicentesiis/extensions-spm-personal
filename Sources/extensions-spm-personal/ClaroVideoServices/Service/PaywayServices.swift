//
//  PaywayServices.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/20/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

public final class PaywayServices: CVServiceProtocol {
  // MARK: - Properties
  public var environment: Environment
  public var baseParameters: ServiceParameters?
  
  // MARK: - Init
  public init(environment: Environment, baseParameters: ServiceParameters?) {
    self.environment = environment
    self.baseParameters = baseParameters
  }
  
  //MARK: Service methods
  public func getPurchaseButtonInfo(groupId: String? = nil,
                                    seassonId: String? = nil,
                                    isLive: Bool? = nil,
                                    objectType: String = "A", completion: @escaping (Result<PurchaseButtonInfo, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: PaywayRequest.purchasebuttoninfo(groupId: groupId, isLive: isLive, seassonId: seassonId, objectType: objectType), baseParams: baseParameters) { result in
      switch result {
        case .success(let response):
          self.parsePurchaseButtonInfo(json: response.jsonData, completion: completion)
        case .failure(let error):
          if !self.parsePurchaseButtonInfo(json: error.jsonResponse, completion: completion) {
            completion(.failure(error))
          }
      }
    }
  }
  
  @discardableResult
  private func parsePurchaseButtonInfo(json: [String:Any]?, completion: (Result<PurchaseButtonInfo, NetworkError>) -> Void)->Bool {
    if let jsonResponse = json,
       let response = jsonResponse["response"] as? [String: Any] {
      let parserResult = PurchaseButtonInfo.parseObject(dictionary: response as [String : AnyObject])
      switch parserResult {
        case .success(let purchaseButtonInfo):
          completion(.success(purchaseButtonInfo))
        case .failure(let error):
          completion(.failure(error))
      }
      return true
    }
    return false
  }
  
 public func fetchWorkFlowStartiTunesWithURL(_ url: String, completion: @escaping (Result<(Workflow, [Gateway]), NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: PaywayRequest.workflowstart(uri: url), baseParams: baseParameters) { result in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
          let response = json["response"] as? [String: Any] {
          let parserResult = Workflow.parseObject(dictionary: response as [String : AnyObject])
          switch parserResult {
          case .success(let workflow):
            if let gatewayList = workflow.list {
              completion(.success((workflow, gatewayList)))
            } else {
              completion(.success((workflow, workflow.listBuyLinks)))
            }
          case .failure(let error):
            completion(.failure(error))
          }
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
  
  public func buyConfirm(withbuyConfirmLink link: String,
                         ticket: String,
                         payway: String,
                         token: String,
                         completion: @escaping (Result<[String: Any], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetchCustomPost(request: PaywayRequest.buyConfirm(
      uri: link,
      ticket: ticket,
      payway: payway,
      token: token), baseParams: baseParameters) { result in
        switch result {
        case .success(let response):
          if let json = response.jsonData,
            let response = json["response"] as? [String: Any] {
            completion(.success(response))
          } else {
            print(response)
            if let json = response.jsonData {
              print(json)
            }
            completion(.failure(NetworkError.errorForWrongStructure()))
          }
        case .failure(let error):
          completion(.failure(error))
        }
    }
  }
  
  public func getLinealChannel(completion: @escaping (Result<[ChannelPackages], NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(
      request: PaywayRequest.linealChannels,
      baseParams: baseParameters) { result in
        switch result {
        case .success(let response):
          if let json = response.jsonData,
            let response = json["response"] as? [String: Any],
            let paqs = response["paqs"] as? [String: Any],
            let paq = paqs["paq"] {
            let parserResult = ParserHelper.parseObject(of: [ChannelPackages].self, data: paq)
            switch parserResult {
            case .success(let channelPackages):
              completion(.success(channelPackages))
            case .failure(let error):
              completion(.failure(error))
            }
          }
        case .failure(let error):
          completion(.failure(error))
        }
    }
  }
    
    public func fetchPaywaySuscriptionData(completion: @escaping (Result<[SubscriptionInfo], NetworkError>)->()) {
        NetworkDispatcher(environment: environment).fetch(request: PaywayRequest.dataSuscription, baseParams: baseParameters) { result in
               switch result {
               case .success(let response):
                 if let json = response.jsonData,
                   let response = json["response"] as? [[String: Any]] {
                    
                    let parserResult = SubscriptionInfo.decodeArray(arrayDic: response)
                    completion(.success(parserResult))
                 } else {
                  completion(.failure(.errorForWrongStructure()))
                }
               case .failure(let error):
                 completion(.failure(error))
            }
        }
    }

  public func getMultiPurchaseButtonInfo(groupIds: [String], token: String, completion: @escaping (Result<MultiPurchaseButtonInfo, NetworkError>) -> Void) {
    NetworkDispatcher(environment: environment).fetch(request: PaywayRequest.multiPurchaseButtonInfo(groupIds: groupIds, token: token), baseParams: baseParameters) { result in
      switch result {
      case .success(let response):
        if let json = response.jsonData,
           let response = json["data"] as? [String: Any] {
          let parserResult = PurchaseButtonInfo.parseMultiPurchaseButtonObject(dictionary: response as [String : AnyObject])
          switch parserResult {
            case .success(let multiPurchaseButtonInfo):
              completion(.success(multiPurchaseButtonInfo))
            case .failure(let error):
              completion(.failure(error))
          }
        } else {
          completion(.failure(.errorForWrongStructure()))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

}
