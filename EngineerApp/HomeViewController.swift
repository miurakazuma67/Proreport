//
//  HomeViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/11/19.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PostTableViewCellDelegate
{
    let postTableViewCell = PostTableViewCell.self
    
    @IBOutlet weak var tableView: UITableView!
    // 投稿データを格納する配列
    var reportArray: [ReportData] = []
    //合計時間データを格納する配列
    var totalTimeArray: [TotalMinuteData] = []
    // Firestoreのリスナー(reportsRefを監視するリスナー)
    var listener: ListenerRegistration!
    // Firestoreのリスナー(reportsRefを監視するリスナー)
    var minuteListener: ListenerRegistration!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("totalTimeArray")
        tableView.delegate = self
        tableView.dataSource = self
        // カスタムセルを登録する
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: viewWillAppear")
        
        if Auth.auth().currentUser != nil {
            // ログイン済み
            if listener == nil {
                // listener未登録なら、登録してスナップショットを受信する
                let reportsRef = Firestore.firestore().collection(Const.ReportPath).order(by: "date", descending: true)
                listener = reportsRef.addSnapshotListener() { (querySnapshot, error) in
                    if let error = error {
                        print("DEBUG_PRINT: snapshotの取得が失敗しました。 \(error)")
                        return
                    }
                    // 取得したdocumentをもとにreportDataを作成し、reportArrayの配列にする。
                    self.reportArray = querySnapshot!.documents.map { document in
                        print("DEBUG_PRINT: reportDataのdocument取得 \(document)")
                        let reportData = ReportData(document: document)
                        return reportData
                    }
                    print(querySnapshot!.documents.count)
                    // TableViewの表示を更新する
                    self.tableView.reloadData()
                }
            }
            // ログイン済み
            if minuteListener == nil {
                // listener未登録なら、登録してスナップショットを受信する
                let totalMinuteRef = Firestore.firestore().collection(Const.TotalMinutePath).order(by: "date", descending: true)
                minuteListener = totalMinuteRef.addSnapshotListener() { (querySnapshot, error) in
                    if let error = error {
                        print("DEBUG_PRINT: snapshotの取得が失敗しました。 \(error)")
                        return
                    }
                    print(querySnapshot!.documents.count)
                    // 取得したdocumentをもとにtotalTimeDataを作成し、totalTimeArrayの配列にする。
                    self.totalTimeArray = querySnapshot!.documents.map { document in
                        print("DEBUG_PRINT: totalMinuteDataのdocument取得 \(document)")
                        let totalMinuteData = TotalMinuteData(document: document)
                        return totalMinuteData
                    }
                    // TableViewの表示を更新する
                    self.tableView.reloadData()
                }
            }
        } else {
            // ログイン未(またはログアウト済み)
            if listener != nil {
                // listener登録済みなら削除してreportArrayをクリアする
                listener.remove()
                listener = nil
                reportArray = []
                tableView.reloadData()
            }
            // ログイン未(またはログアウト済み)
            if minuteListener != nil {
                // listener登録済みなら削除してreportArrayをクリアする
                minuteListener.remove()
                minuteListener = nil
                totalTimeArray = []
                tableView.reloadData()
            }
        }
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
            //削除するデータ
            let deleteData = self.reportArray[index.row]
            let deleteTime = self.totalTimeArray[index.row]
            //documentを削除
            Firestore.firestore().collection("reports").document(deleteData.id).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            //totalTimeDataを削除
            Firestore.firestore().collection("totalMinutes").document(deleteTime.id!).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            self.reportArray.remove(at: index.row)
            self.tableView.reloadData()
        }
        //アラートに設定を反映させる
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        //アラート画面を表示させる
        present(alert, animated: true, completion: nil)
        //アラートを表示する↑＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
    }
}
