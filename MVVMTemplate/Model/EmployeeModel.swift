//
//  EmployeeModel.swift
//  MVVMTemplate
//
//  Created by Bhargav BKS on 06/10/2020.
//  Copyright © 2020 Bhargav BKS. All rights reserved.
//

import Foundation

public struct Employees: Decodable {
  let status: String
  let data: [Employee]
}

public struct Employee: Decodable {
  let id: String
  let name: String
  let salary: String
  let age: String
  let image: String
  
  private enum CodingKeys: String, CodingKey {
    case id
    case name = "employee_name"
    case salary = "employee_salary"
    case age = "employee_age"
    case image = "profile_image"
  }
}
