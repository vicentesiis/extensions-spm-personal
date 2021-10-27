//
//  UIButton+Utils.swift
//  ClarovideoTVOS
//
//  Created by Daniel Meneses on 09/03/20.
//  Copyright © 2020 ironbit. All rights reserved.
//

import UIKit

public extension UIButton {
  // NOTE:- This is not changing the button background, instead is creating another UIImage to display when button is focused. Creating a sort of overlap with the default UIImage
  /// Sets the background color to use for the specified button state.
  func setBackgroundColor(color: UIColor, titleColor: UIColor = .white, forState: UIControl.State) {
    let minimumSize: CGSize = CGSize(width: self.bounds.width, height: self.bounds.height)

    UIGraphicsBeginImageContext(minimumSize)

    if let context = UIGraphicsGetCurrentContext() {
      context.setFillColor(color.cgColor)
      context.fill(CGRect(origin: .zero, size: minimumSize))
    }

    let colorImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    self.clipsToBounds = true
    self.setBackgroundImage(colorImage, for: forState)
    self.setTitleColor(titleColor, for: forState)
  }
}
