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
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    
    return collectionView
  }
  
  private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
    let sections = viewModel.sections
    
    switch sections[sectionIndex] {
    case .image: return createImageSectionLayout()
    case .information: return createInfoSectionLayout()
    case .episodes: return createEpisodeSectionLayout()
    }
    
  }
  
  private func createImageSectionLayout() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(
      layoutSize:
        NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(1.0)))
    
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
    
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize:
        NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .absolute(150)),
      subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    
    return section
  }
  
  private func createInfoSectionLayout() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(
      layoutSize:
        NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(1.0)))
    
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
    
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize:
        NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .absolute(150)),
      subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    
    return section
  }
  
  private func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(
      layoutSize:
        NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(1.0)))
    
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
    
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize:
        NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .absolute(150)),
      subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    
    return section
  }
}

