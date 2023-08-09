//
//  RMService.swift
//  RickMorty
//
//  Created by Mikhail Kolkov on 8/4/23.
//

import Foundation


final class RMService {
  static let shared = RMService()
  
  private let cacheManager = RMAPIChacheManager()
  
  private init () {}
  
  enum ServiceError: Error {
    case failedToCreateRequest
    case failedToGetData
  }
  
  public func executeRequest<T: Codable>(_ request: RMRequest,
                                         expecting type: T.Type,
                                         completion: @escaping (Result<T, Error>) -> Void
  ) {
    
    if let chacheData = cacheManager.checkCache(for: request.endpoint, url: request.url) {
      print("Cached")
      do {
        let json = try JSONDecoder().decode(type.self, from: chacheData)
        completion(.success(json))
      }
      catch {
        completion(.failure(error))
      }
      return
    }
    guard let urlRequest = self.request(from: request) else {
      completion(.failure(ServiceError.failedToCreateRequest))
      return
    }
    
    
    let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
      guard let data = data, error == nil else {
        completion(.failure(error ?? ServiceError.failedToGetData))
        return
      }
      
      do {
        let json = try JSONDecoder().decode(type.self, from: data)
        self?.cacheManager.setChache(for: request.endpoint, url: request.url, data: data)
        completion(.success(json))
      }
      catch {
        completion(.failure(error))
      }
    }
    task.resume()
  }
  
  //MARK: - Private
  
  private func request(from request: RMRequest) -> URLRequest? {
    guard let url = request.url else { return nil }
    var req = URLRequest(url: url)
    req.httpMethod = request.httpMethod
    
    return req
  }
}
