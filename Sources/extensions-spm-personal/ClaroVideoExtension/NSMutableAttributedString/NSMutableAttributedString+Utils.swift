//
//  NSMutableAttributedString+Utils.swift
//  ClarovideoTVOS
//
//  Created by Alejandro Perez on 2/4/20.
//  Copyright © 2020 ironbit. All rights reserved.
//

import UIKit

public extension NSMutableAttributedString {
  
  func bold(_ value:String, fontSize: CGFloat) -> NSMutableAttributedString {
    let boldFont = CVFont.regular.of(size: fontSize, weight: .bold)
    let attributes:[NSAttributedString.Key : Any] = [
      .font : boldFont
    ]
    self.append(NSAttributedString(string: value, attributes:attributes))
    return self
  }
  
  func regular(_ value:String, fontSize: CGFloat) -> NSMutableAttributedString {
    let regularFont = CVFont.regular.of(size: fontSize, weight: .regular)
    let attributes:[NSAttributedString.Key : Any] = [
      .font : regularFont
    ]
    self.append(NSAttributedString(string: value, attributes:attributes))
    return self
  }
    
  func append(_ attrStrings: [NSAttributedString]) {
    for attrString in attrStrings {
      self.append(attrString)
      let space = NSAttributedString(string: "  ")
      self.append(space)
    }
  }
}
