//
//  PostViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/11/19.
//

import UIKit
import Firebase
import SVProgressHUD


class PostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate
{
    
    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet weak var languageTextField: UITextField!
    
    var pickerView: UIPickerView = UIPickerView()
    
    // ピッカーに表示させるデータ
    var data: [String] = ["HTML&CSS", "PHP", "JavaScript", "Java", "Swift", "Ruby", "C", "C#", "Unity", "Python", "Laravel", "SQL", "VBA", "VB.net", "COBOL", "GO", "Perl", "TypeScript", "Kothin", "Scala", "Flutter", "その他"]
    
    
    @IBOutlet weak var hourTextField: UITextField!
    
    @IBOutlet weak var minuteTextField: UITextField!
    
    
    
    
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    fileprivate var maxWordCount: Int = 140 //最大文字数
    fileprivate let placeholder: String = "メモ"
    //プレイスホルダー
    
    @IBOutlet weak var postButton: UIButton!
    
    @IBAction func postButton(_ sender: Any) {
        
        //投稿データの保存場所を定義する
        let reportRef = Firestore.firestore().collection(Const.ReportPath).document()
        //合計時間の保存場所を定義する
        let totalMinuteRef = Firestore.firestore().collection(Const.TotalMinutePath).document()
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        // FireStoreに投稿データを保存する
        let name = Auth.auth().currentUser?.displayName
        let reportDic = [
            "name": name!,
            "caption": self.textView.text!,
            "language": self.languageTextField.text!,
            "hour": hourTextField.text!,
            "minute": minuteTextField.text!,
            "date": FieldValue.serverTimestamp(),
        ] as [String : Any]
        reportRef.setData(reportDic)
        //Firestoreに合計時間を保存する
        let totalMinuteDic = [
            "totalMinute": Int(hourTextField.text!)! * 60 + Int(minuteTextField.text!)!
        ] as [String : Int]
        totalMinuteRef.setData(totalMinuteDic)
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        // 投稿処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func cancelButton(_ sender: Any) {
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 枠のカラー
        textView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        
        // 枠の幅
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5
        
        //ここから
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
        
        postButton.backgroundColor = UIColor.cyan
        cancelButton.backgroundColor = UIColor.cyan
    }
    // 決定ボタン押下
    @objc func done() {
        languageTextField.endEditing(true)
        languageTextField.text = "\(data[pickerView.selectedRow(inComponent: 0)])"
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
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
    /*
     // ドラムロール選択時
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     self.textField.text = list[row]
     }
     */
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
            textView.textColor = .darkGray
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .darkGray
            textView.text = "メモ"
        }
    }
}
