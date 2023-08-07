//
//  CharacterImageCollectionViewCellVM.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/7/23.
//

import Foundation

final class CharacterImageCollectionViewCellVM {
  private let imageURL: URL?
  
  init(imageURL: URL?) {
    self.imageURL = imageURL
  }
  
  public func fetchImage(completion: @escaping(Result<Data, Error>) -> Void) {
    guard let imageURL = imageURL else {
      completion(.failure(URLError(.badURL)))
      return
    }
    RMImageLoader.shared.downloadImage(imageURL, completion: completion)
  }
}
