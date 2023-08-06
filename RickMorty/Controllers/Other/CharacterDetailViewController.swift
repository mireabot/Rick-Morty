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
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    switch indexPath.section {
    case 0: cell.backgroundColor = .systemRed
    case 1: cell.backgroundColor = .systemCyan
    case 2: cell.backgroundColor = .systemGray
    default:
      cell.backgroundColor = .systemBackground
    }
    return cell
  }
}
