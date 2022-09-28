//
//  PostViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/11/19.
//

import UIKit
import RealmSwift
import SVProgressHUD


final class PostViewController: UIViewController {

    @IBOutlet private weak var subjectTextField: UITextField!
    @IBOutlet private weak var timeTextField: UITextField!
    @IBOutlet private weak var textView: UITextView!

    private var reportData: ReportData!
    private var stopButtonItem: UIBarButtonItem!
    private var postButtonItem: UIBarButtonItem!
    private let datePicker = UIDatePicker()
    let calender = Calendar.current
    var hour: Int?
    var minute: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        //MARK: navigationBar
        stopButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopButtonTapped(_:)))
        postButtonItem = UIBarButtonItem(title: "記録する", style: .done, target: self, action: #selector(postButtonTapped(_:)))

        self.navigationItem.rightBarButtonItem = postButtonItem
        self.navigationItem.leftBarButtonItem = stopButtonItem
        self.textView.isScrollEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        self.subjectTextField.addBorder(width: 0.5, color: Colors.StarColor, position: .bottom)
        self.timeTextField.addBorder(width: 0.5, color: Colors.StarColor, position: .bottom)
        self.textView.layer.borderWidth = 0.5
        self.textView.layer.borderColor = Colors.StarColor.cgColor
    }
    
    @objc func stopButtonTapped(_ sender: UIBarButtonItem) {

        let alert: UIAlertController = UIAlertController(title: "記録をキャンセルしますか？", message: "", preferredStyle:  UIAlertController.Style.alert)

        let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertAction.Style.destructive, handler:{
            (action: UIAlertAction!) -> Void in
            self.textView.text = ""
            self.subjectTextField.text = ""
            self.timeTextField.text = ""
        })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.cancel, handler:{
            (action: UIAlertAction!) -> Void in
        })
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func postButtonTapped(_ sender: UIBarButtonItem) {
        SVProgressHUD.show()
 // Modelごと渡したい
        let reportData = ReportData()
        reportData.id = 0
        reportData.caption = self.textView.text ?? ""
        reportData.subject = self.subjectTextField.text ?? ""
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
        subjectTextField.text = ""
        timeTextField.text = ""
    }
}

extension PostViewController {
    private func createDatePicker() {
        datePicker.datePickerMode = .countDownTimer
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        timeTextField.inputView = datePicker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let spaceItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(title: "決定", style: .done, target: self, action: #selector(self.doneClicked))
        done.tintColor = Colors.MainGreen
        toolbar.setItems([spaceItem, done], animated: true)
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
