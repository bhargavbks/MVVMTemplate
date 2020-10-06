//
//  HomeBusinessLogic.swift
//  MVVMTemplate
//
//  Created by Bhargav BKS on 06/10/2020.
//  Copyright © 2020 Bhargav BKS. All rights reserved.
//

import Foundation

protocol HomeBusinessLogicDelegate {
  func fetchEmployees(success _success: @escaping Success<Employees>,
                      failure _failure: @escaping Failure)
}

struct HomeBusinessLogic: HomeBusinessLogicDelegate {
  let service = HTTPService.shared
  
  func fetchEmployees(success _success: @escaping Success<Employees>,
                      failure _failure: @escaping Failure) {
    do {
      try service.requestBackend(path: .employees, success: { response in
        _success(response)
      }, failure: { error in
        _failure(error)
      }).resume()
    } catch {
      print(error)
    }
  }
}
