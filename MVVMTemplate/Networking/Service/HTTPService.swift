//
//  HTTPService.swift
//  MVVMTemplate
//
//  Created by Bhargav BKS on 03/10/2020.
//  Copyright © 2020 Bhargav BKS. All rights reserved.
//

import Foundation

public typealias Success<T> = (T) -> ()
public typealias Failure = (AppError) -> ()

public class Service {

  // MARK: - Properties
  
  private static var instance: Service! = nil
  
  public static var shared: Service {
    get {
      if instance == nil {
        instance = Service()
      }
      return instance
    }
  }
  
  private let urlSession = URLSession.shared
  
  // MARK: - Methods
  
  public func requestBackend<T: Decodable> (for httpMethod: HTTPMethod,
                                            path: Path,
                                            queryParams paramter: QueryParameters? = nil,
                                            httpBody body: Data? = nil,
                                            success _success: @escaping Success<T>,
                                            failure _failure: @escaping Failure) throws -> URLSessionDataTask {
    let success: Success<T> = { response in
      DispatchQueue.main.async {
        _success(response)
      }
    }
    
    let failure: Failure = { error in
      DispatchQueue.main.async {
        _failure(error)
      }
    }
    
    guard let request = try? HTTPRequest.configure(for: path,
                                                   httpBody: body,  method: .post) else {
      throw AppError.missingURL
    }
    return urlSession.dataTask(with: request, completionHandler: {data, response, error in
      
      guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 else {
        if let error = error as NSError? {
          failure(AppError(with: error))
        } else {
          failure(AppError(response: response))
        }
        return
      }
      
      guard let data = data,
            let formattedResult = try? JSONDecoder().decode(T.self, from: data) else {
        failure(AppError.dataFormatError)
        return
      }
      success(formattedResult)
    })
  }
  
  public func cancel() {
    urlSession.invalidateAndCancel()
  }
  
}
