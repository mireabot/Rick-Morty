//
//  SceneDelegate.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    let vc = TabViewController()
    
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = vc
    window.makeKeyAndVisible()
    
    self.window = window
  }
}

