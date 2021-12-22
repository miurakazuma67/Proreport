//
//  ReportStudyViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/12/01.
//

import UIKit

//学習を記録する画面(PostVCを消す)
final class ReportStudyViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var reportButton: UIButton!
    
    enum CellType {
        case date
        case studyTime
        case subject
        case memo
        case picture
        
        var placeholder: String {
            //メモ、写真のセルは別
            switch self {
            case .date:
                return "日付"
            case .studyTime:
                return "学習時間"
            case .subject:
                return "教科名"
            case .memo:
                return "メモ"
            case .picture:
                return "写真を追加"
            }
        }
    }
    
    var cellTypes: [CellType] {
        return [.date, .studyTime, .subject, .memo, .picture]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reportButton.layer.cornerRadius = 5
//        tableView.delegate = self
//        tableView.dataSource = self
    }
    
    @IBAction func reportButtonTapped(_ sender: UIButton) {
        //記録するボタンタップ時の処理を書く
    }
    
    
}

//extension ReportStudyViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cellTypes.count
//    }
    
//    //ここにセル表示
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
    
//}
