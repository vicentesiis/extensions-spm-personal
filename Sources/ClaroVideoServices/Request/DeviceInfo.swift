//
//  DeviceInfo.swift
//  ClaroVideoServices
//
//  Created by alonso.salcido on 10/12/18.
//  Copyright © 2018 amco. All rights reserved.
//

import UIKit

func IS_IPAD() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}

func IS_OSX() -> Bool {
  #if targetEnvironment(macCatalyst)
  return true
  #else
  return false
  #endif
}

public final class DeviceInfo {
  
  fileprivate struct Constants {
    static let idKey = "CVAppUUIDKey"
    static let model = "aapl"
    static let tabletCategory = "tablet"
    static let mobileCategory = "mobile"
    static let tabletDevice = "TABLET"
    static let phoneDevice = "PHONE"
    static let plataform = "iOS"
    static let brand = "apple"
  }
  
  static var getId : String {
    return UserDefaults.standard.object(forKey: Constants.idKey) as? String ?? ""
  }
  
  static var getName : String {
    return UIDevice.current.name
  }
  
  static var getModel : String {
    return Constants.model
  }
  
  static var getType : String {
    return UIDevice.current.model
  }
  
  static var getManufacturer : String {
    return Constants.model
  }
  
  static var getOS : String {
    return "\(getPlatform) \(getOSVersion)"
  }
  
  static var getOSVersion : String {
    return UIDevice.current.systemVersion
  }
  
  static var getCategory : String {
    return IS_IPAD() ? Constants.tabletCategory : Constants.mobileCategory
  }
  
  static var getDevice : String {
    return IS_IPAD() ? Constants.tabletDevice : Constants.phoneDevice
  }
  
  static var getPlatform : String {
    return Constants.plataform
  }
  
  static var getUUID: String {
    if let uuid = UIDevice.current.identifierForVendor {
      return uuid.uuidString
    }
    return ""
  }
  
  static var getIPAddress : String {
    var address : String?
    
    // Get list of all interfaces on the local machine:
    var ifaddr : UnsafeMutablePointer<ifaddrs>?
    guard getifaddrs(&ifaddr) == 0 else { return "" }
    guard let firstAddr = ifaddr else { return "" }
    
    // For each interface ...
    for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
      let interface = ifptr.pointee
      
      // Check for IPv4 or IPv6 interface:
      let addrFamily = interface.ifa_addr.pointee.sa_family
      if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
        
        // Check interface name:
        let name = String(cString: interface.ifa_name)
        if  name == "en0" {
          
          // Convert interface address to a human readable string:
          var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
          getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                      &hostname, socklen_t(hostname.count),
                      nil, socklen_t(0), NI_NUMERICHOST)
          address = String(cString: hostname)
        }
      }
    }
    freeifaddrs(ifaddr)
    
    return address ?? ""
  }
  
  static var getBrand : String {
    return Constants.brand
  }
  
  
  //+ (void)setUUIDKey
  
}
