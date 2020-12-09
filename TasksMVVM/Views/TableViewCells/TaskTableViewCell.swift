//
//  TaskTableViewCell.swift
//  TasksMVVM
//
//  Created by Sergey on 12/9/20.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    static let identifier = "TaskTableViewCell"
    
    //Views that will be displayed on this cell
    let taskLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setInitialUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        taskLabel.frame = CGRect(x: 10, y: 5, width: frame.size.width - 20, height: frame.size.height - 10)
    }
    
    private func setInitialUI() {
        addSubview(taskLabel)
    }
    
    func configure(with viewModel: TaskCellViewModel) {
        taskLabel.text = "\(viewModel.toDo). Number of days to finish task: \(viewModel.numberOfDaysToFinishTheToDo)"
    }
    
}
