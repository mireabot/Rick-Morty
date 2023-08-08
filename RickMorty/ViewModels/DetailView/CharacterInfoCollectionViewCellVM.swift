//
//  CharacterInfoCollectionViewCellVM.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/7/23.
//

import UIKit

final class CharacterInfoCollectionViewCellVM {
  private let type: `Type`
  
  private let value: String
  
  static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
    formatter.timeZone = .current
    
    return formatter
  }()
  
  static let displayDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, yyyy"
    
    return formatter
  }()
  
  public var title: String {
    type.display
  }
  
  public var displayTitle: String {
    if value.isEmpty {
      return "None"
    }
    
    if let date = Self.dateFormatter.date(from: value), type == .created {
      return Self.displayDateFormatter.string(from: date)
    }
    
    return value
  }
  
  public var iconImage: UIImage? {
    return type.icon
  }
  
  enum `Type`: String {
    case status
    case gender
    case type
    case species
    case origin
    case created
    case location
    case episodes
    
    var icon: UIImage? {
      switch self {
      case .status:
        return UIImage(systemName: "info")
      case .gender:
        return UIImage(systemName: "figure.arms.open")
      case .type:
        return UIImage(systemName: "tropicalstorm")
      case .species:
        return UIImage(systemName: "atom")
      case .origin:
        return UIImage(systemName: "house")
      case .created:
        return UIImage(systemName: "clock")
      case .location:
        return UIImage(systemName: "globe.americas")
      case .episodes:
        return UIImage(systemName: "tv")
      }
    }
    
    var display: String {
      switch self {
      case .status,
          .gender,
          .type,
          .species,
          .origin,
          .created,
          .location:
        return rawValue.capitalized
      case .episodes:
        return "Episodes count"
      }
    }
  }
  
  init(
    type: `Type`,
    value: String
  ) {
    self.value = value
    self.type = type
  }
}
