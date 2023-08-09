//
//  EposidesViewController.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import UIKit

final class EposidesViewController: UIViewController {
  private let episodeListView = EpisodeListView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setAppearance()
    addViews()
  }
  
  //MARK: - Private
  
  func addViews() {
    episodeListView.delegate = self
    view.addSubview(episodeListView)
    episodeListView.snp.makeConstraints { make in
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
      make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
      make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
    }
  }
  
  //MARK: - Public
  
  func setAppearance() {
    view.backgroundColor = .systemBackground
    title = "Episodes"
  }
}

extension EposidesViewController: EpisodeListViewDelegate {
  func episodeListView(_ episodeList: EpisodeListView, didSelect episode: RMEpisode) {
    let detailVC = EpisodeDetailViewController(url: URL(string: episode.url))
    navigationController?.pushViewController(detailVC, animated: true)
  }
}
