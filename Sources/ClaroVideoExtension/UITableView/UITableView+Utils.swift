//
//  UITableView+Utils.swift
//  Clarovideo
//
//  Created by Lech H. Conde on 09/03/18.
//  Copyright © 2018 AMCO. All rights reserved.
//

import UIKit

public extension UITableView {
  
  func hasRow(at indexPath: IndexPath) -> Bool {
    return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
  }
  
  func reloadData(completion: @escaping () -> ()) {
    UIView.animate(withDuration: 0, animations: { self.reloadData()})
      {_ in completion() }
  }
  
  func scrollToBottom(animated: Bool) {
    let y = contentSize.height - frame.size.height
    if y < 0 { return }
    setContentOffset(CGPoint(x: 0, y: y), animated: animated)
  }
  
}
