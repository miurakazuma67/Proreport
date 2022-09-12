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
        showChart()
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
        }

        //minuteが60を超えてしまった場合に、超えた分をhourに加えて、残りをminuteとする
        if minute >= 59 {
            hour += minute / 60
            minute = minute % 60
        }
        self.totalHourLabel.text = "\(hour)"
        self.totalMinuteLabel.text = "\(minute)"
    }

    private func showChart() {
        let realm = try! Realm()
        let results = realm.objects(ReportData.self)

        //最新の日付を取得
        let calendar = Calendar(identifier: .gregorian)
        // dateのままだと、何月何日何時何分何秒まで取得されるので、投稿されたものと一致しなくなる -> 合計しても0になる
        // 何月何日で絞る必要がある -> 月日の取得がしたい
        let date = Date()
        // 今日の年月日を取得する
        var dataCompornents = calendar
            .dateComponents([.year, .month, .day], from: date)
        

        // この日付と一致するものだけをresults配列から取り出し、合計時間を計算する
        let todays = results.filter {
            $0.date == date
        }
        // この時点だとReportData型の配列なので、時間取り出す
        let totalHourToday = todays.map{ $0.hour }
        let totalHour = totalHourToday.reduce(0, +)
//        print(totalHour)
    }
}

 // Charts周り
extension ReportViewController {

}
