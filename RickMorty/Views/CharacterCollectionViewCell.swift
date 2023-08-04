//
//  CharacterCollectionViewCell.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import UIKit
import SnapKit

/// Cell for character
final class CharacterCollectionViewCell: UICollectionViewCell {
  static let cellID = "CharacterCollectionViewCell"
  
  private let imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    
    return iv
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 18, weight: .medium)
    label.textColor = .label
    
    return label
  }()
  
  private let statusLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .regular)
    label.textColor = .secondaryLabel
    
    return label
  }()
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .secondarySystemBackground
    createUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
    nameLabel.text = nil
    statusLabel.text = nil
  }
  
  //MARK: - Private
  private func createUI() {
    contentView.addSubViews(imageView, nameLabel, statusLabel)
    
    imageView.snp.makeConstraints { make in
      make.top.left.right.equalToSuperview()
      make.bottom.equalTo(nameLabel.snp.top).offset(-3)
    }
    
    nameLabel.snp.makeConstraints { make in
      make.height.equalTo(40)
      make.left.equalToSuperview().offset(5)
      make.right.equalToSuperview().offset(-5)
      make.bottom.equalTo(statusLabel.snp.top).offset(-3)
    }
    
    statusLabel.snp.makeConstraints { make in
      make.height.equalTo(35)
      make.left.equalToSuperview().offset(5)
      make.right.equalToSuperview().offset(-5)
      make.bottom.equalToSuperview().offset(-3)
    }
  }
  
  //MARK: - Public
  public func configureVM(with model: CharacterCollectionViewCellVM) {
    nameLabel.text = model.characterName
    statusLabel.text = model.characterStatusText
    model.fetchImage { [weak self] result in
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          let image = UIImage(data: data)
          self?.imageView.image = image
        }
      case .failure(let failure):
        print(String(describing: failure))
        break
      }
    }
  }
}
