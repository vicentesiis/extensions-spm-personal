//
//  CVFont.swift
//  Alamofire
//
//  Created by Andres Cantu on 15/07/21.
//

import UIKit

public enum CVFont: String {
  
  case regular = "Roboto-Regular"
  case medium = "Roboto-Medium"
  case bold = "Roboto-Bold"
  case light = "Roboto-Light"
  case thin = "Roboto-Thin"
  case custom
  
  public func of(size: CGFloat) -> UIFont {
    guard let font = UIFont(name: self.rawValue, size: size) else { return .systemFont(ofSize: size) }
    return font
  }
  
  public func of(size: CGFloat, weight: UIFont.Weight) -> UIFont {
    var font: UIFont?
    switch weight {
      case .regular: font = UIFont(name: CVFont.regular.rawValue, size: size)
      case .medium: font = UIFont(name: CVFont.medium.rawValue, size: size)
      case .bold: font = UIFont(name: CVFont.bold.rawValue, size: size)
      case .light: font = UIFont(name: CVFont.light.rawValue, size: size)
      case .thin: font = UIFont(name: CVFont.thin.rawValue, size: size)
      default: font = UIFont(name: CVFont.regular.rawValue, size: size)
    }
    return font ?? .systemFont(ofSize: size, weight: weight)
  }
  
}
