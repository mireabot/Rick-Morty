//
//  CharacterImageCollectionViewCell.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/7/23.
//

import UIKit
import SnapKit

final class CharacterImageCollectionViewCell: UICollectionViewCell {
  static let cellID = "CharacterImageCollectionViewCell"
  
  private let imageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.layer.cornerRadius = 8
    
    return iv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    createUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func createUI() {
    contentView.addSubview(imageView)
    
    imageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
  }
  
  public func configure(with vm: CharacterImageCollectionViewCellVM) {
    vm.fetchImage { [weak self] result in
      switch result {
      case .success(let data):
        DispatchQueue.main.async {
          self?.imageView.image = UIImage(data: data)
        }
      case .failure:
        break
      }
    }
  }
}
