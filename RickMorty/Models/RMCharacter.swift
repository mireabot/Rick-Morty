//
//  RMCharacter.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import Foundation

struct RMCharacter: Codable {
  let id: Int
  let name: String
  let status: RMCharacterStatus
  let species: String
  let type: String
  let gender: RMCharacterGender
  let origin: RMOrigin
  let location: RMCharacterLocation
  let image: String
  let episode: [String]
  let url: String
  let created: String
}

struct RMOrigin: Codable {
  let name: String
  let url: String
}

struct RMCharacterLocation: Codable {
  let name: String
  let url: String
}

enum RMCharacterStatus: String, Codable {
  case alive = "Alive"
  case dead = "Dead"
  case `unknown` = "unknown"
  
  var text: String {
    switch self {
    case .alive:
      return rawValue
    case .dead:
      return rawValue
    case .unknown:
      return "Unknown"
    }
  }
}

enum RMCharacterGender: String, Codable {
  case male = "Male"
  case female = "Female"
  case genderless = "Genderless"
  case `unknown` = "unknown"
}
