//
//  ContentServicesTests.swift
//  ClaroVideoServicesTests
//
//  Created by Alejandro Perez on 11/5/19.
//  Copyright © 2019 amco. All rights reserved.
//

import XCTest
@testable import ClaroVideoServices

class ContentServicesTests: XCTestCase {
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testGetContentList() {
    let expectation = XCTestExpectation(description: "Get Content downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "ukap72ck13s91tbj876eifh0u7"
    params["region"] = "mexico"
    
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "")
    
    let contentServices = ContentServices(environment: environment, baseParameters: params)
    contentServices.getContentList(path: "/services/content/list?quantity=50&order_way=ASC&order_id=50&level_id=GPS&from=0&filter_id=21722&region=mexico") { result in
      switch result {
      case .success(let groups):
        print(groups)
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 10.0)
  }
  
  func testContentRecommendations() {
    let expectation = XCTestExpectation(description: "Get Content Recommendations")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "(cbde3ecba058ac8875b09994b3f0ed84)"
    params["region"] = "mexico"
    params["group_id"] = 686252
    let environment = Environment(httpProtocol: .http, host: "mfwkappletv4-api.clarovideo.net", port: "")
    let service = ContentServices(environment: environment, baseParameters: params)
    service.getRecommendations(path: "/services/content/recommendations?region=mexico", completion: { (result) in
      switch result {
      case .success(let data):
        XCTAssertNotNil(data, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    })
    wait(for: [expectation], timeout: 30.0)
  }
  
  
  func testContentRecommendationsWithFilterList() {
    let expectation = XCTestExpectation(description: "Get Content Recommendations with filter list")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "(6u0kotepoper1i7e87v45mvtb5)"
    params["region"] = "mexico"
    params["group_id"] = 686252
    params["filterlist"] = 29156
    let environment = Environment(httpProtocol: .http, host: "mfwkappletv4-api.clarovideo.net", port: "")
    let service = ContentServices(environment: environment, baseParameters: params)
    service.getRecommendations(path: "/services/content/recommendations?region=mexico", completion: { (result) in
      switch result {
      case .success(let data):
        XCTAssertNotNil(data, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    })
    wait(for: [expectation], timeout: 30.0)
  }
  
  func testContentData() {
    let expectation = XCTestExpectation(description: "Get Content Data")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "kb80m79iop9bc2kvuuu4or8bg7"
    params["region"] = "mexico"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/content/")
    let service = ContentServices(environment: environment, baseParameters: params)
    service.getData(groupId: "793712", provider: "gracenote") { result in
      switch result {
      case .success(let group):
        XCTAssertNotNil(group, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 20.0)
  }
  
  func testContentDataSerie() {
    let expectation = XCTestExpectation(description: "Get Content Data")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "jtpb4bd91n3g9mc5pnukiukm76"
    params["region"] = "mexico"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/content/")
    let service = ContentServices(environment: environment, baseParameters: params)
    service.getData(groupId: "794493") { result in
      switch result {
      case .success(let group):
        XCTAssertNotNil(group, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 20.0)
  }
  
  func testContentSerie() {
    let expectation = XCTestExpectation(description: "Get Content Serie")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "jtpb4bd91n3g9mc5pnukiukm76"
    params["region"] = "mexico"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/content/")
    let service = ContentServices(environment: environment, baseParameters: params)
    service.getSerie(groupId: "527479") { result in
      switch result {
      case .success(let seasons):
        XCTAssertNotNil(seasons, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 20.0)
  }
  
  func testContentRecommendatios() {
    let expectation = XCTestExpectation(description: "Get Content Recommendations")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "jtpb4bd91n3g9mc5pnukiukm76"
    params["region"] = "mexico"
    params["filterlist"] = "34429,34263,34450,34451,34469,35707,36018,32118"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/content/")
    let service = ContentServices(environment: environment, baseParameters: params)
    service.getRecommendations(groupId: "599764") { result in
      switch result {
      case .success(let groups):
        XCTAssertNotNil(groups, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 20.0)
  }
}
