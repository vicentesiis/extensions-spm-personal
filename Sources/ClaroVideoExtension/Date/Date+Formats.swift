//
//  Date+Formats.swift
//  ClaroVideoServices
//
//  Created by Oscar Montaño Ayala on 13/09/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public extension Date {
  func toddMMyyyy_HHmmss()->String {
    let formatter = DateFormatter()
    formatter.dateFormat = StringConstants.downloadDateFormatter
    return formatter.string(from: self)
  }
  
  static func timeColumnDisplayFormatter() -> DateFormatter {
    let timeColumnDisplayFormatter = DateFormatter()
    timeColumnDisplayFormatter.dateFormat = "HH:mm"
    timeColumnDisplayFormatter.locale = Locale(identifier: "en_US_POSIX")
    return timeColumnDisplayFormatter
  }
}
