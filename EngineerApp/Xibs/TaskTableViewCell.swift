//
//  TaskTableViewCell.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/07/22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var starImage: UIImageView!
    @IBOutlet private weak var priorityLabel: UILabel!
    @IBOutlet private weak var taskLabel: UILabel!
    
    //commentoutしてみる
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setTaskData(_ taskData: TaskData) {
        self.taskLabel.text = taskData.taskName
        self.priorityLabel.text = String(taskData.priority)
        self.starImage.image = UIImage(named: "star")
        
    }
}
