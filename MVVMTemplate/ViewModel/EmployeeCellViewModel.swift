//
//  EmployeeCellViewModel.swift
//  MVVMTemplate
//
//  Created by Bhargav BKS on 06/10/2020.
//  Copyright © 2020 Bhargav BKS. All rights reserved.
//

import Foundation

public protocol EmployeeModelHandler {
  var employee: Employee { get }
}

extension EmployeeModelHandler {
  func name () -> String {
    return employee.name
  }
}

public struct EmployeeCellViewModel: EmployeeModelHandler {
  public var employee: Employee
  
  init(with employee: Employee) {
    self.employee = employee
  }
}
