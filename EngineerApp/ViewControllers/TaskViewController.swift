//
//  TaskViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/07/09.
//

import UIKit

final class TaskViewController: UIViewController {
    
    private var addButtonItem: UIBarButtonItem!
    private var cancelButtonItem: UIBarButtonItem!
    let star = UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate)
    let starFill = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
    
    @IBOutlet private weak var taskTextField: UITextField!
    @IBOutlet private weak var starButton1: UIButton!
    @IBOutlet private weak var starButton2: UIButton!
    @IBOutlet private weak var starButton3: UIButton!
    @IBOutlet private weak var starButton4: UIButton!
    @IBOutlet private weak var starButton5: UIButton!
    
    private var tapCount: Int = 0
    var starNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        starButton1.tintColor = .black
        starButton2.tintColor = .black
        starButton3.tintColor = .black
        starButton4.tintColor = .black
        starButton5.tintColor = .black
    }
    
    private func setNavigationItem() {
        addButtonItem = UIBarButtonItem(title: "追加する", style: .done, target: self, action: #selector( addButtonPressed(_:)))
        cancelButtonItem = UIBarButtonItem(title: "キャンセル", style: .done, target: self, action: #selector(cancelButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = addButtonItem
        self.navigationItem.leftBarButtonItem = cancelButtonItem
        addButtonItem.tintColor = UIColor(hexString: "91C788")
        cancelButtonItem.tintColor = UIColor(hexString: "91C788")
    }
    
    @IBAction func star1Tapped(_ sender: UIButton) {
        tapCount += 1
        backgroundChanged1()
        resetBackground()
        starNum = 1
    }
    
    @IBAction func star2Tapped(_ sender: UIButton) {
        tapCount += 1
        backgroundChanged1()
        backgroundChanged2()
        resetBackground()
        starNum = 2
    }
    
    @IBAction func star3Tapped(_ sender: UIButton) {
        tapCount += 1
        backgroundChanged1()
        backgroundChanged2()
        backgroundChanged3()
        resetBackground()
        starNum = 3
    }
    
    @IBAction func star4Tapped(_ sender: UIButton) {
        tapCount += 1
        backgroundChanged1()
        backgroundChanged2()
        backgroundChanged3()
        backgroundChanged4()
        resetBackground()
        starNum = 4
    }
    
    @IBAction func star5Tapped(_ sender: UIButton) {
        tapCount += 1
        backgroundChanged1()
        backgroundChanged2()
        backgroundChanged3()
        backgroundChanged4()
        backgroundChanged5()
        resetBackground()
        starNum = 5
    }
    
    //各buttonの色変更メソッド
    func backgroundChanged1() {
        starButton1.setImage(starFill, for: .normal)
        starButton1.tintColor = UIColor.systemYellow
    }
    
    func backgroundChanged2() {
        starButton2.setImage(starFill, for: .normal)
        starButton2.tintColor = UIColor.systemYellow
    }
    
    func backgroundChanged3() {
        starButton3.setImage(starFill, for: .normal)
        starButton3.tintColor = UIColor.systemYellow
    }
    
    func backgroundChanged4() {
        starButton4.setImage(starFill, for: .normal)
        starButton4.tintColor = UIColor.systemYellow
    }
    
    func backgroundChanged5() {
        starButton5.setImage(starFill, for: .normal)
        starButton5.tintColor = UIColor.systemYellow
    }
    
    //星ボタンを偶数回押した時に元に戻る
    func resetBackground() {
        if tapCount % 2 == 0 {
            starButton1.setImage(star, for: .normal)
            starButton2.setImage(star, for: .normal)
            starButton3.setImage(star, for: .normal)
            starButton4.setImage(star, for: .normal)
            starButton5.setImage(star, for: .normal)
            starButton1.tintColor = UIColor.black
            starButton2.tintColor = UIColor.black
            starButton3.tintColor = UIColor.black
            starButton4.tintColor = UIColor.black
            starButton5.tintColor = UIColor.black
            starNum = 0
        } else { starNum = 0 }
    }
    
    // MARK: NavigationItem  methods
    @objc func addButtonPressed(_ sender: UIBarButtonItem) {
        guard let text = self.taskTextField.text else { return }
        
    }
    
    @objc func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
