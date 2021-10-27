//
//  Date+BussinessRules.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 16/03/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public extension Date {
  func substractHours(_ hours: Int) -> Date {
    let interbal = TimeInterval(-3600*hours)
    return Date.init(timeInterval: interbal, since: self)
  }
  
  func add(seconds: Int) -> Date{
    let interbal = TimeInterval(seconds)
    return Date.init(timeInterval: interbal, since: self)
  }
  
  func epochUnix() -> String {
    let timestamp = Int(self.timeIntervalSince1970)
    let string = String(format: "%d", timestamp)
    let digits = CharacterSet(charactersIn: "0123456789")
    let tmpArray = string.components(separatedBy: digits)
    let nDigits = tmpArray.count - 1
    
    if nDigits >= 10 {
      return String(format: "%d0000000", timestamp)
    }
    
    return string
  }
  
  func roundedTimeForTimeshift() -> Date {
    let currentDate = self
    let seconds = ceil((currentDate.timeIntervalSinceReferenceDate/30) * 30)
    let roundedDate = Date(timeIntervalSinceReferenceDate: seconds)
    return roundedDate
  }
  
  func getUTCFormate() -> String {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    let dateString = formatter.string(from: self)
    return dateString
  }
  
  func localDate() -> Date {
    let nowUTC = Date()
    let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
    guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
    return localDate
  }
}
