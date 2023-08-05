//
//  CharacterDetailViewVM.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/5/23.
//

import Foundation

final class CharacterDetailViewVM {
  private let character: RMCharacter
   
  init(character: RMCharacter) {
    self.character = character
  }
  
  public var title: String {
    character.name.uppercased()
  }
}
