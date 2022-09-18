//
//  HomeViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/11/19.
//

import UIKit
import RealmSwift

final class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PostTableViewCellDelegate {

    let postTableViewCell = PostTableViewCell.self
    let realm = try! Realm()
    private var reportArray = try! Realm().objects(ReportData.self).sorted(byKeyPath: "date", ascending: false)

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostTableViewCell.nib, forCellReuseIdentifier: PostTableViewCell.identifier)
        navigationItem.title = "学習記録"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        cell.delegate = self
        cell.index = indexPath
        cell.setReportData(reportArray[indexPath.row])
        return cell
    }
}

extension HomeViewController {
    func deleteButtonTapped(index: IndexPath){
        let alert: UIAlertController = UIAlertController(title: "注意", message: "削除してもいいですか？", preferredStyle: .actionSheet)

        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel) { (UIAlertAction) in
        }

        let okAction: UIAlertAction = UIAlertAction(title: "削除", style: .destructive) { (UIAlertAction) in
            try! self.realm.write {
                self.realm.delete(self.reportArray[index.row])
                self.tableView.deleteRows(at: [index], with: .fade)
            }
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
