//
//  AddTaskViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/07/13.
//

import UIKit

final class AddTaskViewController: UIViewController {
    
    @IBOutlet private weak var addTaskView: AddTaskView!
    var taskData = TaskData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddTaskView.addTaskDelegate = self
        AddTaskView.taskTableView.register(TaskTableViewCell.nib, forCellReuseIdentifier: TaskTableViewCell.identifier)
        AddTaskView.taskTableView.delegate = self
        AddTaskView.taskTableView.dataSource = self
    }
    
}

extension AddTaskViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
      }

      func tableView(_ tableView: UITableView, cellForRowAt 何個セル出すの: IndexPath) -> UITableViewCell {
        let 表示するセルの内容 = tableView.dequeueReusableCell(withIdentifier: "再利用セル", for: 何個セル出すの) as! カスタムセルクラス
        表示するセルの内容.セルに表示するデータの制御 ( 選択数はこれを使う : 何個セル出すの )
        return 表示するセルの内容
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
