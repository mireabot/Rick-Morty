//
//  EpisodeDetailViewVM.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/9/23.
//

import Foundation

class EpisodeDetailViewVM {
  private let endpointUrl: URL?
  
  init(endpointUrl: URL?) {
    self.endpointUrl = endpointUrl
    fetchData()
  }
  
  private func fetchData() {
    guard let url = endpointUrl, let request = RMRequest(url: url) else {
      return
    }
    
    RMService.shared.executeRequest(request, expecting: RMEpisode.self) { result in
      switch result {
      case .success(let model):
        print(String(describing: model))
      case .failure(let failure):
        print(String(describing: failure))
      }
    }
  }
}
