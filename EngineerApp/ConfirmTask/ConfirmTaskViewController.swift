//
//  AddTaskViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/07/13.
//

import UIKit

final class ConfirmTaskViewController: UIViewController {
    
    @IBOutlet private weak var addTaskView: AddTaskView!
    //Model定義
    var taskData = TaskData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddTaskView.addTaskDelegate = self
        addTaskView.taskTableView.register(TaskTableViewCell.nib, forCellReuseIdentifier: TaskTableViewCell.identifier)
        addTaskView.taskTableView.delegate = self
        addTaskView.taskTableView.dataSource = self
        createCircle()
        addTaskView.plusButton.backgroundColor = Colors.PopGreen
        addTaskView.plusButton.tintColor = Colors.TextLightGrayColor
    }
    
    func createCircle() {
        addTaskView.plusButton.layer.masksToBounds = true
        addTaskView.plusButton.layer.cornerRadius =
            addTaskView.plusButton.bounds.width / 2
    }
    
}

extension ConfirmTaskViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
        return cell
      }
}

//ボタンタップ時の画面遷移をdelegateで実装した
//TODO: 10/9 修正する
extension ConfirmTaskViewController: AddTaskDelegate {
    func addTask() {
        let taskStoryboard: UIStoryboard = UIStoryboard(name: "EditTask", bundle: nil)
        let task = taskStoryboard.instantiateViewController(withIdentifier: "EditTask") as! EditTaskViewController
        let nav = UINavigationController(rootViewController: task)
        self.present(nav, animated: true, completion: nil)
        
    }
}
