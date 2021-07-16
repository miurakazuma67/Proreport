//
//  AddTaskView.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/07/13.
//

import UIKit

// MARK: Protocol
protocol AddTaskDelegate: AnyObject {
    func plusTapped(_ plusButton: AddTaskView)
}

final class AddTaskView: UIView {
    
    weak var addTaskDelegate: AddTaskDelegate?
    
    // MARK: @IBOutlets
    @IBOutlet private weak var segmentedButton: UISegmentedControl!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var taskTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }
    
    func loadNib() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    
    // MARK: @IBActions
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        addTaskDelegate?.plusTapped(self)
    }
}
