//
//  TaskViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/07/09.
//

import UIKit

class TaskViewController: UIViewController {
    
    private var didSelect: (String) -> Void = { _ in }
    
    static func instantiate(didSelect: @escaping (String) -> Void) -> TaskViewController {
        let task = UIStoryboard(name: "Task", bundle: nil)
                    .instantiateInitialViewController() as! TaskViewController
                task.didSelect = didSelect
                return task
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
