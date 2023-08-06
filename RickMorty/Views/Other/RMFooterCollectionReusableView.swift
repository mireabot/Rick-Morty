//
//  RMFooterCollectionReusableView.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/5/23.
//

import UIKit
import SnapKit

final class RMFooterCollectionReusableView: UICollectionReusableView {
  static let id = "RMFooterCollectionReusableView"
  
  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView(style: .large)
    spinner.hidesWhenStopped = true
    
    return spinner
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
    createUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func createUI() {
    addSubview(spinner)
    spinner.snp.makeConstraints { make in
      make.width.height.equalTo(100)
      make.center.equalToSuperview()
    }
  }
  
  public func startSpinner() {
    spinner.startAnimating()
  }
}
