//
//  CharacterViewController.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import UIKit

final class CharacterViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setAppearance()
    
    let request = RMRequest(endpoint: .character,path: ["1"], queryParams: [URLQueryItem(name: "name", value: "rick"), URLQueryItem(name: "status", value: "alive")])
    print(request.url)
  }
  
  //MARK: - Private
  
  //MARK: - Public
  
  func setAppearance() {
    view.backgroundColor = .systemBackground
    title = "Characters"
  }
}
