//
//  AddTaskViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/07/13.
//

import UIKit

final class AddTaskViewController: UIViewController {
    
    private var addTaskView = AddTaskView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addTaskView)
        addTaskView.addTaskDelegate = self
        addTaskView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

extension AddTaskViewController: AddTaskDelegate {
    func addTask() {
        //ここのprint文がデバッグできないので、delegateがうまく設定できていない？
        print("ボタンがタップされました")
        let task = self.storyboard?.instantiateViewController(withIdentifier: "Task") as! TaskViewController
        self.present(task, animated: true, completion: nil)
    }
    
}
