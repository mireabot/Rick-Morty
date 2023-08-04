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
  
  enum ServiceError: Error {
    case failedToCreateRequest
    case failedToGetData
  }
  
  public func exacuteRequest<T: Codable>(_ request: RMRequest,
                                         expecting type: T.Type,
                                         completion: @escaping (Result<T, Error>) -> Void
  ) {
    guard let urlRequest = self.request(from: request) else {
      completion(.failure(ServiceError.failedToCreateRequest))
      return
    }
    
    let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
      guard let data = data, error == nil else {
        completion(.failure(error ?? ServiceError.failedToGetData))
        return
      }
      
      do {
        let json = try JSONDecoder().decode(type.self, from: data)
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
