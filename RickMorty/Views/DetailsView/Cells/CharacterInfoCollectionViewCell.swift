//
//  CharacterInfoCollectionViewCell.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/7/23.
//

import UIKit
import SnapKit

final class CharacterInfoCollectionViewCell: UICollectionViewCell {
  static let cellID = "CharacterInfoCollectionViewCell"
  
  private let valueLabel: UILabel = {
    let label = UILabel()
    label.text = "Earth"
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 18, weight: .regular)
    
    return label
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Location"
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 18, weight: .medium)
    
    return label
  }()
  
  private let iconimageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    iv.image = UIImage(systemName: "globe.americas")
    
    return iv
  }()
  
  private let titleContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .opaqueSeparator
    view.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8)
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .secondarySystemBackground
    contentView.layer.cornerRadius = 8
    contentView.layer.masksToBounds = true
    createUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func createUI() {
    contentView.addSubViews(titleContainerView, valueLabel, iconimageView)
    titleContainerView.addSubview(titleLabel)
    
    titleContainerView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.33)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.edges.equalTo(titleContainerView)
    }
    
    valueLabel.snp.makeConstraints { make in
      make.left.right.equalToSuperview()
      make.top.equalTo(iconimageView.snp.bottom).offset(5)
    }
    
    iconimageView.snp.makeConstraints { make in
      make.height.width.equalTo(35)
      make.top.equalToSuperview().offset(10)
      make.left.equalToSuperview().offset(10)
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    //valueLabel.text = nil
    //titleLabel.text = nil
    //IconimageView.image = nil
  }
  
  public func configure(with vm: CharacterInfoCollectionViewCellVM) {
    
  }
}
