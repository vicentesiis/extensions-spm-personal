//
//  DateFormatter+Helpers.swift
//  ClaroVideoServices
//
//  Created by Luis Alonso Salcido Martínez on 16/03/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public extension DateFormatter {
  class func is12HoursFormat() -> Bool {
    guard let formatString = dateFormat(fromTemplate: "j", options: 0, locale: Locale.current) else { return false }
    return formatString.contains("a")
  }
}
