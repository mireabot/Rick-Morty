//
//  CharacterInfoCollectionViewCellVM.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/7/23.
//

import Foundation

final class CharacterInfoCollectionViewCellVM {
  public let value: String
  public let title: String
  
  init(
    value: String,
    title: String
  ) {
    self.value = value
    self.title = title
  }
}
