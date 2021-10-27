//
//  File.swift
//  Clarovideo
//
//  Created by Miguel Angel Olmedo Perez on 27/03/17.
//  Copyright © 2017 AMCO. All rights reserved.
//

import UIKit

public extension UIRectEdge {
  static var horizontal: UIRectEdge { [.left, .right ] }
  static var vertical: UIRectEdge { [.top, .bottom] }
}

public extension UIView{
  var heightConstraint: NSLayoutConstraint? {
    return self.constraintWithAttribute(attribute: .height)
  }
  var widthConstraint: NSLayoutConstraint? {
    return self.constraintWithAttribute(attribute: .width)
  }
  func constraintWithAttribute(attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
    var constraint: NSLayoutConstraint? = nil
    for c in self.constraints {
      if c.firstAttribute == attribute {
        constraint = c
        break
      }
    }
    return constraint
  }
  
  fileprivate func notMask() {
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  func edges(to view: UIView?, top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0, topAnchor: NSLayoutYAxisAnchor? = nil, bottonAnchor: NSLayoutYAxisAnchor? = nil, only edges: UIRectEdge = .all) {
    guard let view = view else { return }
    notMask()
    if edges.contains(.left) {
      self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left).isActive = true
    }
    if edges.contains(.right) {
      self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: right).isActive = true
    }
    if edges.contains(.top) {
      self.topAnchor.constraint(equalTo: topAnchor ?? view.topAnchor, constant: top).isActive = true
    }
    if edges.contains(.bottom) {
      self.bottomAnchor.constraint(equalTo: bottonAnchor ?? view.bottomAnchor, constant: bottom).isActive = true
    }
  }

  func edges(to guide: UILayoutGuide?, top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0, topAnchor: NSLayoutYAxisAnchor? = nil, bottonAnchor: NSLayoutYAxisAnchor? = nil, only edges: UIRectEdge = .all) {
    guard let guide = guide else { return }
    notMask()
    if edges.contains(.left) {
      self.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: left).isActive = true
    }
    if edges.contains(.right) {
      self.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: right).isActive = true
    }
    if edges.contains(.top) {
      self.topAnchor.constraint(equalTo: topAnchor ?? guide.topAnchor, constant: top).isActive = true
    }
    if edges.contains(.bottom) {
      self.bottomAnchor.constraint(equalTo: bottonAnchor ?? guide.bottomAnchor, constant: bottom).isActive = true
    }
  }

  func center(to view: UIView, centerX: CGFloat = 0, centerY: CGFloat = 0) {
    notMask()
    NSLayoutConstraint.activate([
      self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: centerX),
      self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: centerY)
    ])
  }

  func sizeAnchor(equalTo size: CGSize) {
    notMask()
    widthAnchor.constraint(equalToConstant: size.width).isActive = true
    heightAnchor.constraint(equalToConstant: size.height).isActive = true
  }
  
  func height(_ constant: CGFloat) {
    notMask()
    heightAnchor.constraint(equalToConstant: constant).isActive = true
  }
  
  func width(_ constant: CGFloat) {
    notMask()
    widthAnchor.constraint(equalToConstant: constant).isActive = true
  }
}
