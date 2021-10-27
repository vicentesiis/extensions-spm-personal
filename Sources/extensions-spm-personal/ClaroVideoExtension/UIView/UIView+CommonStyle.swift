//
//  UIView+BorderStyle.swift
//  Clarovideo
//
//  Created by Raúl López on 1/4/17.
//  Copyright © 2017 AMCO. All rights reserved.
//

import UIKit

public extension UIView {
  // MARK: - Social Profile ImageView Styles
  func roundEdgesToCircle()  {
    layer.masksToBounds = false
    layer.cornerRadius = frame.height / 2
    clipsToBounds = true
  }
  
  // MARK: - Content Card Image View Styles
  func borderVCardStyle() {
    layer.borderColor = UIColor.cvGray._444444.cgColor
    layer.borderWidth = 1.0
  }
  
  func whiteCornerBorderStyle(cornerRadius: CGFloat = 6.0)  {
    layer.borderColor = UIColor.white.cgColor
    layer.borderWidth = 1.0
    layer.cornerRadius = cornerRadius
    clipsToBounds = true
  }
  
  // MARK: - Cell Styles
  func backgroundColor(isOddCell isOdd: Bool) {
    let newColor: UIColor
    if isOdd {
      newColor = UIColor.cvBlack._222222
    } else {
      newColor = UIColor.clear
    }
    backgroundColor = newColor
  }
  
  // MARK: - Buttons
  func grayCornerBorderStyle() {
    layer.borderColor = UIColor.cvGray._CCCCCC.cgColor
    layer.borderWidth = 1.0
    layer.cornerRadius = 4.0
    clipsToBounds = true
  }
}
