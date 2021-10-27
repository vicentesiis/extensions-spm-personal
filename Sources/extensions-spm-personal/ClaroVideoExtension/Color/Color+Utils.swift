//
//  ColorExtension.swift
//  ClaroVideoServices
//
//  Created by Adrián Salazar G on 02/12/20.
//  Copyright © 2020 amco. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
  /// Create UIColor from a decimal string whith alpha value defined into string
  ///
  /// - Note: This method is a wrapper from `init(HexString hexString: String)`
  /// - Parameter hexString: The String Value
  /// - Returns: A UIColor
  class func color(hexString: String) -> UIColor {
      let color = UIColor(HexString: hexString)
      return color
  }
  
  /// Create UIColor from a decimal string whith alpha value defined into string
  ///
  /// - Note: This method allow a string with 6 and 8 characters,
  ///         whithout counting the format characters (#)
  ///         when the string contains 8 characters the two first
  //          characters represent the alpha value
  /// - Parameter hexString: The String Value, it need the prefix #
  convenience init(HexString hexString: String) {
      switch hexString.count {
      case 9,8:
          self.init(ARGBHexString: hexString)
      default:
          self.init(HexString: hexString, alpha: 1.0)
      }
  }
  
  fileprivate convenience init(ARGBHexString hexStr: String) {
      /* Convert hex string to an integer */
      var hexint: UInt64 = 0
      
      // Create scanner
      let scanner = Scanner(string: hexStr)
      
      // Tell scanner to skip the # character
      scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
      
      scanner.scanHexInt64(&hexint)
      
      /* Create color object, specifying alpha */
      self.init(red:    CGFloat((hexint >> 16) & 0xff) / 255.0,
                green:  CGFloat((hexint >> 8) & 0xff) / 255.0,
                blue:   CGFloat((hexint >> 0) & 0xff) / 255.0,
                alpha:  CGFloat((hexint >> 24) & 0xff) / 255.0)
  }
  
  /// Create UIColor from a decimal strin with alpha value defined by user
  ///
  /// - Parameters:
  ///   - hexStr: The String Value, it need the prefix #
  ///   - alpha: The Alpha Value
  fileprivate convenience init(HexString hexStr: String, alpha: CGFloat) {
      
      /* Convert hex string to an integer */
      var hexint: UInt64 = 0
      
      // Create scanner
      let scanner = Scanner(string: hexStr)
      
      // Tell scanner to skip the # character
      scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
      
      scanner.scanHexInt64(&hexint)
      
      /* Create color object, specifying alpha */
      self.init(red:    CGFloat((hexint >> 16) & 0xff) / 255.0,
                green:  CGFloat((hexint >> 8) & 0xff) / 255.0,
                blue:   CGFloat((hexint >> 0) & 0xff) / 255.0,
                alpha:  alpha)
  }
    
  /// Create UIColor from a decimal strin with alpha value defined by user
  ///
  /// - Note: This method is a wrapper form `init(HexString hexStr: String, alpha: CGFloat)`
  /// - Parameters:
  ///   - hexString: The String Value, it need the prefix #
  ///   - alpha: The Alpha Value
  /// - Returns: A UIColor
  class func color(hexString: String, alpha: CGFloat) -> UIColor {
      let color = UIColor(HexString: hexString, alpha: alpha)
      return color
  }
  
  var hexString:String {
    var red: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var green: CGFloat = 0.0
    var alpha: CGFloat = 0.0
    self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    return String(format: "%02X%02X%02X", (Int)(red * 255), (Int)(green * 255),(Int)(blue * 255))
  }
}
