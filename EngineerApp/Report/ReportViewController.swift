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
            let totalHour = content.hour
            hour += totalHour
            let totalMinute = Int(content.minute)
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
}

 // Charts周り
extension ReportViewController {

}
