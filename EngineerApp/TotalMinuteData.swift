//
//  TotalMinute.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/01/03.
//

import UIKit
import Firebase

class TotalMinuteData: NSObject {
    var id: String?
    var totalMinute: Int?
    var date: Date?

        init(document: QueryDocumentSnapshot) {
            self.id = document.documentID
            let totalMinuteDic = document.data()
            self.totalMinute = totalMinuteDic["totalMinute"] as? Int
            let timestamp = totalMinuteDic["date"] as? Timestamp
            self.date = timestamp?.dateValue()            
    }
}
