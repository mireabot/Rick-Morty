//
//  EpisodeListView.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/9/23.
//

import UIKit
import SnapKit

protocol EpisodeListViewDelegate: AnyObject {
  func episodeListView(_ episodeList: EpisodeListView, didSelect episode: RMEpisode)
}

/// View which shows list of characters and loader
final class EpisodeListView: UIView {
  
  public weak var delegate: EpisodeListViewDelegate?
  
  private let viewModel = RMEpisodeListViewViewModel()
  
  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView(style: .large)
    spinner.hidesWhenStopped = true
    
    return spinner
  }()
  
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.isHidden = true
    collection.alpha = 0
    collection.register(
      CharacterEpisodesCollectionViewCell.self,
      forCellWithReuseIdentifier: CharacterEpisodesCollectionViewCell.cellID)
    collection.register(RMFooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterCollectionReusableView.id)
    
    return collection
  }()
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    createUI()
    spinner.startAnimating()
    viewModel.delegate = self
    viewModel.fetchEpisodes()
    setCollection()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  
  func createUI() {
    addSubViews(collectionView, spinner)
    
    spinner.snp.makeConstraints { make in
      make.width.height.equalTo(100)
      make.center.equalToSuperview()
    }
    
    collectionView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.bottom.equalToSuperview()
      make.leading.bottom.equalToSuperview().offset(10)
      make.trailing.equalToSuperview().offset(-10)
    }
  }
  
  private func setCollection() {
    collectionView.dataSource = viewModel
    collectionView.delegate = viewModel
  }
}

extension EpisodeListView: RMEpisodeListViewViewModelDelegate {
  func didLoadInitialEpisodes() {
    spinner.stopAnimating()
    collectionView.isHidden = false
    collectionView.reloadData()
    UIView.animate(withDuration: 0.4) {
      self.collectionView.alpha = 1
    }
  }
  
  func didLoadMoreEpisodes(with newIndexPaths: [IndexPath]) {
    collectionView.performBatchUpdates {
      self.collectionView.insertItems(at: newIndexPaths)
    }
  }
  
  func didSelectEpisode(_ episode: RMEpisode) {
    delegate?.episodeListView(self, didSelect: episode)
  }
}

