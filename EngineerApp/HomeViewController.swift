//
//  HomeViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/11/19.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PostTableViewCellDelegate
{
    let postTableViewCell = PostTableViewCell.self
    
    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    var reportArray = try! Realm().objects(ReportData.self).sorted(byKeyPath: "date", ascending: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        navigationItem.title = "学習記録"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: viewWillAppear")
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得してデータを設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell
        //cellのdelegateにselfを渡す
        cell.deletedelegate = self
        //cellにIndex情報を渡す
        cell.index = indexPath
        cell.setReportData(reportArray[indexPath.row])
        return cell
    }
}

//cellのデリゲートメソッドで削除処理を実装
extension HomeViewController {
    func deleteButtonTapped(index: IndexPath){
        // セル内のボタンがタップされた時に呼ばれるメソッド
        //アラートを表示する↓＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
        let alert: UIAlertController = UIAlertController(title: "注意", message: "削除してもいいですか？", preferredStyle: .actionSheet)
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel) { (UIAlertAction) in
            print("キャンセル")
        }
        let okAction: UIAlertAction = UIAlertAction(title: "削除", style: .destructive) { (UIAlertAction) in
            // 削除」が押された時の処理をここに記述
            // データベースから削除する
            try! self.realm.write {
                self.realm.delete(self.reportArray[index.row])
                self.tableView.deleteRows(at: [index], with: .fade)
            }
        }
        //アラートに設定を反映させる
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        //アラート画面を表示させる
        present(alert, animated: true, completion: nil)
    }
}
