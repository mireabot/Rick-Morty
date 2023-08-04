//
//  RMRequest.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import Foundation

final class RMRequest {
  private struct Constants {
    static let baseURL = "https://rickandmortyapi.com/api/"
  }
  
  private let endpoint: RMEndpoint
  private let path: Set<String>
  private let queryParams: [URLQueryItem]
  
  private var urlString: String {
    var str = Constants.baseURL
    str += endpoint.rawValue
    if !path.isEmpty {
      path.forEach({
        str += "/\($0)"
      })
    }
    
    if !queryParams.isEmpty {
      str += "?"
      let argStr = queryParams.compactMap({
        guard let value = $0.value else { return nil}
        return "\($0.name)=\(value)"
      }).joined(separator: "&")
      
      str += argStr
    }
    return str
  }
  
  public var url: URL? {
    return URL(string: urlString)
  }
  
  public let httpMethod = "GET"
  
  public init(endpoint: RMEndpoint,
              path: Set<String> = [],
              queryParams: [URLQueryItem] = []
  ) {
    self.endpoint = endpoint
    self.path = path
    self.queryParams = queryParams
  }
}
