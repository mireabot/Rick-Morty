//
//  CharacterInfoCollectionViewCell.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/7/23.
//

import UIKit

final class CharacterInfoCollectionViewCell: UICollectionViewCell {
  static let cellID = "CharacterInfoCollectionViewCell"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .secondarySystemBackground
    contentView.layer.cornerRadius = 15
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func createUI() {
    
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  public func configure(with vm: CharacterInfoCollectionViewCellVM) {
    
  }
}
