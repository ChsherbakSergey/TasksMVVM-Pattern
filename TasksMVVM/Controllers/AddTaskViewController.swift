//
//  AddTaskViewController.swift
//  TasksMVVM
//
//  Created by Sergey on 12/9/20.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    //Views that will be displayed on this screen
    private let taskTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter a new task"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let daysTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Number of days left to finish task"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let addTaskButton : UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.label.cgColor
        return button
    }()
    
    //Constants and Variables
    var completion: ((String, String) -> Void)?
     
    //Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
        setDelegates()
        setTargetsToButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        taskTextField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 50, width: view.frame.size.width - 40, height: 52)
        daysTextField.frame = CGRect(x: 20, y: taskTextField.frame.origin.y + 72, width: view.frame.size.width - 40, height: 52)
        addTaskButton.frame = CGRect(x: 50, y: daysTextField.frame.origin.y + 150, width: view.frame.size.width - 100, height: 52)
        addTaskButton.layer.cornerRadius = 20
    }
    
    private func setInitialUI() {
        view.backgroundColor = .systemBackground
        //Adding subviews
        view.addSubview(taskTextField)
        view.addSubview(daysTextField)
        view.addSubview(addTaskButton)
    }
    
    private func setDelegates() {
        taskTextField.delegate = self
        daysTextField.delegate = self
    }
    
    private func setTargetsToButtons(){
        addTaskButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    @objc private func didTapAddButton() {
        guard let toDo = taskTextField.text, !toDo.isEmpty, let days = daysTextField.text, !days.isEmpty else {
            return
        }
        completion?(toDo, days)
        navigationController?.popViewController(animated: true)
    }

}


extension AddTaskViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == taskTextField {
            taskTextField.resignFirstResponder()
            daysTextField.becomeFirstResponder()
        } else if textField == daysTextField {
            daysTextField.resignFirstResponder()
            didTapAddButton()
        }
        return true
    }
    
}
