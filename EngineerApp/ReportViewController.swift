//
//  ReportViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/12/01.
//

import UIKit
import RealmSwift

class ReportViewController: UIViewController {
    
    @IBOutlet weak var totalStudyLabel: UILabel!
    @IBOutlet weak var studyLabel: UILabel!
    @IBOutlet weak var totalHourLabel: UILabel!
    @IBOutlet weak var totalMinuteLabel: UILabel!
    
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
            self.hour += minute/60
            self.minute = minute%60
        }
        self.totalHourLabel.text = "\(hour)"
        self.totalMinuteLabel.text = "\(minute)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //ラベルの文字色、背景色を変更
        studyLabel.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        studyLabel.textColor = UIColor.black
        totalStudyLabel.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    }
}

