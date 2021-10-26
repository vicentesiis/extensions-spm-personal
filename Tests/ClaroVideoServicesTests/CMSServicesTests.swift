//
//  CMSServicesTests.swift
//  ClaroVideoServicesTests
//
//  Created by Alejandro Perez on 10/31/19.
//  Copyright © 2019 amco. All rights reserved.
//

import XCTest
@testable import ClaroVideoServices

class CMSServicesTests: XCTestCase {
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testGetLevel() {
    let expectation = XCTestExpectation(description: "Get level downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "ukap72ck13s91tbj876eifh0u7"
    params["region"] = "mexico"
    params["user_status"] = "susc"
    
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/cms/")

    let cmsServices = CMSServices(environment: environment, baseParameters: params)
    cmsServices.getLevel(node: "homeuser") { result in
      switch result {
      case .success(let modules):
        print(modules)
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testGetLevelUser() {
    let expectation = XCTestExpectation(description: "Get level downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "ukap72ck13s91tbj876eifh0u7"
    params["region"] = "mexico"
    params["user_status"] = "susc"
    params["user_hash"] = "MzI1MTUxODB8MTU3MjU0NTg1NXxiNzJlNTE1NzFiNjYyZmIzNmVhYWU2NWE0YzEzMzQ3ZTQ4NDY0MzMwZTA0MmUyMzBjZA=="
    params["user_id"] = "32515180"
    
    
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/cms/")

    let cmsServices = CMSServices(environment: environment, baseParameters: params)
    cmsServices.getLevelUser(node: "homeuser") { result in
      switch result {
      case .success(let modules):
        print(modules)
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
  
  func testGetSuperhighlight() {
    let expectation = XCTestExpectation(description: "Get level downloaded")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "ukap72ck13s91tbj876eifh0u7"
    params["region"] = "mexico"
    params["superhighlight"] = "homeuser"
    params["user_status"] = "susc ,suscripto_fox,no_suscripto_fox_sports,suscripto_hbo,no_suscripto_crackle,suscripto_noggin,suscripto_picardia_nacional,suscripto_indycar,suscripto_edye,suscripto_paramoun"
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "")

    let service = CMSServices(environment: environment, baseParameters: params)
    service.getSuperhighlight(path:"/services/cms/superhighlight?superhighlight=homeuser&region=mexico") { result in
      switch result {
      case .success(let groups):
        print(groups)
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
}
