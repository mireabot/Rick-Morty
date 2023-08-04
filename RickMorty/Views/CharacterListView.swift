//
//  CharacterListView.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import UIKit
import SnapKit

/// View which shows list of characters and loader
final class CharacterListView: UIView {
  
  private let viewModel = CharacterListViewVM()
  
  private let spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView(style: .large)
    spinner.hidesWhenStopped = true
    
    return spinner
  }()
  
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.isHidden = true
    collection.alpha = 0
    collection.register(
      CharacterCollectionViewCell.self,
      forCellWithReuseIdentifier: CharacterCollectionViewCell.cellID)
    
    return collection
  }()
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    createUI()
    spinner.startAnimating()
    viewModel.fetchCharacters()
    setCollection()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  
  func createUI() {
    addSubViews(collectionView, spinner)
    
    spinner.snp.makeConstraints { make in
      make.width.height.equalTo(100)
      make.center.equalToSuperview()
    }
    
    collectionView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.bottom.equalToSuperview()
      make.leading.equalToSuperview().offset(10)
      make.trailing.equalToSuperview().offset(-10)
    }
  }
  
  private func setCollection() {
    collectionView.dataSource = viewModel
    collectionView.delegate = viewModel
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.spinner.stopAnimating()
      
      self.collectionView.isHidden = false
      
      UIView.animate(withDuration: 0.4) {
        self.collectionView.alpha = 1
      }
    }
  }
}
