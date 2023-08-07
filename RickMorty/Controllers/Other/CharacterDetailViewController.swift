//
//  CharacterDetailViewController.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/5/23.
//

import UIKit
import SnapKit

class CharacterDetailViewController: UIViewController {
  private let viewModel: CharacterDetailViewVM
  
  private let detailView : CharacterDetailView
  
  //MARK: - Init
  init(vm: CharacterDetailViewVM) {
    self.viewModel = vm
    self.detailView = CharacterDetailView(frame: .zero, viewModel: vm)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    title = viewModel.title
    addShareButton()
    createUI()
    detailView.collectionView?.delegate = self
    detailView.collectionView?.dataSource = self
  }
  
  //MARK: - Private
  private func createUI() {
    view.addSubview(detailView)
    
    detailView.snp.makeConstraints { make in
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
      make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
      make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
    }
  }
  
  private func addShareButton() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonPressed))
  }
}

extension CharacterDetailViewController {
  @objc
  func shareButtonPressed() {
    
  }
}

extension CharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return viewModel.sections.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let sectionType = viewModel.sections[section]
    switch sectionType {
    case .image:
      return 1
    case .information(let viewModels):
      return viewModels.count
    case .episodes(let viewModels):
      return viewModels.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let sectionType = viewModel.sections[indexPath.section]
    switch sectionType {
    case .image(let viewModel):
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterImageCollectionViewCell.cellID, for: indexPath) as? CharacterImageCollectionViewCell else {
        fatalError()
      }
      cell.configure(with: viewModel)
      cell.backgroundColor = .systemRed
      return cell
    case .information(let viewModels):
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterInfoCollectionViewCell.cellID, for: indexPath) as? CharacterInfoCollectionViewCell else {
        fatalError()
      }
      cell.configure(with: viewModels[indexPath.row])
      cell.backgroundColor = .systemBlue
      return cell
    case .episodes(let viewModels):
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterEpisodesCollectionViewCell.cellID, for: indexPath) as? CharacterEpisodesCollectionViewCell else {
        fatalError()
      }
      cell.configure(with: viewModels[indexPath.row])
      cell.backgroundColor = .systemCyan
      return cell
    }
  }
}
