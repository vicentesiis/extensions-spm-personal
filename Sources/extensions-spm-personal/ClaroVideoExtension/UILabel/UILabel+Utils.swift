//
//  UILabel+Utils.swift
//  Clarovideo
//
//  Created by Erick  on 09/07/21.
//  Copyright © 2021 AMCO. All rights reserved.
//

import UIKit

public extension UILabel {
  
  static func center(_ size: CGFloat,_ weight: UIFont.Weight = .regular, lines numberOfLines: Int = 0) -> UILabel {
    center(nil, size, weight, lines: numberOfLines)
  }
  static func center(_ text: String?,_ size: CGFloat,_ weight: UIFont.Weight = .regular, lines numberOfLines: Int = 0) -> UILabel {
    let label = UILabel()
    label.textColor = .white
    label.textAlignment = .center
    label.font = .systemFont(ofSize: size, weight: weight)
    label.text = text
    label.numberOfLines = numberOfLines
    return label
  }
  
  func calculateMaxLines() -> Int {
      let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
      let charSize = font.lineHeight
      let text = (self.text ?? "") as NSString
      
      if let fontLabel = font {
          let textSize = text.boundingRect(with: maxSize,
                                           options: .usesLineFragmentOrigin,
                                           attributes: [NSAttributedString.Key.font: fontLabel],
                                           context: nil)
          let linesRoundedUp = Int(ceil(textSize.height/charSize))
          return linesRoundedUp
      }
      
      return 0
  }
  
}
