//
//  Group+Utils.swift
//  ClaroVideoServices
//
//  Created by Oscar Montaño Ayala on 07/06/21.
//  Copyright © 2021 amco. All rights reserved.
//

import Foundation

public extension Group {
  
  func getRating() -> Rating {
    if let extended = extended {
      let rating = extended.media.rating
      return rating
    }
    return Rating()
  }

  func getPublishYear() -> String {
    var publishyear = ""
    
    if let extended = extended {
      publishyear = extended.media.publishyear
    }
    
    if let externalData = externalData, !externalData.publishyear.isEmpty {
      let externalPublishYear = externalData.publishyear
      publishyear = externalPublishYear
    }
    return publishyear
  }
  
  func getStreamDuration() -> Double {
    var durationDouble = 0.0
    
    if duration != "" {
      let durationArray = duration.components(separatedBy:":")
      let hours = Double(durationArray[0]) ?? 0
      let min = Double(durationArray[1]) ?? 0
      let sec = Double(durationArray[2]) ?? 0
      durationDouble = sec + (min * 60) + (hours * 3600)
    }
    return durationDouble
  }
  
  func getRoles() -> [Params] {
    var roles = extended?.roles ?? []
    if let externalData = externalData, !externalData.cast.isEmpty {
      let externalRoles = externalData.cast
      roles = externalRoles
    }
    return roles
  }
  
  func getGenresForVcard(max: Int)  -> String {
    guard let genres = extended?.genres.map({ $0.desc }) else {return ""}
    let firstGenres: [String] = genres.count > max ? Array(genres.prefix(max)) : genres
    return firstGenres.joined(separator: ", ")
  }
  
  func getDurationFormat(hoursFormat: String = "h", minutesFormat: String = "min") -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    guard let date = formatter.date(from: getDuration()) else {return nil}
    let calendar = Calendar.current
    var stringDate = ""
    let hour = calendar.component(.hour, from: date)
    if hour > 0 {
      stringDate += "\(hour)\(hoursFormat) "
    }
    let minutes = calendar.component(.minute, from: date)
    if minutes > 0 {
      stringDate += "\(minutes)\(minutesFormat)"
    }
    return stringDate
  }
  
  func getDuration() -> String {
    var contentDuration = duration
    if let externalData = externalData, !externalData.duration.isEmpty {
      let externalDuration = externalData.duration
      contentDuration = externalDuration
    }
    return contentDuration
  }
}
