//
//  CharacterViewController.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import UIKit

final class CharacterViewController: UIViewController {
  
  private let characterListView = CharacterListView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setAppearance()
    addViews()
  }
  
  //MARK: - Private
  
  func addViews() {
    view.addSubview(characterListView)
    characterListView.snp.makeConstraints { make in
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
      make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
      make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
    }
  }
  
  //MARK: - Public
  func setAppearance() {
    view.backgroundColor = .systemBackground
    title = "Characters"
  }
}
