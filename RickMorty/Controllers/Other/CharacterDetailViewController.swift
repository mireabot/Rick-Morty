//
//  CharacterDetailViewController.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/5/23.
//

import UIKit

class CharacterDetailViewController: UIViewController {
  private let viewModel: CharacterDetailViewVM
  
  init(vm: CharacterDetailViewVM) {
    self.viewModel = vm
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = viewModel.title
  }
}
