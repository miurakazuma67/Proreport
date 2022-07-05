//
//  PostTableViewCell.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/12/09.
//

import UIKit
import RealmSwift
import SVProgressHUD

// MARK: delegate protocol
protocol PostTableViewCellDelegate: AnyObject {
    func deleteButtonTapped(index: IndexPath)
}

final class PostTableViewCell: UITableViewCell {

    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var subjectLabel: UILabel!
    @IBOutlet private weak var hourLabel: UILabel!
    @IBOutlet private weak var minuteLabel: UILabel!
    @IBOutlet private weak var captionLabel: UILabel!

    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }

    //配列の番号取得用
    var index: IndexPath!
    weak var deleteDelegate: PostTableViewCellDelegate? 
    var count: Int? = nil
    
    // ReportDataの内容をセルに表示
    func setReportData(_ reportData: ReportData) {
        self.captionLabel.text = reportData.caption
        self.subjectLabel.text = reportData.subject
        self.hourLabel.text = String(reportData.hour)
        self.minuteLabel.text = String(reportData.minute)
        
        // 日時の表示
        self.dateLabel.text = ""
        if let date = reportData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }
    }
    
    @IBAction func handle(_ sender: Any) {
        deleteDelegate?.deleteButtonTapped(index: index)
    }
}
