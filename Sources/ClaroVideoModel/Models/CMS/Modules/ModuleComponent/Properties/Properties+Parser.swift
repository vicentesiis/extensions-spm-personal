//
//  Properties2+Parser.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 11/1/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

extension Properties: Decodable {
  
  enum CodingKeys: String, CodingKey { // declaring our keys
    case offset = "offset"
    case byuser = "byuser"
    case color = "color"
    case extrasmall = "extrasmall"
    case htmltag = "htmltag"
    case idProperty = "id"
    case imgdefault = "imgdefault"
    case imgextrasmall = "imgextrasmall"
    case imglarge = "imglarge"
    case imgmedium = "imgmedium"
    case imgsmall = "imgsmall"
    case large = "large"
    case medium = "medium"
    case small = "small"
    case type = "type"
    case url = "url"
    case boxcolor = "boxcolor"
    case fontcolor = "fontcolor"
    case buttoncolor = "buttoncolor"
    case buttonhovercolor = "buttonhovercolor"
    case ordenamiento = "ordenamiento"
  }
}
