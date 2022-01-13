//
//  TaskData.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/07/22.
//

import RealmSwift

//タスクを保存するモデル(EditTaskVC)
final class TaskData: Object {
    @objc dynamic var id = 0
    @objc dynamic var priority: Int = 0
    @objc dynamic var taskName: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
