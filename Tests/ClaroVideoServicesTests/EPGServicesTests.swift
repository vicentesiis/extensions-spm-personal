//
//  EPGServicesTests.swift
//  ClaroVideoServicesTests
//
//  Created by Alejandro Perez on 1/29/20.
//  Copyright © 2020 amco. All rights reserved.
//

import XCTest
@testable import ClaroVideoServices

class EPGServicesTests: XCTestCase {
  
  func testGetEPGChannel() {
    //TODO:- Pending test...
  }
  
  func testGetEPGMenu(){
    let expectation = XCTestExpectation(description: "Get epg menu")
    var params = CommonParams().getBaseParams()
    //Hardcoded HKS cause test is for service response
    params["HKS"] = "4l79ko3qe222unvvk67v87q523"
    params["region"] = "mexico"
    params["user_id"] = "37816521"
    params["user_hash"] = "Mzc4MTY1MjF8MTU4MTQzNzM4NXw5YTMwYTMzZjAwZWY0MTk2NzJhN2I2MDU4MmUxN2Y4ZWIxYzhmOWMzOTE5YTNiNThjMg=="
    let environment = Environment(httpProtocol: .https, host: "mfwkappletv4-api.clarovideo.net", port: "/services/epg/")
    let service = EPGServices(environment: environment, baseParameters: params)
    service.epgMenu() { result in
      switch result {
      case .success(let epgMenu):
        XCTAssertNotNil(epgMenu, "No data was downloaded.")
        expectation.fulfill()
      case .failure(let networkError):
        print(networkError)
      }
    }
    wait(for: [expectation], timeout: 10.0)
  }
}
