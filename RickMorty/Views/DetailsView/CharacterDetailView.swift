//
//  CharacterDetailView.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/5/23.
//

import UIKit
import SnapKit

final class CharacterDetailView: UIView {
  
  public var collectionView : UICollectionView?
  
  private let viewModel: CharacterDetailViewVM
  
  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView(style: .large)
    spinner.hidesWhenStopped = true
    
    return spinner
  }()
  
  
  //MARK: - Init
  
  init(frame: CGRect, viewModel: CharacterDetailViewVM) {
    self.viewModel = viewModel
    super.init(frame: frame)
    let collectionView = createCollection()
    self.collectionView = collectionView
    addSubViews(collectionView, spinner)
    createUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Private
  
  private func createUI() {
    guard let collection = collectionView else {
      return
    }
    
    
    spinner.snp.makeConstraints { make in
      make.width.height.equalTo(100)
      make.center.equalToSuperview()
    }
    
    collection.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.bottom.equalToSuperview()
      make.leading.bottom.equalToSuperview().offset(10)
      make.trailing.equalToSuperview().offset(-10)
    }
  }
  
  private func createCollection() -> UICollectionView {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
      return self.createSection(for: sectionIndex)
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(CharacterImageCollectionViewCell.self, forCellWithReuseIdentifier: CharacterImageCollectionViewCell.cellID)
    collectionView.register(CharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: CharacterInfoCollectionViewCell.cellID)
    collectionView.register(CharacterEpisodesCollectionViewCell.self, forCellWithReuseIdentifier: CharacterEpisodesCollectionViewCell.cellID)
    
    return collectionView
  }
  
  private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
    let sections = viewModel.sections
    
    switch sections[sectionIndex] {
    case .image: return viewModel.createImageSectionLayout()
    case .information: return viewModel.createInfoSectionLayout()
    case .episodes: return viewModel.createEpisodeSectionLayout()
    }
  }
}

