//
//  ViewController.swift
//  TasksMVVM
//
//  Created by Sergey on 12/9/20.
//

import UIKit

class ViewController: UIViewController {
    
    //Views that will be displayed on this screen
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        return tableView
    }()
    
    //Constants and Variables
    var data = [Tasks]()
    var viewModel: TaskCellViewModel? = nil

    //Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        setDelegates()
        configureNavigationController()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setInitialUI() {
        //Adding subviews
        view.addSubview(tableView)
        setupData()
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapPlusButton))
    }
    
    @objc private func didTapPlusButton() {
        let vc = AddTaskViewController()
        vc.title = "New Task"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { [weak self] toDo, days in
            self?.data.append(Tasks(toDo: toDo, date: Date(), additionalInformation: "", numberOfDaysToFinishTheToDo: days))
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    ///Just for having initial data and tableview wouln't be empty.
    func setupData() {
        data.append(Tasks(toDo: "Finish The App", date: Date(), additionalInformation: "Calculator App", numberOfDaysToFinishTheToDo: "2"))
        data.append(Tasks(toDo: "Prepare The Meal", date: Date(), additionalInformation: "Prepare The Soup", numberOfDaysToFinishTheToDo: "1"))
        data.append(Tasks(toDo: "Apply For A Job", date: Date(), additionalInformation: "iOS Developer", numberOfDaysToFinishTheToDo: "1"))
    }
    
}

//MARK: - UITableViewDelegate and UITableViewDataSource Implementation

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
        let model = data[indexPath.row]
        viewModel = TaskCellViewModel(toDo: model.toDo, numberOfDaysToFinishTheToDo: model.numberOfDaysToFinishTheToDo)
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
