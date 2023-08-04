//
//  LocationsViewController.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import UIKit

final class LocationsViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setAppearance()
  }
  
  //MARK: - Private
  
  //MARK: - Public
  
  func setAppearance() {
    view.backgroundColor = .systemBackground
    title = "Locations"
  }
}
