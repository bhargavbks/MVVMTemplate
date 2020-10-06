//
//  EmployeeTableViewCell.swift
//  MVVMTemplate
//
//  Created by Bhargav BKS on 06/10/2020.
//  Copyright © 2020 Bhargav BKS. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
  
  // MARK:- Properties
  var viewModel: EmployeeModelHandler!
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var name: UILabel!
  

  override func awakeFromNib() {
      super.awakeFromNib()
  }
  
  // MARK:- Methods
  
  func configure() {
    self.name.text = viewModel.employee.name
  }
}
