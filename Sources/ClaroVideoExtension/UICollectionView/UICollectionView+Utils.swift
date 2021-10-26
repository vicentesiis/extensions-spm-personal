//
//  UICollectionViewExtentions.swift
//  ClarovideoTVOS
//
//  Created by Alejandro Perez on 1/30/20.
//  Copyright © 2020 ironbit. All rights reserved.
//

import UIKit

public extension UICollectionView {
  func scrollToNextItem() {
    var indexPath: IndexPath? = IndexPath()
    let contentSize = self.contentSize
    let maxX = contentSize.width
    var newContentOffset = self.contentOffset
    newContentOffset.x = CGFloat(floor(newContentOffset.x + self.bounds.size.width))
    newContentOffset.y = (self.frame).height / 2
    if newContentOffset.x < maxX {
      indexPath = self.indexPathForItem(at: newContentOffset)
    } else {
      indexPath = IndexPath(item: 0, section: 0)
    }
    let animated = indexPath?.row != 0
    self.moveTo(indexPath: indexPath, animated: animated)
  }
  
  func scrollToPreviousItem() {
    let contentOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.width))
    self.moveToFrame(contentOffset: contentOffset)
  }
  
  func moveToFrame(contentOffset : CGFloat) {
    self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
  }
  
  func moveTo(indexPath: IndexPath?, animated: Bool) {
    if let index = indexPath {
      self.scrollToItem(at: index, at: .left, animated: animated)
    }
  }
}
