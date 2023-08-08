//
//  CharacterEpisodesCollectionViewCell.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/7/23.
//

import UIKit
import SnapKit

final class CharacterEpisodesCollectionViewCell: UICollectionViewCell {
  static let cellID = "CharacterEpisodesCollectionViewCell"
  
  private let seasonLabel: UILabel = {
    let label = UILabel()
    label.text = "Earth"
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 20, weight: .semibold)
    
    return label
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Location"
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 18, weight: .regular)
    
    return label
  }()
  
  private let dateLabel: UILabel = {
    let label = UILabel()
    label.text = "Earth"
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 18, weight: .light)
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .systemBackground
    contentView.layer.cornerRadius = 8
    contentView.layer.borderWidth = 2
    contentView.layer.borderColor = UIColor.lightGray.cgColor
    createUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func createUI() {
    contentView.addSubViews(nameLabel, seasonLabel, dateLabel)
    
    nameLabel.snp.makeConstraints { make in
      make.top.equalTo(seasonLabel.snp.bottom)
      make.left.right.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.3)
    }
    
    seasonLabel.snp.makeConstraints { make in
      make.top.left.right.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.3)
    }
    
    dateLabel.snp.makeConstraints { make in
      make.top.equalTo(nameLabel.snp.bottom)
      make.left.right.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.3)
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    nameLabel.text = nil
    seasonLabel.text = nil
    dateLabel.text = nil
  }
  
  public func configure(with vm: CharacterEpisodesCollectionViewCellVM) {
    vm.registerForData { [weak self] data in
      self?.nameLabel.text = data.name
      self?.seasonLabel.text = "Episode "+data.episode
      self?.dateLabel.text = "Aired on "+data.air_date
    }
    vm.fetchEpisode()
  }
}
