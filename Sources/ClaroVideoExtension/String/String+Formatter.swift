//
//  String+Url.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 11/03/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

// MARK: -  String+Formatter
public struct StringConstants {
  static let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
  static let phoneNumberPattern = "^\\d{3}(-?)\\d{3}(-?)\\d{4}$"
  static let noSpecialCharacterPatthern = ".*[^A-Za-z0-9].*"
  public static let downloadDateFormatter = "dd/MM/yyyy HH:mm:ss"
}

public extension String {

  func convertDownloadDateStringToLocalTimeZoneDate() -> Date? {
    let formatter = DateFormatter()
    formatter.locale = NSLocale.system
    formatter.dateFormat = StringConstants.downloadDateFormatter
    formatter.timeZone = NSTimeZone.local
    
    return formatter.date(from: self) ?? nil
  }
  
  static func timeFormatted(_ totalSeconds: Int) -> String {
    let seconds = totalSeconds % 60
    let minutes = (totalSeconds / 60) % 60
    let hours = totalSeconds / 3600
    
    return String(format: "%02ld:%02ld:%02ld", hours, minutes, seconds)
  }
  
  func totalSecondsFromFormatHHMMSS() -> Int{
    var totalSeconds = 0
    let chunks = self.components(separatedBy: ":")
    if (chunks.count == 3) {
      let rollingCreditsTimeHours = Int(chunks[0]) ?? 0
      let rollingCreditsTimeMinutes = Int(chunks[1]) ?? 0
      let rollingCreditsTimeSeconds = Int(chunks[2]) ?? 0
      /* Add all the seconds */
      totalSeconds = rollingCreditsTimeHours * 3600 + rollingCreditsTimeMinutes * 60 + rollingCreditsTimeSeconds
    }
    return totalSeconds
  }
  
  func absoluteIntegerValue() -> Int {
    let replacedString = self.replacingOccurrences(of: "-", with: "")
    let absoluteValue = Int(replacedString) ?? 0
    return absoluteValue
  }
  
  func shortDateStyle() -> String {
    let locale = Locale(identifier: "es_MX")
    var formatter = DateFormatter()
    formatter.locale = NSLocale.system
    formatter.dateFormat = StringConstants.downloadDateFormatter
    formatter.timeZone = NSTimeZone.local
    guard let date = formatter.date(from: self) else {return ""}
    // Set the date components you want
    let dateComponents = "MMMdhhmm"
    // The components will be reordered according to the locale
    let dateFormat = DateFormatter.dateFormat(fromTemplate: dateComponents, options: 0, locale: locale)
    
    formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    formatter.timeZone = NSTimeZone.local
    formatter.locale = NSLocale.current
    
    return formatter.string(from: date)
  }
  
  func apiSearch() -> String {
    let searchText = self.lowercased().replacingOccurrences(of: " ", with: "+")
    return searchText
  }
}
