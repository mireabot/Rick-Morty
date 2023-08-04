//
//  RMCharacterResponse.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import Foundation

struct RMCharacterResponse: Codable {
  struct RMCharacterResponseInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
  }
  
  let info: RMCharacterResponseInfo
  let results: [RMCharacter]
}
