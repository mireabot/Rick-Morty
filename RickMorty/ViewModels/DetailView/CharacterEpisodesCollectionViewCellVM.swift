//
//  CharacterEpisodesCollectionViewCellVM.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/7/23.
//

import Foundation

final class CharacterEpisodesCollectionViewCellVM {
  let episodeURL: URL?
  
  init(episodeURL: URL?) {
    self.episodeURL = episodeURL
  }
}
