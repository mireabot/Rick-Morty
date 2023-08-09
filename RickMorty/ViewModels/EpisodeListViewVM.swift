//
//  EpisodeListViewVM.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/9/23.
//

import UIKit

protocol RMEpisodeListViewViewModelDelegate: AnyObject {
  func didLoadInitialEpisodes()
  func didLoadMoreEpisodes(with newIndexPaths: [IndexPath])
  
  func didSelectEpisode(_ episode: RMEpisode)
}

/// View Model to handle episode list view logic
final class RMEpisodeListViewViewModel: NSObject {
  
  public weak var delegate: RMEpisodeListViewViewModelDelegate?
  
  private var isLoadingMoreEpisodes = false
  
  private let borderColors: [UIColor] = [
    .systemGreen,
    .systemBlue,
    .systemOrange,
    .systemPink,
    .systemPurple,
    .systemRed,
    .systemYellow,
    .systemIndigo,
    .systemMint
  ]
  
  private var episodes: [RMEpisode] = [] {
    didSet {
      for episode in episodes {
        let viewModel = CharacterEpisodesCollectionViewCellVM(episodeURL: URL(string: episode.url))
        if !cellViewModels.contains(viewModel) {
          cellViewModels.append(viewModel)
        }
      }
    }
  }
  
  private var cellViewModels: [CharacterEpisodesCollectionViewCellVM] = []
  
  private var apiInfo: RMGetAllEpisodesResponse.Info? = nil
  
  /// Fetch initial set of episodes (20)
  public func fetchEpisodes() {
    RMService.shared.executeRequest(
      .listEpisodes,
      expecting: RMGetAllEpisodesResponse.self
    ) { [weak self] result in
      switch result {
      case .success(let responseModel):
        let results = responseModel.results
        let info = responseModel.info
        self?.episodes = results
        self?.apiInfo = info
        DispatchQueue.main.async {
          self?.delegate?.didLoadInitialEpisodes()
        }
      case .failure(let error):
        print(String(describing: error))
      }
    }
  }
  
  /// Paginate if additional episodes are needed
  public func fetchAdditionalEpisodes(url: URL) {
    guard !isLoadingMoreEpisodes else {
      return
    }
    isLoadingMoreEpisodes = true
    guard let request = RMRequest(url: url) else {
      isLoadingMoreEpisodes = false
      return
    }
    
    RMService.shared.executeRequest(request, expecting: RMGetAllEpisodesResponse.self) { [weak self] result in
      guard let strongSelf = self else {
        return
      }
      switch result {
      case .success(let responseModel):
        let moreResults = responseModel.results
        let info = responseModel.info
        strongSelf.apiInfo = info
        
        let originalCount = strongSelf.episodes.count
        let newCount = moreResults.count
        let total = originalCount+newCount
        let startingIndex = total - newCount
        let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
          return IndexPath(row: $0, section: 0)
        })
        strongSelf.episodes.append(contentsOf: moreResults)
        
        DispatchQueue.main.async {
          strongSelf.delegate?.didLoadMoreEpisodes(
            with: indexPathsToAdd
          )
          
          strongSelf.isLoadingMoreEpisodes = false
        }
      case .failure(let failure):
        print(String(describing: failure))
        self?.isLoadingMoreEpisodes = false
      }
    }
  }
  
  public var shouldShowLoadMoreIndicator: Bool {
    return apiInfo?.next != nil
  }
}

// MARK: - CollectionView

extension RMEpisodeListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cellViewModels.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CharacterEpisodesCollectionViewCell.cellID,
      for: indexPath
    ) as? CharacterEpisodesCollectionViewCell else {
      fatalError("Unsupported cell")
    }
    cell.configure(with: cellViewModels[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard kind == UICollectionView.elementKindSectionFooter,
          let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: RMFooterCollectionReusableView.id,
            for: indexPath
          ) as? RMFooterCollectionReusableView else {
      fatalError("Unsupported")
    }
    footer.startSpinner()
    return footer
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    guard shouldShowLoadMoreIndicator else {
      return .zero
    }
    
    return CGSize(width: collectionView.frame.width,
                  height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let bounds = collectionView.bounds
    let width = bounds.width-20
    return CGSize(
      width: width,
      height: 100
    )
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    let selection = episodes[indexPath.row]
    delegate?.didSelectEpisode(selection)
  }
}

// MARK: - ScrollView

extension RMEpisodeListViewViewModel: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard shouldShowLoadMoreIndicator,
          !isLoadingMoreEpisodes,
          !cellViewModels.isEmpty,
          let nextUrlString = apiInfo?.next,
          let url = URL(string: nextUrlString) else {
      return
    }
    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
      let offset = scrollView.contentOffset.y
      let totalContentHeight = scrollView.contentSize.height
      let totalScrollViewFixedHeight = scrollView.frame.size.height
      
      if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
        self?.fetchAdditionalEpisodes(url: url)
      }
      t.invalidate()
    }
  }
}
