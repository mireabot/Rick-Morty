//
//  Extensions.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import UIKit

extension UIView {
  func addSubViews(_ views: UIView...) {
    views.forEach({
      addSubview($0)
    })
  }
}
