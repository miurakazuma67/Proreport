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
protocol PostTableViewCellDelegate: class {
    func deleteButtonTapped(index: IndexPath)
}

final class PostTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var hourLabel: UILabel!
    @IBOutlet private weak var minuteLabel: UILabel!
    @IBOutlet private weak var captionLabel: UILabel!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
    var index: IndexPath!
    weak var deletedelegate: PostTableViewCellDelegate?
    
    var count: Int? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        dateLabel.textColor = UIColor.gray
    }
    
    // ReportDataの内容をセルに表示
    func setReportData(_ reportData: ReportData) {
        self.captionLabel.text = reportData.caption
        self.languageLabel.text = reportData.language
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
        deletedelegate?.deleteButtonTapped(index: index)
    }
}
