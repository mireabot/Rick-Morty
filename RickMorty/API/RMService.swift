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
  
  public func exacuteRequest<T: Codable>(_ request: RMRequest,
                                         expecting type: T.Type,
                                         completion: @escaping (Result<T, Error>) -> Void) {
    
  }
}
