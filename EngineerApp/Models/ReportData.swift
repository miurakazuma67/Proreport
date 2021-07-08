//
//  PostData.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/12/07.
//
import RealmSwift

class ReportData: Object {
    @objc dynamic var id = 0
    @objc dynamic var caption: String?
    @objc dynamic var date: Date? = Date()
    @objc dynamic var language: String?
    @objc dynamic var hour = 0
    @objc dynamic var minute = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

