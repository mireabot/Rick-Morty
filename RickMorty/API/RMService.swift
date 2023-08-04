//
//  RMService.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import Foundation


final class RMService {
  static let shared = RMService()
  
  private init () {}
  
  public func exacuteRequest(_ request: RMRequest, completion: @escaping () -> Void) {
    
  }
}
