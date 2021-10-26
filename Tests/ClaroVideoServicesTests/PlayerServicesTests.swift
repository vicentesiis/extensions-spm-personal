//
//  PlayerServicesTests.swift
//  ClaroVideoServicesTests
//
//  Created by Alejandro Perez on 12/9/19.
//  Copyright © 2019 amco. All rights reserved.
//

import XCTest
@testable import ClaroVideoServices

class PlayerServicesTests: XCTestCase {
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  // 794557 Como Entrenar a tu dragon 3
  func testGetMediaMovie() {
    let expectation = XCTestExpectation(description: "Get Media")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["user_id"] = "32515180"
    params["user_agent"] = "IosDlaApk"
    params["preview"] = "0"
    params["HKS"] = "94ut80ipgtnfliaic91nqrsg01"
    params["device_so"] = "tvOS13.3"
    params["device_id"] = "24A5236D-EC34-4AE1-AD0A-3D5BC65C7596"
    params["quality"] = "M"
    params["css"] = false
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/player/")
    let service = PlayerServices(environment: environment, baseParameters: params)
    let getMediaParams = GetMediaParams(groupId: "776781",
                             contentId: "872568",
                             streamType: "hlsfps_ma",
                             region: "mexico",
                             paywayToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1ODA0MjYyNDcsImV4cCI6MTU4MDUxMjY0NywicGdzIjp7InVzZXJfaWQiOiIzMjUxNTE4MCIsInBfdXNlcl9pZCI6IjMyNTE1MTgwIiwib2ZmZXJpZCI6IjE0MzI3NTY1IiwicHVyY2hhc2VpZCI6IjQ4MzAwMDc3MSIsImdyb3VwIjoiNzc2NzgxIiwicGxheSI6MSwiY19kaXNwX3AiOiI1In19.Oi-xAeO89jHgSKM9YJMtKyynzRQNNjB-zBugNSWHLNE",
                             userToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1ODA0MjY1MjAsImV4cCI6MTU4NTYxMDgyMCwidXNyIjp7InVzZXJfaWQiOiIzMjUxNTE4MCIsInVzZXJfdHlwZSI6IkNNWEFNQ08iLCJ1c2VybmFtZSI6InN1cy5pcGFkLm14LmNyYWNrbGVAZ21haWwuY29tIiwiZW1haWwiOiJzdXMuaXBhZC5teC5jcmFja2xlQGdtYWlsLmNvbSIsImZpcnN0bmFtZSI6Ik1hZ28iLCJsYXN0bmFtZSI6ImlvcyIsImNvdW50cnlfY29kZSI6Ik1YIiwicmVnaW9uIjoibWV4aWNvIiwiYWNjZXB0ZWRfdGVybXMiOjEsImdhbWlmaWNhdGlvbl9pZCI6IjViMzE2YTU4MzkxYTk4NTc2NDUwNTc0MyIsInBhcmVudF9pZCI6IjMyNTE1MTgwIiwiYWNjb3VudCI6bnVsbCwiYWRtaW4iOnRydWV9fQ.2Dr790aKSB6zLiwbdVCzOoNcW94v9bwWsKmEudwSwuQ")
    service.getMedia(params: getMediaParams) { result in
      switch result {
      case .success(let playerMedia):
        XCTAssertNotNil(playerMedia, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let error):
        print(error)
      }
    }
    wait(for: [expectation], timeout: 10.0)
  } // https://microfwk-tabletios.clarovideo.net
  
  // 793797 Watchmen
  func testGetMediaSerie() {
    let expectation = XCTestExpectation(description: "Get Media")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["user_id"] = "32515180"
    params["stream_type"] = "hlsfps_ma"
    params["user_agent"] = "IosDlaApk"
    params["preview"] = "0"
    params["HKS"] = "jtpb4bd91n3g9mc5pnukiukm76"
    params["region"] = "mexico"
    params["device_so"] = "iOS"
    params["device_id"] = "A9AC2A43-851F-4996-9FE5-B926BE7ED2C6"
    params["content_id"] = "873920"
    params["quality"] = "M"
    params["css"] = false
    let environment = Environment(httpProtocol: .http, host: "mfwkappletv4-api.clarovideo.net", port: "/services/player/")
    let service = PlayerServices(environment: environment, baseParameters: params)
    let getMediaParams = GetMediaParams(groupId: "793797",
                             contentId: "873920",
                             isTrailer: "0",
                             streamType: "hlsfps_ma",
                             region: "mexico",
                             startTime: "",
                             endTime: "",
                             paywayToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NzU5MzE4NjYsImV4cCI6MTU3NjAxODI2NiwicGdzIjp7InVzZXJfaWQiOiIzMjUxNTE4MCIsInBfdXNlcl9pZCI6IjMyNTE1MTgwIiwib2ZmZXJpZCI6IjE0MzI3MzgwIiwicHVyY2hhc2VpZCI6IjQ1OTk3NjY4MCIsImdyb3VwIjoiNzk0NTU3IiwicGxheSI6MSwiY19kaXNwX3AiOiI1In19.xBnKmoku_EvXiQknCKcLi0YkwkfnIwLWXTmdFVrkBOk",
                             userToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1NzU5MzIxNDQsImV4cCI6MTU4MTExNjQ0NCwidXNyIjp7InVzZXJfaWQiOiIzMjUxNTE4MCIsInVzZXJfdHlwZSI6IkNNWEFNQ08iLCJ1c2VybmFtZSI6InN1cy5pcGFkLm14LmNyYWNrbGVAZ21haWwuY29tIiwiZW1haWwiOiJzdXMuaXBhZC5teC5jcmFja2xlQGdtYWlsLmNvbSIsImZpcnN0bmFtZSI6Ik1hZ28iLCJsYXN0bmFtZSI6ImlvcyIsImNvdW50cnlfY29kZSI6Ik1YIiwicmVnaW9uIjoibWV4aWNvIiwiYWNjZXB0ZWRfdGVybXMiOjEsImdhbWlmaWNhdGlvbl9pZCI6IjViMzE2YTU4MzkxYTk4NTc2NDUwNTc0MyIsInBhcmVudF9pZCI6IjMyNTE1MTgwIiwiYWNjb3VudCI6bnVsbCwiYWRtaW4iOnRydWV9fQ.wPNcRrIDI_11rLAo4D_UWTGKhWwld8nqM4Vqfpi7wjg")
    service.getMedia(params: getMediaParams) { result in
      switch result {
      case .success(let playerMedia):
        XCTAssertNotNil(playerMedia, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let error):
        print(error)
      }
    }
    wait(for: [expectation], timeout: 10.0)
  }
  
  func testGetQualities() {
    let expectation = XCTestExpectation(description: "Get Qualities")
    let environment = Environment(httpProtocol: .https, host: "", port: "")
    let service = PlayerServices(environment: environment, baseParameters: nil)
    service.getQualities(url:  "securehls-claroglobal-vod01.clarovideo.net/gl/playlist/variant.m3u8/legacy_mode/false/subs/true/t/0ac0e45ee283ccd0e27e45942902b714/f/501/M3U8/1576292343.m3u8", language: "ES") { result in
      switch result {
      case .success(let qualities):
        XCTAssertNotNil(qualities, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let error):
        print(error)
      }
    }
    wait(for: [expectation], timeout: 10.0)
  }
  
  func testGetTrailer() {
    let expectation = XCTestExpectation(description: "Get Media")
    var params = CommonParams().getBaseParams()
    params["user_id"] = "32515180"
    params["stream_type"] = "hlsfps_ma"
    params["user_agent"] = "IosDlaApk"
    params["preview"] = "1"
    params["HKS"] = "q0q7s9efgsfethj46342j280k6"
    params["region"] = "mexico"
    params["device_so"] = "iOS"
    params["device_id"] = "A316DBFA-1CCF-4BEA-B85F-FE4F6B321E1C"
    params["content_id"] = "878250"
    params["quality"] = "M"
    params["css"] = false
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/player/")
    let service = PlayerServices(environment: environment, baseParameters: params)
    let getMediaParams = GetMediaParams(groupId: "794655",
                             contentId: "878250",
                             isTrailer: "1",
                             streamType: "hlsfps_ma",
                             region: "mexico",
                             startTime: "",
                             endTime: "",
                             paywayToken: "",
                             userToken: "")
    service.getMedia(params: getMediaParams) { result in
      switch result {
      case .success(let playerMedia):
        XCTAssertNotNil(playerMedia, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let error):
        print(error)
      }
    }
    wait(for: [expectation], timeout: 10.0)
  }
  
  func testGetTrackService() {
    let expectation = XCTestExpectation(description: "Get Track")
    let params = CommonParams().getBaseParams()
    let environment = Environment(httpProtocol: .https, host: "", port: "")
    let service = PlayerServices(environment: environment, baseParameters: params)
    service.sendTrackEvent(withURI: "mfwkmobileios-api.clarovideo.net/services/track/tick?stream_uuid=4bbd6664-8982-450c-8cfb-f671ae5274b5&authpn=amco&authpt=12e4i8l6a581a&user_id=32515180&group_id=805374&content_id=892937&purchase_id=473938104&region=mexico&HKS=%2528jtpb4bd91n3g9mc5pnukiukm76%2529&user_hash=MzI1MTUxODB8MTU3OTI4MTc0N3xlZGM5YTAzZWIyMmU2OGYyOGVkZDRmMzA2NjAwYWEzMmRjYjM3NGE0MTcwYjUxMDYwNQ%253D%253D&device_category=mobile&device_manufacturer=aapl&device_model=aapl&device_type=iPhone&device_id=A9AC2A43-851F-4996-9FE5-B926BE7ED2C6&device_name=AlexPcool&device_so=iOS+13.3&data=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJncm91cF9pZCI6ODA1Mzc0LCJjb250ZW50X2lkIjoiODkyOTM3IiwibWF0ZXJpYWxfaWQiOiIzMTYzNTE1Iiwib2ZmZXJfaWQiOiIxNDMyNzIzMiIsInB1cmNoYXNlX2lkIjoiNDczOTM4MTA0IiwidXNlcl9kZXZpY2VfaWQiOiI3MDg3Mjg5MCIsInByZXZpZXciOiIwIiwiZGV2aWNlX2FwcF92ZXJzaW9uIjoiIiwidXNlcl9pZCI6IjMyNTE1MTgwIiwicmVnaW9uX2lkIjoiNDQxIiwiZm9ybWF0X3R5cGUiOiJzdXNjIiwidHJhY2tfdHlwZSI6MTAwLCJzdHJlYW1fdXVpZCI6IjRiYmQ2NjY0LTg5ODItNDUwYy04Y2ZiLWY2NzFhZTUyNzRiNSIsImR1cmF0aW9uIjo3MDgwLCJpcCI6IjIwMS4xMTYuNzguMiIsImNvdW50cnlfY29kZSI6Ik1YIiwidGltZSI6MTU3OTI4MTc0NiwicGFyZW50X2lkIjoiMzI1MTUxODAiLCJwcm9maWxlX2lkIjoiNWIzMTZhNTgzOTFhOTg1NzY0NTA1NzQzIiwiaXNfZnJlZSI6IjAiLCJpc19zZXJpZSI6IjAiLCJpc19saXZlIjoiMCIsInByb3ZpZGVyIjoiMyIsImRldmljZV9jYXRlZ29yeSI6Im1vYmlsZSIsImRldmljZV9tYW51ZmFjdHVyZXIiOiJhYXBsIiwiZGV2aWNlX21vZGVsIjoiYWFwbCIsImRldmljZV90eXBlIjoiaVBob25lIiwiZGV2aWNlX2lkIjoiQTlBQzJBNDMtODUxRi00OTk2LTlGRTUtQjkyNkJFN0VEMkM2IiwiZGV2aWNlX25hbWUiOiJBbGV4UGNvb2wiLCJkZXZpY2Vfc28iOiJpT1MgMTMuMyIsImZveHYzX2lkX2NvbnRlbmlkbyI6IjExOTM4MzU5NTMiLCJmb3h2M19jb250ZW50X3R5cGUiOjMsImZveHYzX3Rvb2xib3hfdG9rZW4iOiIwNTVkMDUwYTM2NTFlMzliZDZkNmU3MzE3YTA0Nzc5NWFkOTFjNGEyIiwiZm94djNfZXZlbnQiOiJQTEFZQkFDS19TVEFSVCIsInVzZXJfcGFja2FnZXMiOltdfQ.um5agVO2uJ-PZB6nyGEjhV7VGfduThmyXILRzhkuydY&api_version=v5.88&format=json&timecode=1") { result in
      switch result {
      case .success(let dictionary):
        XCTAssertNotNil(dictionary, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let error):
        print(error)
      }
    }
    wait(for: [expectation], timeout: 10.0)
  }
}

enum GenericRequest: RequestProtocol {
  case request(type: String, url: String, parameters: ServiceParameters)
  var path: String {
    switch self {
    case .request(_, let url , _):
      return url
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .request(let type, _, _):
      if type.elementsEqual("POST") {
        return .post
      } else {
        return .post
      }
    }
  }
  
  var headers: HTTPHeaders {
    switch self {
    case .request:
      return ["": ""]
    }
  }
  
  var timeoutInterval: TimeInterval {
    switch self {
    case .request:
      return 10.0
    }
  }
  
  func getUrlParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .request(_, _, let parameters):
      baseParams = baseParams.merging(parameters, uniquingKeysWith: { (first, _) in first })
      return baseParams
    }
  }
  
  func getBodyParameters(baseParameters: ServiceParameters?) -> ServiceParameters? {
    var baseParams = baseParameters ?? [:]
    switch self {
    case .request(_, _, let parameters):
      baseParams = baseParams.merging(parameters, uniquingKeysWith: { (first, _) in first })
      return baseParams
    }
  }
}

