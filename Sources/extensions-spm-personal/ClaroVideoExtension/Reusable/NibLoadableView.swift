//
//  NibLoadableView.swift
//  Clarovideo
//
//  Created by Miguel Angel Olmedo Perez on 04/01/17.
//  Copyright © 2017 AMCO. All rights reserved.
//

import UIKit

public protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

public extension NibLoadableView where Self: UIView {
    static var nibName: String{
        return String(describing: self)
    }
  
  static func fromNib<T: UIView>() -> T {
    return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)![0] as! T
  }
}
