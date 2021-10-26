//
//  InitialServicesTests.swift
//  InitialServicesTests
//
//  Created by alonso.salcido on 11/16/18.
//  Copyright © 2018 amco. All rights reserved.
//

import XCTest
@testable import ClaroVideoServices

class InitialServicesTests: XCTestCase {
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testFetchStartHeaderInfo() {
    let expectation = XCTestExpectation(description: "Start header info downloaded")
    let params = CommonParams().getCommonParams()
    let environment = Environment(httpProtocol: .http, host: "mfwkappletv4-api.clarovideo.net", port: "/services")
    let initial = InitialServices(environment: environment, baseParameters: params)
    initial.getStartHeaderInfo { (result) in
      switch result {
      case .success(let headerInfo):
        // Make sure we downloaded some data.
        XCTAssertNotNil(headerInfo, "No data was downloaded.")
        // Fulfill the expectation to indicate that the background task has finished successfully.
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testFetchApaSession() {
    let expectation = XCTestExpectation(description: "APA Session data downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded cause test is for service response
    params["HKS"] = "6u0kotepoper1i7e87v45mvtb5"
    params["appKey"] = "52f50ed0e4b053d3a195affb"
    params["region"] = "mexico"
    let environment = Environment(httpProtocol: .http, host: "apa-api-appletv4.clarovideo.net", port: "/services")
    let initial = InitialServices(environment: environment, baseParameters: params)
    initial.getApaSession { (result) in
      switch result {
      case .success(let session):
        // Make sure we downloaded some data.
        XCTAssertNotNil(session, "No data was downloaded.")
        // Fulfill the expectation to indicate that the background task has finished successfully.
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testFetchMetada() {
    let expectation = XCTestExpectation(description: "APA Metadata downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded cause test is for service response
    params["HKS"] = "6u0kotepoper1i7e87v45mvtb5"
    params["sessionKey"] = "52f50ed0e4b053d3a195affb-mexico"
    let environment = Environment(httpProtocol: .http, host: "apa-api-appletv4.clarovideo.net", port: "/services")
    let initial = InitialServices(environment: environment, baseParameters: params)
    initial.getApaMetadata { (result) in
      switch result {
      case .success(let metadata):
        // Make sure we downloaded some data.
        XCTAssertNotNil(metadata, "No data was downloaded.")
        // Fulfill the expectation to indicate that the background task has finished successfully.
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testFetchMetadaTestEnvironment() {
    let expectation = XCTestExpectation(description: "APA Metadata downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded cause test is for service response
    params["HKS"] = "sligvmim2kb3spd54f518qhjb7"
    params["sessionKey"] = "542d485ce4b033898a8e724e-mexico"
    let environment = Environment(httpProtocol: .http, host: "apa-api-mobileios-test.clarovideo.net", port: "/services")
    let initial = InitialServices(environment: environment, baseParameters: params)
    initial.getApaMetadata { (result) in
      switch result {
      case .success(let metadata):
        // Make sure we downloaded some data.
        XCTAssertNotNil(metadata, "No data was downloaded.")
        // Fulfill the expectation to indicate that the background task has finished successfully.
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testFetchAsset() {
    let expectation = XCTestExpectation(description: "APA Asset downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "6u0kotepoper1i7e87v45mvtb5"
    params["sessionKey"] = "292d16cb5b6d7a0ba20d5950a915e62e-mexico"
    let environment = Environment(httpProtocol: .http, host: "apa-api-appletv4.clarovideo.net", port: "/services")
    let initial = InitialServices(environment: environment, baseParameters: params)
    initial.getApaAsset { (result) in
      switch result {
      case .success(let asset):
        // Make sure we downloaded some data.
        XCTAssertNotNil(asset, "No data was downloaded.")
        // Fulfill the expectation to indicate that the background task has finished successfully.
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testFetchLauncher() {
    let expectation = XCTestExpectation(description: "APA Launcher downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "6u0kotepoper1i7e87v45mvtb5"
    params["region"] = "mexico"
    params["appversion"]  = ""
    params["osversion"]  = "iOS13"
    let environment = Environment(httpProtocol: .http, host: "mfwkappletv4-api.clarovideo.net", port: "/services")
    let initial = InitialServices(environment: environment, baseParameters: params)
    initial.getLauncher { (result) in
      switch result {
      case .success(let launcher):
        // Make sure we downloaded some data.
        XCTAssertNotNil(launcher, "No data was downloaded.")
        // Fulfill the expectation to indicate that the background task has finished successfully.
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testGetNavData() {
    // Setup
    var params = CommonParams().getCommonParams()
    params["HKS"] = "6u0kotepoper1i7e87v45mvtb5"
    params["appKey"] = "52f50ed0e4b053d3a195affb"
    params["tenant_code"] = "clarovideo"
    params["region"] = "mexico"
    let environment = Environment(httpProtocol: .http, host: "mfwkappletv4-api.clarovideo.net", port: "/services")
    let initial = InitialServices(environment: environment, baseParameters: params)

    // Test
    let expectation = XCTestExpectation(description: "Nav Data downloaded")
    initial.getNavData { result in
      switch result {
      case .success(let nodes):
        // Make sure we downloaded some data.
        XCTAssertNotNil(nodes, "No data was downloaded.")
        // Fulfill the expectation to indicate that the background task has finished successfully.
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 10.0)
  }
}
