//
//  ViewController.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import UIKit

final class TabViewController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
    setupTabs()
  }
  
  // MARK: - Private
  private func setupTabs() {
    let characterVC = CharacterViewController()
    let locationsVC = LocationsViewController()
    let episodesVC = EposidesViewController()
    let settingsVC = SettingsViewController()
    
    characterVC.navigationItem.largeTitleDisplayMode = .automatic
    locationsVC.navigationItem.largeTitleDisplayMode = .automatic
    episodesVC.navigationItem.largeTitleDisplayMode = .automatic
    settingsVC.navigationItem.largeTitleDisplayMode = .automatic
    
    let nav1 = UINavigationController(rootViewController: characterVC)
    let nav2 = UINavigationController(rootViewController: locationsVC)
    let nav3 = UINavigationController(rootViewController: episodesVC)
    let nav4 = UINavigationController(rootViewController: settingsVC)
    
    nav1.tabBarItem = UITabBarItem(title: "Characters",
                                   image: UIImage(systemName: "person.2"),
                                   tag: 1)
    
    nav2.tabBarItem = UITabBarItem(title: "Locations",
                                   image: UIImage(systemName: "globe"),
                                   tag: 2)
    
    nav3.tabBarItem = UITabBarItem(title: "Episodes",
                                   image: UIImage(systemName: "tv"),
                                   tag: 3)
    
    nav4.tabBarItem = UITabBarItem(title: "Settings",
                                   image: UIImage(systemName: "gear"),
                                   tag: 4)
    
    for nav in [nav1, nav2, nav3, nav4] {
      nav.navigationBar.prefersLargeTitles = true
      
    }
    
    setViewControllers([nav1, nav2, nav3, nav4], animated: true)
  }
}
