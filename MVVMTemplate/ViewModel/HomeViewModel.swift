//
//  HomeViewModel.swift
//  MVVMTemplate
//
//  Created by Bhargav BKS on 03/10/2020.
//  Copyright © 2020 Bhargav BKS. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate {
  func reloadTableView()
}

public class HomeViewModel {
  
  // MARK:- Properties
  
  var businessLogic: HomeBusinessLogicDelegate = HomeBusinessLogic()
  private lazy var employees = [Employee]() {
    didSet {
      delegate?.reloadTableView()
    }
  }

  var delegate: HomeViewModelDelegate?
  
  // MARK:- Methods
  
  func loadData() {
    businessLogic.fetchEmployees(success: { [unowned self] response in
      self.employees = response.data
    }, failure: { error in
      print(error)
    })
  }
  
  public func numberOfRows() -> Int {
    return employees.count
  }
  
  public func cellViewModel(with index: Int) -> EmployeeModelHandler {
    return EmployeeCellViewModel(with: employees[index])
  }
}
