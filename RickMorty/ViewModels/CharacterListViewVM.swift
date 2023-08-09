//
//  CharacterListViewVM.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import UIKit

protocol CharacterListViewVMDelegate: AnyObject {
  func didLoadCharacters()
  func didLoadMoreCharacters(with indexes: [IndexPath])
  func didSelectCharacter(_ character: RMCharacter)
}

final class CharacterListViewVM: NSObject {
  
  public weak var delegate: CharacterListViewVMDelegate?
  
  private var isLoadingMore = false
  
  private var characters: [RMCharacter] = [] {
    didSet {
      for character in characters {
        let vm = CharacterCollectionViewCellVM(characterName: character.name, characterStatus: character.status, characterImageUrl: URL(string: character.image))
        if !cellViewModels.contains(vm) {
          cellViewModels.append(vm)
        }
      }
    }
  }
  
  private var cellViewModels: [CharacterCollectionViewCellVM] = []
  
  private var apiInfo: RMCharacterResponse.RMCharacterResponseInfo? = nil
  
  public func fetchCharacters() {
    RMService.shared.executeRequest(.listOfCharacters, expecting: RMCharacterResponse.self) { [weak self] result in
      switch result {
      case .success(let model):
        let results = model.results
        let info = model.info
        self?.characters = results
        self?.apiInfo = info
        DispatchQueue.main.async {
          self?.delegate?.didLoadCharacters()
        }
      case .failure(let failure):
        print(String(describing: failure))
      }
    }
  }
  
  /// Paginate if additional characters are needed
  public func fetchAdditionalCharacters(url: URL) {
    guard !isLoadingMore else {
      return
    }
    isLoadingMore = true
    guard let request = RMRequest(url: url) else {
      isLoadingMore = false
      return
    }
    
    RMService.shared.executeRequest(request, expecting: RMCharacterResponse.self) { [weak self] result in
      guard let strongSelf = self else {
        return
      }
      switch result {
      case .success(let responseModel):
        let moreResults = responseModel.results
        let info = responseModel.info
        strongSelf.apiInfo = info
        
        let originalCount = strongSelf.characters.count
        let newCount = moreResults.count
        let total = originalCount+newCount
        let startingIndex = total - newCount
        let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
          return IndexPath(row: $0, section: 0)
        })
        strongSelf.characters.append(contentsOf: moreResults)
        
        DispatchQueue.main.async {
          strongSelf.delegate?.didLoadMoreCharacters(
            with: indexPathsToAdd
          )
          
          strongSelf.isLoadingMore = false
        }
      case .failure(let failure):
        print(String(describing: failure))
        self?.isLoadingMore = false
      }
    }
  }
  
  public var shouldShowLoadMore: Bool {
    return apiInfo?.next != nil
  }
}

extension CharacterListViewVM: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cellViewModels.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.cellID, for: indexPath) as? CharacterCollectionViewCell else {
      fatalError("Unsupported cell")
    }
    let viewModel = cellViewModels[indexPath.row]
    cell.configureVM(with: viewModel)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard kind == UICollectionView.elementKindSectionFooter else {
      fatalError("Unsupported footer")
    }
    guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RMFooterCollectionReusableView.id, for: indexPath) as? RMFooterCollectionReusableView else {
      fatalError("Unsupported footer")
    }
    footer.startSpinner()
    return footer
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    guard shouldShowLoadMore else {
      return .zero
    }
    return CGSize(width: collectionView.frame.width, height: 100)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let bounds = UIScreen.main.bounds
    let width = (bounds.width - 30)/2
    return CGSize(width: width, height: width * 1.5)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    let character = characters[indexPath.row]
    delegate?.didSelectCharacter(character)
  }
}

extension CharacterListViewVM: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard
      shouldShowLoadMore,
      !isLoadingMore,
      !cellViewModels.isEmpty,
      let nextURL = apiInfo?.next,
      let url = URL(string: nextURL)
    else {
      return
    }
    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
      let offset = scrollView.contentOffset.y
      let totalH = scrollView.contentSize.height
      let scrollFrameH = scrollView.frame.size.height
      
      if offset >= (totalH - scrollFrameH - 120) {
        self?.fetchAdditionalCharacters(url: url)
      }
      t.invalidate()
    }
  }
}
