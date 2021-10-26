//
//  Properties.swift
//  ClaroVideoServices
//
//  Created by Alejandro Perez on 10/31/19.
//  Copyright © 2019 amco. All rights reserved.
//

import Foundation

final public class Properties: NSObject {
  public var offset: Int
  public var byuser: String
  public var color: String
  public var extrasmall: String
  public var htmltag: String
  public var idProperty: String
  public var imgdefault: String
  public var imgextrasmall: String
  public var imglarge: String
  public var imgmedium: String
  public var imgsmall: String
  public var large: String
  public var medium: String
  public var small: String
  public var type: String
  public var url: String
  public var boxcolor: String
  public var fontcolor: String
  public var buttoncolor: String
  public var buttonhovercolor: String
  public var ordenamiento: [Ordenamiento]?
  
  // MARK: - Instance Methods
  public init(offset: Int = 0, byuser: String = "", color: String = "", extrasmall: String = "", htmltag: String = "",
                       idProperty: String = "",imgdefault: String = "", imgextrasmall: String = "", imglarge: String = "",
                       imgmedium: String = "", imgsmall: String = "", large: String = "", medium: String = "", small: String = "",
                       type: String = "", url: String = "", boxcolor: String = "", fontcolor: String = "", buttoncolor: String = "",
                       buttonhovercolor: String = "", ordenamiento: [Ordenamiento]? = nil) {
    self.offset = offset
    self.byuser = byuser
    self.color = color
    self.extrasmall = extrasmall
    self.htmltag = htmltag
    self.idProperty = idProperty
    self.imgdefault = imgdefault
    self.imgextrasmall = imgextrasmall
    self.imglarge = imglarge
    self.imgmedium = imgmedium
    self.imgsmall = imgsmall
    self.large = large
    self.medium = medium
    self.small = small
    self.type = type
    self.url = url
    self.boxcolor = boxcolor
    self.fontcolor = fontcolor
    self.buttoncolor = buttoncolor
    self.buttonhovercolor = buttonhovercolor
    self.ordenamiento = ordenamiento
  }
  
  required convenience public init(from decoder: Decoder) throws {
    self.init()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    offset = try container.decodeIfPresent(Int.self, forKey: .offset) ?? 0
    byuser = try container.decodeIfPresent(String.self, forKey: .byuser) ?? ""
    color = try container.decodeIfPresent(String.self, forKey: .color) ?? ""
    htmltag = try container.decodeIfPresent(String.self, forKey: .htmltag) ?? ""
    idProperty = try container.decodeIfPresent(String.self, forKey: .idProperty) ?? ""
    imgdefault = try container.decodeIfPresent(String.self, forKey: .imgdefault) ?? ""
    imgextrasmall = try container.decodeIfPresent(String.self, forKey: .imgextrasmall) ?? ""
    imglarge = try container.decodeIfPresent(String.self, forKey: .imglarge) ?? ""
    imgmedium = try container.decodeIfPresent(String.self, forKey: .imgmedium) ?? ""
    imgsmall = try container.decodeIfPresent(String.self, forKey: .imgsmall) ?? ""
    if let extrasmallStr = try container.decodeIfPresent(String.self, forKey: .extrasmall) {
      extrasmall = String(htmlEncodedString: extrasmallStr) ?? ""
    }    
    if let lar = try container.decodeIfPresent(String.self, forKey: .large) {
      large = String(htmlEncodedString: lar) ?? ""
    }
    if let mediumStr = try container.decodeIfPresent(String.self, forKey: .medium) {
      medium = String(htmlEncodedString: mediumStr) ?? ""
    }
    if let smallStr = try container.decodeIfPresent(String.self, forKey: .small) {
      small = String(htmlEncodedString: smallStr) ?? ""
    }
    type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
    url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    boxcolor = try container.decodeIfPresent(String.self, forKey: .boxcolor) ?? ""
    fontcolor = try container.decodeIfPresent(String.self, forKey: .fontcolor) ?? ""
    buttoncolor = try container.decodeIfPresent(String.self, forKey: .buttoncolor) ?? ""
    buttonhovercolor = try container.decodeIfPresent(String.self, forKey: .buttonhovercolor) ?? ""
    ordenamiento = try container.decodeIfPresent([Ordenamiento].self, forKey: .ordenamiento)
  }
}
