//
//  HomeViewController.swift
//  MVVMTemplate
//
//  Created by Bhargav BKS on 03/10/2020.
//  Copyright © 2020 Bhargav BKS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  // MARK:- Properties

  private let viewModel = HomeViewModel()
  
  private enum Constants {
    static let cellIdentifier: String = "employeeCell"
    static let title: String = "Employees List"
    static let errorMessage: String = "Unable to create employee cell"
  }

  // MARK:- IBOutlets
  
  @IBOutlet weak var employeesTableView: UITableView! {
    didSet {
      employeesTableView.dataSource = self
    }
  }

  // MARK:- View life cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    title = Constants.title
  }
  
  override func viewDidAppear(_ animated: Bool) {
    viewModel.loadData()
  }

  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
  }
}

extension HomeViewController: UITableViewDataSource {
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
  func reloadTableView() {
    self.employeesTableView.reloadData()
  }
}
