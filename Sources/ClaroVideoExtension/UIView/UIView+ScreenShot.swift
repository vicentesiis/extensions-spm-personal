//
//  UIView+ScreenShot.swift
//  Clarovideo
//
//  Created by ironbit on 27/09/16.
//  Copyright © 2016 AMCO. All rights reserved.
//

import UIKit

public extension UIRectCorner {
  static var top: UIRectCorner { [.topLeft,.topRight] }
}


public extension UIView {
  
  /// MARK: -  ScreenShot
  func screenShot() -> UIImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
    
    guard let currentContext = UIGraphicsGetCurrentContext() else {
      return UIImage()
    }
    self.layer.render(in: currentContext)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
  
  /// MARK: - Accessibility Element
  func addAccessibility(identifier: String? = nil, value: String? = nil, labelName: String? = nil, needAccessibility: Bool? = nil) {
    if let flag = needAccessibility {
      isAccessibilityElement = flag
    }
    accessibilityIdentifier = identifier
    accessibilityLabel = labelName
    accessibilityValue = value
  }
  
  func addCornerRadius(radius:CGFloat = 4) {
    self.clipsToBounds = true
    self.layer.cornerRadius = radius
  }

  func setGradientBackground(colors:[CGColor] = [UIColor.black.cgColor, UIColor.clear.cgColor],  locations: [NSNumber] = [0.0, 1.0]) {
    layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = colors
    gradientLayer.locations = locations
    gradientLayer.frame = bounds
    layer.insertSublayer(gradientLayer, at:0)
  }

  func roundCorners(corners: UIRectCorner, radius: CGFloat = 4) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
}

public extension UIView {
  ///Make a circle view with same width and same height
  func makeRounded(applyBounds: Bool = true) {
    self.layer.masksToBounds = applyBounds
    self.layer.cornerRadius = self.frame.height / 2
    self.clipsToBounds = applyBounds
  }
  
  func removeRounded() {
    self.layer.masksToBounds = false
    self.layer.cornerRadius = 0
    self.clipsToBounds = false
  }

  ///Round corners from a view with a defualt of 6 points
  func roundCorners(radius: CGFloat = 6) {
    self.clipsToBounds = true
    self.layer.masksToBounds = true
    self.layer.cornerRadius = radius
  }
  
  /**
   This function to setup a generic constraint to a child view with a default value on all directions
   - Parameters:
     - childView: the view to apply the contraints
     - constant: the space beetwen the child's view and the parent
   - Important: This function is executed on the ***Main Thread***
 */
  func constraints(to childView: UIView, constant: CGFloat = 0.0) {
    DispatchQueue.main.async {
      childView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        childView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: constant),
        childView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -constant),
        childView.topAnchor.constraint(equalTo: self.topAnchor, constant: constant),
        childView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -constant)
      ])
    }
  }
  
  /**
    Function to setup a generic constraint to a child view
    - Parameters:
      - childView: the view to apply the contraints
      - verticalSpace: vertical space beetwen the child's view and the parent
      - horizontalSpace: horizontal space beetwen the child's view and the parent
    - Important: This function is executed on the ***Main Thread***
  */
  func constraints(to childView: UIView, verticalSpace: CGFloat, horizontalSpace: CGFloat) {
    DispatchQueue.main.async {
      childView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        childView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: horizontalSpace),
        childView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -horizontalSpace),
        childView.topAnchor.constraint(equalTo: self.topAnchor, constant: verticalSpace),
        childView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -verticalSpace)
      ])
    }
  }
  
  func makeShadow(visible: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.34).cgColor
    layer.shadowOpacity = visible ? 1.0 : 0.0
    layer.shadowOffset = .zero
    layer.shadowRadius = 5
  }
  
  func containsGradienLayers() -> Bool {
    guard let sublayers = layer.sublayers else { return false }
    let gradienLayers = sublayers.compactMap { $0 as? CAGradientLayer }
    return !gradienLayers.isEmpty
  }
    
  func applyBlurEffect(style: UIBlurEffect.Style = UIBlurEffect.Style.dark) {
    let blurEffect = UIBlurEffect(style: style)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    addSubview(blurEffectView)
    sendSubviewToBack(blurEffectView)
    constraints(to: blurEffectView)
  }
  
  func addLayoutGuide(_ forLayoutGuides: [UILayoutGuide]) {
    for layoutGuide in forLayoutGuides {
      self.addLayoutGuide(layoutGuide)
    }
  }
  
  func findSubview(_ withPrefix: String) -> UIView? {
    var currentSubview = subviews.first
    while let subview = currentSubview {
      if subview.description.hasPrefix(withPrefix) {
        return subview
      }
      currentSubview = subview.subviews.first
    }
    return nil
  }
  
  /**
    Function to setup a generic constraint to a parent view
    - Parameters:
      - constant: the space beetwen the child's view and the parent
    - Important: This function is **NOT** executed on the **Main Thread** if need please refer to the contraint(to:) function.
  */
  func applyAutoConstraints(constant: CGFloat = 0.0) {
    translatesAutoresizingMaskIntoConstraints = false
    guard let parent = superview else { fatalError("Not parentController to autoLayout to!") }
    NSLayoutConstraint.activate([
      leftAnchor.constraint(equalTo: parent.leftAnchor, constant: constant),
      rightAnchor.constraint(equalTo: parent.rightAnchor, constant: -constant),
      topAnchor.constraint(equalTo: parent.topAnchor, constant: constant),
      bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -constant)
    ])
  }
  
}
