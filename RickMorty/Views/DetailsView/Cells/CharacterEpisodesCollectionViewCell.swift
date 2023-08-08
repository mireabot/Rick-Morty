//
//  CharacterEpisodesCollectionViewCell.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/7/23.
//

import UIKit

final class CharacterEpisodesCollectionViewCell: UICollectionViewCell {
  static let cellID = "CharacterEpisodesCollectionViewCell"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .systemCyan
    contentView.layer.cornerRadius = 8
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func createUI() {
    
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  public func configure(with vm: CharacterEpisodesCollectionViewCellVM) {
    vm.registerForData { data in
      print(data.name)
      print(data.episode)
      print(data.air_date)
    }
    vm.fetchEpisode()
  }
}
