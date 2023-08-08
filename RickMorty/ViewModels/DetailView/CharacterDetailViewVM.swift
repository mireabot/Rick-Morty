//
//  CharacterDetailViewVM.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/5/23.
//

import UIKit

final class CharacterDetailViewVM {
  private let character: RMCharacter
  
  public var episodes: [String] {
    character.episode
  }
  
  enum SectionTypes {
    case image(viewModel: CharacterImageCollectionViewCellVM)
    case information(viewModels: [CharacterInfoCollectionViewCellVM])
    case episodes(viewModels: [CharacterEpisodesCollectionViewCellVM])
  }
  
  public var sections : [SectionTypes] = []
  
  init(character: RMCharacter) {
    self.character = character
    setupSections()
  }
  
  private func setupSections() {
    sections = [
      .image(viewModel: .init(imageURL: URL(string: character.image))),
      .information(viewModels: [
        .init(type: .status, value: character.status.text),
        .init(type: .gender, value: character.gender.rawValue),
        .init(type: .type, value: character.type),
        .init(type: .species, value: character.species),
        .init(type: .origin, value: character.origin.name),
        .init(type: .location, value: character.location.name),
        .init(type: .created, value: character.created),
        .init(type: .episodes, value: "\(character.episode.count)")
      ]
      ),
      .episodes(viewModels: character.episode.compactMap({
        return CharacterEpisodesCollectionViewCellVM(episodeURL: URL(string: $0))
      }))
    ]
  }
  
  public var requestURL: URL? {
    return URL(string: character.url)
  }
  
  public var title: String {
    character.name.uppercased()
  }
  
  //MARK: - Layout
  
  public func createImageSectionLayout() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(
      layoutSize:
        NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(1.0)))
    
    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
    
    let group = NSCollectionLayoutGroup.vertical(
      layoutSize:
        NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(0.5)),
      subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    
    return section
  }
  
  public func createInfoSectionLayout() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(
      layoutSize:
        NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(0.5),
          heightDimension: .fractionalHeight(1.0)))
    
    item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
    
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize:
        NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .absolute(150)),
      subitems: [item, item])
    
    let section = NSCollectionLayoutSection(group: group)
    
    return section
  }
  
  public func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutItem(
      layoutSize:
        NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(1.0)))
    
    item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 2, bottom: 10, trailing: 10)
    
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize:
        NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(0.8),
          heightDimension: .absolute(150)),
      subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPaging
    
    return section
  }
}
