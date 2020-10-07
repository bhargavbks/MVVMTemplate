//
//  HomeViewController.swift
//  MVVMTemplate
//
//  Created by Bhargav BKS on 03/10/2020.
//  Copyright © 2020 Bhargav BKS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  // MARK:- PROPERTIES

  private let viewModel = HomeViewModel()
  
  private enum Constants {
    static let cellIdentifier: String = "employeeCell"
    static let title: String = "Employees List"
    static let errorMessage: String = "Unable to create employee cell"
  }

  // MARK:- IBOUTLETS
  
  @IBOutlet weak var employeesTableView: UITableView! {
    didSet {
      employeesTableView.dataSource = self
    }
  }
  
  // MARK:- IBACTION
  
  @IBAction func addEmployee(_ sender: UIBarButtonItem) {
    print("clicked")
  }

  // MARK:- VIEW LIFE CYCLE

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    title = Constants.title
  }
  
  override func viewDidAppear(_ animated: Bool) {
    viewModel.loadData()
  }

  // MARK: - Navigation

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}

}

// MARK:- EXTENSIONS

extension HomeViewController: UITableViewDataSource {
  
  // MARK:- TABLE DATA SOURCE

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? EmployeeTableViewCell else {
      fatalError(Constants.errorMessage)
    }
    cell.viewModel = viewModel.cellViewModel(with: indexPath.row)
    cell.configure()
    return cell
  }
}

extension HomeViewController: HomeViewModelDelegate {

  // MARK:- HOME VIEW MODEL DELEGATE

  func reloadTableView() {
    self.employeesTableView.reloadData()
  }
}
