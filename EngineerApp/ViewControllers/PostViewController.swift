//
//  PostViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/11/19.
//

import UIKit
import RealmSwift
import SVProgressHUD

final class PostViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var languageTextField: UITextField!
    @IBOutlet private weak var hourTextField: UITextField!
    @IBOutlet private weak var minuteTextField: UITextField!
    @IBOutlet private weak var textView: UITextView!
    
    var reportData: ReportData!
    var stopButtonItem: UIBarButtonItem!
    
    
    @IBAction func languageEditChanged(_ sender: UITextField) {
        self.validate()
    }
    
    @IBAction func hourEditChanged(_ sender: UITextField) {
        self.validate()
    }
    
    @IBAction func minuteEditChanged(_ sender: UITextField) {
        self.validate()
    }
    
    @IBAction func postButton(_ sender: Any) {
        SVProgressHUD.show()
        let reportData = ReportData()
        reportData.id = 0
        reportData.caption = self.textView.text ?? ""
        reportData.language = self.languageTextField.text ?? ""
        reportData.hour = hourTextField.text ?? ""
        reportData.minute = minuteTextField.text ?? ""
        reportData.date = Date()
        
        let realm = try! Realm()
        try! realm.write {
            //idの重複を防ぐ
            let allReportDatas = realm.objects(ReportData.self)
            if allReportDatas.count != 0 {
                reportData.id = allReportDatas.max(ofProperty: "id")! + 1
            }
            realm.add(reportData)
        }
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "記録が完了しました!")
        // 投稿処理が完了したので、HomeViewControllerに遷移させる
        self.tabBarController?.selectedIndex = 0;
        
        //各textFieldの文字を空の文字列にする
        textView.text = ""
        languageTextField.text = ""
        hourTextField.text = ""
        minuteTextField.text = ""
        //validate呼び出し
        self.validate()
    }
    
    @IBOutlet private weak var cancelButton: UIButton!
    
    @objc func stopButtonTapped(_ sender: UIBarButtonItem) {
        
        let alert: UIAlertController = UIAlertController(title: "記録をキャンセルしますか？", message: "", preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertAction.Style.destructive, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
            //すべてのtextField,textViewの文字列を空にする
            self.textView.text = ""
            self.languageTextField.text = ""
            self.hourTextField.text = ""
            self.minuteTextField.text = ""
            self.validate()
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
            print("Cancel")
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: nabigationBar
        navigationItem.title = "記録する"
        stopButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopButtonTapped(_:)))
        self.navigationItem.leftBarButtonItem = stopButtonItem
        
        self.validate()
        //color指定
        languageTextField.textColor = UIColor(named:"textColor")
        hourTextField.textColor = UIColor(named:"textColor")
        minuteTextField.textColor = UIColor(named:"textColor")
        textView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5
        languageTextField.backgroundColor = UIColor(named: "textFieldColor")
        hourTextField.backgroundColor = UIColor(named: "textFieldColor")
        minuteTextField.backgroundColor = UIColor(named: "textFieldColor")
        textView.backgroundColor = UIColor(named: "textFieldColor")
    }
    
    private func validate() {
        //postButtonの有効/無効を切り替える
        //        if languageTextField.text == "" {
        //            buttonCannotUse()
        //        } else {
        //            buttonCanUse()
        //        }
        //
        //        if hourTextField.text == "" {
        //            buttonCannotUse()
        //        } else {
        //            buttonCanUse()
        //        }
        //
        //        if minuteTextField.text == "" {
        //            buttonCannotUse()
        //        } else {
        //            buttonCanUse()
        //        }
        //    }
        //
        //    func buttonCanUse() {
        //        postButton.isEnabled  = true //ボタン有効
        //        postButton.alpha = 1.0
        //    }
        //    func buttonCannotUse() {
        //        postButton.isEnabled  = false //ボタン無効
        //        postButton.alpha = 0.5
        //    }
    }
}
