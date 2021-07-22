//
//  AddTaskViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/07/13.
//

import UIKit

final class AddTaskViewController: UIViewController {
    
    @IBOutlet private weak var addTaskView: AddTaskView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddTaskView.addTaskDelegate = self
        taskTableView.register(TaskTableViewCell.nib, forCellReuseIdentifier: TaskTableViewCell.identifier)
    }
    
}

extension AddTaskViewController: AddTaskDelegate {
    func addTask() {
        let taskStoryboard: UIStoryboard = UIStoryboard(name: "Task", bundle: nil)
        let task = taskStoryboard.instantiateViewController(withIdentifier: "Task") as! TaskViewController
        let nav = UINavigationController(rootViewController: task)
        self.present(nav, animated: true, completion: nil)
        
    }
    
}
