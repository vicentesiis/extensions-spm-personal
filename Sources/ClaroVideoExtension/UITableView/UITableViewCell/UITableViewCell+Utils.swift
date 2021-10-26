//
//  UITableViewCell+Utils.swift
//  ClarovideoTVOS
//
//  Created by Jessica Vera on 1/3/20.
//  Copyright © 2020 ironbit. All rights reserved.
//

import UIKit

fileprivate struct MotionWrapper {
  static let atvMotionEffect = UIMotionEffectGroup()
}

public extension UITableViewCell {
  
  func focusScaleAnimation() {
    self.addMotionEffect(MotionWrapper.atvMotionEffect)
    self.layer.shadowOpacity = 0.75
    self.layer.shadowRadius = 10.0
    self.layer.shadowOffset = CGSize(width: 0, height: 5)
    let scale: CGFloat = 1.07
    let transform = CGAffineTransform(scaleX: scale, y: scale)
    self.layer.setAffineTransform(transform)
  }
  
  func unfocusScaleAnimation() {
    self.removeMotionEffect(MotionWrapper.atvMotionEffect)
    self.layer.shadowOpacity = 0.25
    self.layer.shadowRadius = 4.0
    self.layer.shadowOffset = CGSize(width: 0, height: 0)
    let transform: CGAffineTransform = .identity
    self.layer.setAffineTransform(transform)
  }
}
