//
//  CharacterListViewVM.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import UIKit

final class CharacterListViewVM: NSObject {
  func fetchCharacters() {
    RMService.shared.exacuteRequest(.listOfCharacters, expecting: RMCharacterResponse.self) { result in
      switch result {
      case .success(let model):
        print(String(describing: model))
      case .failure(let failure):
        print(String(describing: failure))
      }
    }
  }
}

extension CharacterListViewVM: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 20
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = .systemRed
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let bounds = UIScreen.main.bounds
    let width = (bounds.width - 30)/2
    return CGSize(width: width, height: width * 1.5)
  }
}
