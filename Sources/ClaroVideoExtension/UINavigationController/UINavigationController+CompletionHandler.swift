//
//  UINavigationController+CompletionHandler.swift
//  Clarovideo
//
//  Created by Josue Jesus Maqueda Flores on 26/03/20.
//  Copyright © 2020 AMCO. All rights reserved.
//

import UIKit

private var ObjectTagKey = "ObjectTag"

public extension UINavigationController {
  
  var shouldIgnorePushing:Bool {
    get{
      return (objc_getAssociatedObject(self, &ObjectTagKey) as? Bool) ?? false
    }
    set{
      objc_setAssociatedObject(self, &ObjectTagKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }
  
  func completionhandler_pushViewController(_ viewController:UIViewController, animated:Bool, completion:(()->Void)?) {
    if !shouldIgnorePushing {
      shouldIgnorePushing = true
      CATransaction.begin()
      pushViewController(viewController, animated: animated)
      CATransaction.setCompletionBlock(completion)
      CATransaction.commit()
    }
  }
}
