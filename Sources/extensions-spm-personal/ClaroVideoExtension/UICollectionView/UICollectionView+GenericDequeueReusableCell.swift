//
//  UICollectionView+GenericDequeueReusableCell.swift
//  Clarovideo
//
//  Created by Miguel Angel Olmedo Perez on 04/01/17.
//  Copyright © 2017 AMCO. All rights reserved.
//

import UIKit

public extension UICollectionView {

    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
  
    func dequeueReusableView<T: UICollectionReusableView>(isHeader: Bool, forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
      let viewOfKind = isHeader ? UICollectionView.elementKindSectionHeader : UICollectionView.elementKindSectionFooter
      guard let cell = dequeueReusableSupplementaryView(ofKind: viewOfKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
        fatalError("Could not dequeue reusable view with identifier: \(T.reuseIdentifier)")
      }
      return cell
    }
  
   func dequeueReusableView<T: UICollectionReusableView>(viewOfKind: String, forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
     guard let cell = dequeueReusableSupplementaryView(ofKind: viewOfKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
       fatalError("Could not dequeue reusable view with identifier: \(T.reuseIdentifier)")
     }
     return cell
   }
}
