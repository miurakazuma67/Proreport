//
//  PostViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/11/19.
//

import UIKit
import RealmSwift
import SVProgressHUD
import IQKeyboardManagerSwift

final class PostViewController: UIViewController {
    
    @IBOutlet private weak var languageTextField: UITextField!
    @IBOutlet private weak var timeTextField: UITextField!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var textViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var textViewContainerHeight: NSLayoutConstraint!
    
    fileprivate var currentTextViewHeight: CGFloat = 34
    
    private var reportData: ReportData!
    private var stopButtonItem: UIBarButtonItem!
    private var postButtonItem: UIBarButtonItem!
    private let datePicker = UIDatePicker()
    let calender = Calendar.current
    var hour: Int?
    var minute: Int?
    
    @IBAction func languageEditChanged(_ sender: UITextField) {
        self.validate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //datePicker作成
        createDatePicker()
        //MARK: navigationBar
        stopButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopButtonTapped(_:)))
        postButtonItem = UIBarButtonItem(title: "記録する", style: .done, target: self, action: #selector(postButtonTapped(_:)))
        
//        ボタン配置
        self.navigationItem.rightBarButtonItem = postButtonItem
        self.navigationItem.leftBarButtonItem = stopButtonItem
        self.validate()
        
        //color指定
        //怪しい
        languageTextField.textColor = Colors.TextColor
        textView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5
        textView.delegate = self
    }
    
    @objc func stopButtonTapped(_ sender: UIBarButtonItem) {
        
        let alert: UIAlertController = UIAlertController(title: "記録をキャンセルしますか？", message: "", preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertAction.Style.destructive, handler:{
            (action: UIAlertAction!) -> Void in
            print("OK")
            self.textView.text = ""
            self.languageTextField.text = ""
            self.timeTextField.text = ""
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
    
    @objc func postButtonTapped(_ sender: UIBarButtonItem) {
        SVProgressHUD.show()
        //Modelごと渡したい
        let reportData = ReportData()
        reportData.id = 0
        reportData.caption = self.textView.text ?? ""
        reportData.language = self.languageTextField.text ?? ""
        reportData.date = Date()
        reportData.hour = self.hour ?? 0
        reportData.minute = self.minute ?? 0
        
        let realm = try! Realm()
        try! realm.write {
            let allReportDatas = realm.objects(ReportData.self)
            if allReportDatas.count != 0 {
                reportData.id = allReportDatas.max(ofProperty: "id")! + 1
            }
            realm.add(reportData)
        }
        SVProgressHUD.showSuccess(withStatus: "記録が完了しました!")
        // 投稿処理が完了したので、HomeViewControllerに遷移させる
        self.tabBarController?.selectedIndex = 0;
        
        textView.text = ""
        languageTextField.text = ""
        timeTextField.text = ""
        //validate呼び出し
        self.validate()
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

extension PostViewController {
    private func createDatePicker() {
        datePicker.datePickerMode = .countDownTimer
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        timeTextField.inputView = datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(title: "決定", style: .done, target: self, action: #selector(self.doneClicked))
        done.tintColor = .systemGreen
        toolbar.setItems([done], animated: true)
        timeTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked() {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.locale    = NSLocale(localeIdentifier: "ja_JP") as Locale?

        dateFormatter.dateFormat = "H時間mm分"
        
        timeTextField.text = dateFormatter.string(from: datePicker.date)
        self.hour = calender.component(.hour, from: datePicker.date)
        self.minute = calender.component(.minute, from: datePicker.date)
        self.view.endEditing(true)
    }
}

extension PostViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let contentHeight = self.textView.contentSize.height
        
        //動的にtextViewのframeを更新できるようにする
        self.textView.translatesAutoresizingMaskIntoConstraints = true
        self.textView.sizeToFit()
        //必要か確認する
        self.textView.isScrollEnabled = false
        let resizedHeight = self.textView.frame.size.height
        self.textViewHeight.constant = resizedHeight
        //@x: 128.5（左のマージン）
        //@y: 10（上のマージン）
        //@width: self.view.frame.width - 175.5(左右のマージン)
        //@height: sizeToFit()後の高さ
        self.textView.frame = CGRect(x: 128.5, y: 10, width: self.view.frame.width - 175.5, height: resizedHeight)
 
        if resizedHeight > currentTextViewHeight {
            let addingHeight = resizedHeight - currentTextViewHeight
            self.textViewContainerHeight.constant += addingHeight
            currentTextViewHeight = resizedHeight
        }
        
        if resizedHeight > currentTextViewHeight {
            let addingHeight = resizedHeight - currentTextViewHeight
            self.textViewContainerHeight.constant += addingHeight
            currentTextViewHeight = resizedHeight
        } else if resizedHeight < currentTextViewHeight {
            let subtractingHeight = currentTextViewHeight - resizedHeight
            self.textViewContainerHeight.constant -= subtractingHeight
            currentTextViewHeight = resizedHeight
        }
        
        if 34.0 <= contentHeight && contentHeight <= 170 {
            self.textView.isScrollEnabled = false
        } else {
            self.textView.isScrollEnabled = true
        }
    }
    
}
