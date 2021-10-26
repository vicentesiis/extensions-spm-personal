//
//  ReusableView.swift
//  Clarovideo
//
//  Created by Miguel Angel Olmedo Perez on 04/01/17.
//  Copyright © 2017 AMCO. All rights reserved.
//

import UIKit

public protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}
