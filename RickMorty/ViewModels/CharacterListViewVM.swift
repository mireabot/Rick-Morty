//
//  CharacterListViewVM.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import UIKit

protocol CharacterListViewVMDelegate: AnyObject {
  func didLoadCharacters()
}

final class CharacterListViewVM: NSObject {
  
  public weak var delegate: CharacterListViewVMDelegate?
  
  private var characters: [RMCharacter] = [] {
    didSet {
      for character in characters {
        let vm = CharacterCollectionViewCellVM(characterName: character.name, characterStatus: character.status, characterImageUrl: URL(string: character.image))
        cellViewModels.append(vm)
      }
    }
  }
  
  private var cellViewModels: [CharacterCollectionViewCellVM] = []
  
  public func fetchCharacters() {
    RMService.shared.exacuteRequest(.listOfCharacters, expecting: RMCharacterResponse.self) { [weak self] result in
      switch result {
      case .success(let model):
        let results = model.results
        self?.characters = results
        DispatchQueue.main.async {
          self?.delegate?.didLoadCharacters()
        }
      case .failure(let failure):
        print(String(describing: failure))
      }
    }
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
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let bounds = UIScreen.main.bounds
    let width = (bounds.width - 30)/2
    return CGSize(width: width, height: width * 1.5)
  }
}
