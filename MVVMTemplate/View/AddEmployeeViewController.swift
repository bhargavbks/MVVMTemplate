//
//  AddEmployeeViewController.swift
//  MVVMTemplate
//
//  Created by Bhargav BKS on 07/10/2020.
//  Copyright © 2020 Bhargav BKS. All rights reserved.
//

import UIKit

class AddEmployeeViewController: BaseViewController {
  
  // MARK:- IBOUTLETS
  
  @IBOutlet weak var name: UITextField!
  
  @IBOutlet weak var salary: UITextField!
  
  @IBOutlet weak var age: UITextField!

  // MARK:- VIEW LIFE CYCLE

  override func viewDidLoad() {
      super.viewDidLoad()
  }
}
