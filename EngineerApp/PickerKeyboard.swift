//
//  PickerKeyboard.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/12/01.
//

import UIKit
import Firebase

class PickerKeyboard: UIControl {
    
    // ピッカーに表示させるデータ
    var data: [String] = ["HTML&CSS", "PHP", "JavaScript", "Java", "Swift", "Ruby", "C", "C#", "Unity", "Python", "Laravel", "SQL", "VBA", "VB.net", "COBOL", "GO", "Perl", "TypeScript", "Kothin", "Scala", "Flutter", "その他"]
    fileprivate var textStore: String = ""
    override func draw(_ rect: CGRect) {
        UIColor.black.set()
        UIRectFrame(rect)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attrs: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.paragraphStyle: paragraphStyle]
        NSString(string: textStore).draw(in: rect, withAttributes: attrs)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addTarget(self, action: #selector(PickerKeyboard.didTap(sender:)), for: .touchUpInside)
    }
    
    @objc func didTap(sender: PickerKeyboard) {
        becomeFirstResponder()
    }
    
    func didTapDone(sender: UIButton) {
        resignFirstResponder()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var inputView: UIView? {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        let row = data.index(of: textStore) ?? -1
        pickerView.selectRow(row, inComponent: 0, animated: false)
        return pickerView
    }
    
    override var inputAccessoryView: UIView? {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.addTarget(self, action: #selector(PickerKeyboard.didTap(sender:)), for: .touchUpInside)
        button.sizeToFit()
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 44))
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.backgroundColor = .groupTableViewBackground
        
        button.frame.origin.x = 16
        button.center.y = view.center.y
        button.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin, .flexibleTopMargin]
        view.addSubview(button)
        
        return view
    }
}

extension PickerKeyboard: UIKeyInput {
    // It is not necessary to store text in this situation.
    var hasText: Bool {
        return !textStore.isEmpty
    }
    
    func insertText(_ text: String) {
        textStore += text
        setNeedsDisplay()
    }
    
    func deleteBackward() {
        textStore.remove(at: textStore.index(before: textStore.endIndex))
        setNeedsDisplay()
    }
}

extension PickerKeyboard: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textStore = data[row]
        setNeedsDisplay()
    }
}
