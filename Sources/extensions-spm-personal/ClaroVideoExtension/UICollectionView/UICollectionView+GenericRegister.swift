//
//  File.swift
//  Clarovideo
//
//  Created by Miguel Angel Olmedo Perez on 04/01/17.
//  Copyright © 2017 AMCO. All rights reserved.
//

import UIKit

public extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
  
    func registerFooter<T: UICollectionReusableView>(_: T.Type, isHeader: Bool) where T: ReusableView {
      let viewOfKind = isHeader ? UICollectionView.elementKindSectionHeader : UICollectionView.elementKindSectionFooter
      register(T.self, forSupplementaryViewOfKind: viewOfKind, withReuseIdentifier: T.reuseIdentifier)
    }
  
    func registerFooter<T: UICollectionReusableView>(_: T.Type, isHeader: Bool) where T: ReusableView, T: NibLoadableView {
      let bundle = Bundle(for: T.self)
      let nib = UINib(nibName: T.nibName, bundle: bundle)
      let viewOfKind = isHeader ? UICollectionView.elementKindSectionHeader : UICollectionView.elementKindSectionFooter
      register(nib, forSupplementaryViewOfKind: viewOfKind, withReuseIdentifier: T.reuseIdentifier)
    }
  
  func registerSupplementaryView<T: UICollectionReusableView>(_: T.Type, viewOfKind: String) where T: ReusableView, T: NibLoadableView {
    let bundle = Bundle(for: T.self)
    let nib = UINib(nibName: T.nibName, bundle: bundle)
    register(nib, forSupplementaryViewOfKind: viewOfKind, withReuseIdentifier: T.reuseIdentifier)
  }
  
  func registerSupplementaryView<T: UICollectionReusableView>(_: T.Type, viewOfKind: String) where T: ReusableView {
    register(T.self, forSupplementaryViewOfKind: viewOfKind, withReuseIdentifier: T.reuseIdentifier)
  }
}
