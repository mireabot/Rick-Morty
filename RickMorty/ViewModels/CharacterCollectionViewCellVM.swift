//
//  CharacterCollectionViewCellVM.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import Foundation

final class CharacterCollectionViewCellVM: Hashable, Equatable {
  
  let characterName: String
  private let characterStatus: RMCharacterStatus
  private let characterImageUrl: URL?
  
  static func == (lhs: CharacterCollectionViewCellVM, rhs: CharacterCollectionViewCellVM) -> Bool {
    return lhs.hashValue == rhs.hashValue
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(characterName)
    hasher.combine(characterStatus)
    hasher.combine(characterImageUrl)
  }
  
  init(
    characterName: String,
    characterStatus: RMCharacterStatus,
    characterImageUrl: URL?
  ) {
    self.characterName = characterName
    self.characterStatus = characterStatus
    self.characterImageUrl = characterImageUrl
  }
  
  public var characterStatusText: String {
    return "Status: \(characterStatus.text)"
  }
  
  public func fetchImage(completion: @escaping(Result<Data, Error>) -> Void) {
    guard let url = characterImageUrl else {
      completion(.failure(URLError(.badURL)))
      return
    }
    let request = URLRequest(url: url)
    RMImageLoader.shared.downloadImage(url, completion: completion)
  }
}
