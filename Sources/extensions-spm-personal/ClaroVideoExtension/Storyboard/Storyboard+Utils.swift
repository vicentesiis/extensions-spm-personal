//
//  Storyboard+Utils.swift
//  ClarovideoTVOS
//
//  Created by Alejandro Perez on 10/1/19.
//  Copyright © 2019 ironbit. All rights reserved.
//

import UIKit

public protocol Storyboarded {
  static func instantiate(fromStoryboard nibName: String) -> Self
}

public extension Storyboarded where Self: UIViewController {
  static func instantiate(fromStoryboard nibName: String) -> Self {
      let id = String(describing: self)
      let storyboard = UIStoryboard(name: nibName, bundle: Bundle(for: Self.self))
    return storyboard.instantiateViewController(withIdentifier: id) as! Self
  }
}
