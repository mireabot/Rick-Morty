//
//  RMAPIChacheManager.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/9/23.
//

import Foundation

final class RMAPIChacheManager {
  private var cacheDic: [RMEndpoint: NSCache<NSString,NSData>] = [:]
  private var cache = NSCache<NSString,NSData>()
  
  init() {
    setup()
  }
  
  public func checkCache(for endpoint: RMEndpoint, url: URL?) -> Data? {
    guard let target = cacheDic[endpoint], let url = url else {
      return nil
    }
    let key = url.absoluteString as NSString
    return target.object(forKey: key) as? Data
  }
  
  public func setChache(for endpoint: RMEndpoint, url: URL?, data: Data) {
    guard let target = cacheDic[endpoint], let url = url else {
      return
    }
    let key = url.absoluteString as NSString
    target.setObject(data as NSData, forKey: key)
  }
  
  private func setup() {
    RMEndpoint.allCases.forEach { endpoint in
      cacheDic[endpoint] = NSCache<NSString,NSData>()
    }
  }
}
