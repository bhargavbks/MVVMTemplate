//
//  HTTPRequest.swift
//  MVVMTemplate
//
//  Created by Bhargav BKS on 03/10/2020.
//  Copyright © 2020 Bhargav BKS. All rights reserved.
//

import Foundation

public typealias Headers = [String: String]
public typealias QueryParameters = [String: String]

struct HTTPRequest {
  
  // MARK: - Properties
  
  // MARK: - Methods
  
  static func configure(for path: Path,
                        queryParams parameters: QueryParameters? = nil,
                        httpBody body: Data? = nil,
                        method: HTTPMethod = .get) throws -> URLRequest {
    
    let env = Environment()
    var urlComponents = URLComponents(string: "\(env.config(.baseUrl))\(path.rawValue)")
    if method == .get {
      if let params = parameters {
        var items = [URLQueryItem]()
        for (key, value) in params {
          items.append(URLQueryItem(name: key, value: value))
        }
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
          urlComponents?.queryItems = items
        }
      }
    }
    
    guard let url = urlComponents?.url else {
      throw AppError.missingURL
    }

    var request = URLRequest(url: url)
    if method == .post {
      request.httpBody = body
    }
    
    request.httpMethod = method.rawValue
    let appHeaders: Headers = [
      "applicationToken": env.config(.applicationToken),
      "Content-Type": "application/json",
      "Accept": "application/json"
    ]
    request.allHTTPHeaderFields = appHeaders
    return request
  }
}
