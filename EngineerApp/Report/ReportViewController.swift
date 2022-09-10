//
//  ReportViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/12/01.
//

import UIKit
import RealmSwift

final class ReportViewController: UIViewController {
    
    @IBOutlet private weak var totalHourLabel: UILabel!
    @IBOutlet private weak var totalMinuteLabel: UILabel!
    
    private var results: [ReportData] = []
    // 合計時間計算用のプロパティ
    private var hour: Int = 0
    private var minute: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Calculatetotal()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "合計勉強時間"
    }
    
    func Calculatetotal() {
        //resultsにreportDataの配列を代入
        let realm = try! Realm()
        let results = realm.objects(ReportData.self)
        
        for content in results {
            // ReportData型のcontent(単体であり、配列の1このデータ)から、時間を取り出して全部足し合わせている
            let totalHour = content.hour
            hour += totalHour
            let totalMinute = content.minute
            minute += totalMinute

            // 今日の日付を取得し、
            // 今日の日付と一致するもののみで合計時間を計算する
            // これを最新1週間でやる
            // それ以降を対応する場合は、矢印ボタンタップ時にdate操作を-7して合計計算とか？

        }
        
        //minuteが60を超えてしまった場合に、超えた分をhourに加えて、残りをminuteとする
        if minute >= 59 {
            hour += minute / 60
            minute = minute % 60
        }
        self.totalHourLabel.text = "\(hour)"
        self.totalMinuteLabel.text = "\(minute)"
    }
}

 // Charts周り
extension ReportViewController {

}
