//
//  CharacterEpisodesCollectionViewCellVM.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/7/23.
//

import Foundation

protocol EpisodeDataRender {
  var episode: String { get }
  var name: String { get }
  var air_date: String { get }
}

final class CharacterEpisodesCollectionViewCellVM {
  let episodeURL: URL?
  
  private var isFetching = false
  
  private var dataBlock: ((EpisodeDataRender)-> Void)?
  
  private var episode: RMEpisode? {
    didSet {
      guard let model = episode else {
        return
      }
      self.dataBlock?(model)
    }
  }
  
  
  
  init(episodeURL: URL?) {
    self.episodeURL = episodeURL
  }
  
  public func registerForData(_ block: @escaping(EpisodeDataRender) -> Void) {
    self.dataBlock = block
  }
  
  public func fetchEpisode() {
    guard !isFetching else {
      if let model = episode {
        self.dataBlock?(model)
      }
      return
    }
    guard let url = episodeURL, let request = RMRequest(url: url) else {
      return
    }
    
    isFetching = true
    
    RMService.shared.exacuteRequest(request, expecting: RMEpisode.self) { [weak self] result in
      switch result {
      case .success(let model):
        DispatchQueue.main.async {
          self?.episode = model
        }
      case .failure(let failure):
        print(String(describing: failure))
      }
    }
  }
}
