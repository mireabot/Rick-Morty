//
//  CharacterDetailViewVM.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/5/23.
//

import Foundation

final class CharacterDetailViewVM {
  private let character: RMCharacter
  
  enum sectionTypes: CaseIterable {
    case image
    case information
    case episodes
  }
  
  public let sections = sectionTypes.allCases
  
  init(character: RMCharacter) {
    self.character = character
  }
  
  public var requestURL: URL? {
    return URL(string: character.url)
  }
  
  public var title: String {
    character.name.uppercased()
  }
}
