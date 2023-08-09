//
//  RMEndpoint.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import Foundation


@frozen enum RMEndpoint: String, Hashable, CaseIterable {
  case character
  case location
  case episode
}
