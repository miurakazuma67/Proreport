//
//  PostViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/11/19.
//

import UIKit
import RealmSwift
import SVProgressHUD


class PostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate
{
    
    @IBOutlet weak var label: UILabel!
    var reportData: ReportData!
    @IBOutlet weak var languageTextField: UITextField!
    var pickerView: UIPickerView = UIPickerView()
    // ピッカーに表示させるデータ
    var data: [String] = ["HTML&CSS", "PHP", "JavaScript", "Java", "Swift", "Ruby", "C", "C#", "Unity", "Python", "Laravel", "SQL", "VBA", "VB.net", "React", "COBOL", "GO", "Perl", "TypeScript", "Kothin", "Scala", "Flutter", "その他"]
    
    @IBOutlet weak var hourTextField: UITextField!
    @IBOutlet weak var minuteTextField: UITextField!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    fileprivate var maxWordCount: Int = 140 //最大文字数
    fileprivate let placeholder: String = "メモ"
    //プレイスホルダー
    @IBOutlet weak var postButton: UIButton!
    
    //varidate()メソッドのため、IBAction接続をする
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
        
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        // Realmに投稿データを保存する
        let reportData = ReportData()
        reportData.id = 0
        reportData.caption = self.textView.text!
        reportData.language = self.languageTextField.text!
        reportData.hour = hourTextField.text!
        reportData.minute = minuteTextField.text!
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
        //文字数カウントをリセット
        self.wordCountLabel.text = "140"
    }
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func cancelButton(_ sender: Any) {

        let alert: UIAlertController = UIAlertController(title: "記録をキャンセルしますか？", message: "", preferredStyle:  UIAlertController.Style.alert)

        let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertAction.Style.destructive, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("OK")
            //すべてのtextField,textViewの文字列を空にする
            self.textView.text = ""
            self.languageTextField.text = ""
            self.hourTextField.text = ""
            self.minuteTextField.text = ""
            self.validate()
            self.dismissKeyboard()
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
        navigationItem.title = "学習内容を記録しよう！"
        self.validate()
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
        
        // ピッカー設定
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定
        languageTextField.inputView = pickerView
        languageTextField.inputAccessoryView = toolbar
        
        self.textView.delegate = self
        //タップでキーボードを下げる
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        //下にスワイプでキーボードを下げる
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        swipeDownGesture.direction = .down
        self.view.addGestureRecognizer(swipeDownGesture)
        
        if textView.text.isEmpty {
            textView.text = placeholder
        }
        wordCountLabel.textColor = UIColor.gray
        postButton.backgroundColor = UIColor.cyan
        cancelButton.backgroundColor = UIColor.darkGray
    }
    // 決定ボタン押下
    @objc func done() {
        languageTextField.endEditing(true)
        languageTextField.text = "\(data[pickerView.selectedRow(inComponent: 0)])"
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    private func validate() {
        //postButtonの有効/無効を切り替える
        if languageTextField.text == "" {
            buttonCannotUse()
        } else {
            buttonCanUse()
        }
        
        if hourTextField.text == "" {
            buttonCannotUse()
        } else {
            buttonCanUse()
        }
        
        if minuteTextField.text == "" {
            buttonCannotUse()
        } else {
            buttonCanUse()
        }
    }
    
    func buttonCanUse() {
        postButton.isEnabled  = true //ボタン有効
        postButton.alpha = 1.0
    }
    func buttonCannotUse() {
        postButton.isEnabled  = false //ボタン無効
        postButton.alpha = 0.5
    }
    
}
extension PostViewController {
    
    // ドラムロールの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // ドラムロールの行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    // ドラムロールの各タイトル
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
}
//ここまでlanguageTextFieldの処理
extension PostViewController {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let existingLines = textView.text.components(separatedBy: .newlines)//既に存在する改行数
        let newLines = text.components(separatedBy: .newlines)//新規改行数
        let linesAfterChange = existingLines.count + newLines.count - 1 //最終改行数。-1は編集したら必ず1改行としてカウントされるから。
        return linesAfterChange <= 7 && textView.text.count + (text.count - range.length) <= maxWordCount
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let existingLines = textView.text.components(separatedBy: .newlines)//既に存在する改行数
        if existingLines.count <= 7 {
            self.wordCountLabel.text = "\(maxWordCount - textView.text.count)"
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "メモ" {
            textView.text = nil
            textView.textColor = UIColor(named:"textColor")
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .darkGray
            textView.text = "メモ"
        }
    }
}
