//
//  EpisodeDetailViewController.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/8/23.
//

import UIKit

final class EpisodeDetailViewController: UIViewController {
  
  private let url: URL?
  
  init(url: URL?) {
    self.url = url
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Episode"
    view.backgroundColor = .systemCyan
  }
}
