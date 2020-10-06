//
//  HomeViewModelTests.swift
//  MVVMTemplateTests
//
//  Created by Bhargav BKS on 06/10/2020.
//  Copyright © 2020 Bhargav BKS. All rights reserved.
//

import Foundation
import XCTest
@testable import MVVMTemplate

class MockBusinessLogic: HomeBusinessLogicDelegate {
  var isSuccess: Bool = false
  
  func fetchEmployees(success _success: @escaping Success<Employees>,
                      failure _failure: @escaping Failure) {
    if isSuccess {
      let jsonData = employees.data(using: .utf8)
      let data = try! JSONDecoder().decode(Employees.self, from: jsonData!)
      _success(data)
    } else {
      _failure(AppError.badRequest)
    }
  }
}

class HomeViewModelTests: XCTestCase {
  
  func testViewModel() {
    let viewModel = HomeViewModel()
    let mockLogic = MockBusinessLogic()
    XCTContext.runActivity(named: "Failure Business Logic", block: { _ in
      mockLogic.isSuccess = false
      viewModel.businessLogic = mockLogic
      viewModel.loadData()
      XCTAssertEqual(viewModel.numberOfRows(), 0)
    })

    XCTContext.runActivity(named: "Success Business Logic", block: { _ in
      mockLogic.isSuccess = true
      viewModel.businessLogic = mockLogic
      viewModel.loadData()
      XCTAssertEqual(viewModel.numberOfRows(), 3)
    })
  }
}

