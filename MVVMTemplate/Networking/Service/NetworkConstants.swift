//
//  NetworkConstants.swift
//  MVVMTemplate
//
//  Created by Bhargav BKS on 03/10/2020.
//  Copyright © 2020 Bhargav BKS. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case delete = "DELETE"
}

public enum Path: String {
  case login = "login"
}

public enum AppError: Int, Error {
  case badRequest = 400
  case unAuthorised = 401
  case forbidden = 403
  case notFound = 405
  case requestTimeOut = 408
  case internalServerError = 500
  case badGateway = 502
  case serviceUnavailable = 503
  case gatewayTimeOut = 504
  case missingURL = 1000
  case missingHeaders = 1001
  case missingParameters = 1002
  case dataFormatError = 1003
  case encodingFailed = 1004
  case problemWithRequest = 1005
  case unknown = 1006
  
  init(with error: NSError) {
    self = AppError(rawValue: error.code) ?? .unknown
  }
  
  init(response: URLResponse?) {
    if let response = response as? HTTPURLResponse {
      self = AppError(rawValue: response.statusCode) ?? .unknown
    } else {
      self = .unknown
    }
  }
  
  var localizedDescription: String {
    switch self {
      case .badRequest:
        return "Bad request!"
      case .unAuthorised:
        return "Authentication Error Occurred!"
      case .forbidden:
        return "Request forbidden!"
      case .notFound:
        return "Problem with server!"
      case .requestTimeOut:
        return "Connection timed out!"
      case .internalServerError, .badGateway, .serviceUnavailable, .gatewayTimeOut:
        return "Sorry, couldn't reach servers!"
      case .encodingFailed:
        return "Problem in encoding headers & parameters"
      case .missingURL:
        return "Url is missing."
      case .missingHeaders:
        return "Headers are missing."
      case .missingParameters:
        return "Paramters are missing."
      case .dataFormatError:
        return "Problem in formating data."
      default:
        return "Sorry, couldn't reach servers!"
    }
  }
}
