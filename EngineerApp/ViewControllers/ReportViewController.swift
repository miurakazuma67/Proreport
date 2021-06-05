//
//  ReportViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/12/01.
//

import UIKit
import RealmSwift
import IBAnimatable

final class ReportViewController: UIViewController {
    
    @IBOutlet private weak var totalHourLabel: UILabel!
    @IBOutlet private weak var totalMinuteLabel: UILabel!
    
    var hour = 0
    var minute = 0
    
    // 投稿データを格納する配列
    var results: [ReportData] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: viewWillAppear")
        self.hour = 0
        self.minute = 0
        //resultsにreportDataの配列を代入
        let realm = try! Realm()
        let results = realm.objects(ReportData.self)
        
        for content in results {
            let totalHour = Int(content.hour!)
            self.hour += totalHour!
            let totalMinute = Int(content.minute!)
            self.minute += totalMinute!
        }
        //minuteが60を超えてしまった場合に、超えた分をhourに加えて、残りをminuteとする
        if minute >= 59 {
            self.hour += minute / 60
            self.minute = minute % 60
        }
        self.totalHourLabel.text = "\(hour)"
        self.totalMinuteLabel.text = "\(minute)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "合計勉強時間"
    }
}

