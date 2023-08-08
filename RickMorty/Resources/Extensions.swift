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

extension UIView{
  
  enum RoundCornersAt{
    case topRight
    case topLeft
    case bottomRight
    case bottomLeft
  }
  
  //multiple corners using CACornerMask
  func roundCorners(corners:[RoundCornersAt], radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.layer.maskedCorners = [
      corners.contains(.topRight) ? .layerMaxXMinYCorner:.init(),
      corners.contains(.topLeft) ? .layerMinXMinYCorner:.init(),
      corners.contains(.bottomRight) ? .layerMaxXMaxYCorner:.init(),
      corners.contains(.bottomLeft) ? .layerMinXMaxYCorner:.init(),
    ]
  }
}
