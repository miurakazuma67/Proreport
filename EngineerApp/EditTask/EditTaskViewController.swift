//
//  TaskViewController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/07/09.
//

import UIKit

final class EditTaskViewController: UIViewController {
    
    private var addButtonItem: UIBarButtonItem!
    private var cancelButtonItem: UIBarButtonItem!
    let star = UIImage(systemName: "star_fill")
    let starFill = UIImage(systemName: "icon_star_one")
    
    @IBOutlet private weak var taskTextField: UITextField!
    @IBOutlet private weak var starButton1: UIButton!
    @IBOutlet private weak var starButton2: UIButton!
    @IBOutlet private weak var starButton3: UIButton!
    @IBOutlet private weak var starButton4: UIButton!
    @IBOutlet private weak var starButton5: UIButton!
    
    private var tapCount: Int = 0
    //あとでModelに移す
    var starNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
    }
    
    private func setNavigationItem() {
        addButtonItem = UIBarButtonItem(title: "追加する", style: .done, target: self, action: #selector( addButtonPressed(_:)))
        cancelButtonItem = UIBarButtonItem(title: "キャンセル", style: .done, target: self, action: #selector(cancelButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = addButtonItem
        self.navigationItem.leftBarButtonItem = cancelButtonItem

        addButtonItem.tintColor = Colors.MainGreen
        cancelButtonItem.tintColor = Colors.MainGreen
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
    //ここを画像差し替えに変更する！！
    func backgroundChanged1() {
        self.starButton1.setImage(starFill, for: .selected)
    }

    func backgroundChanged2() {
        self.starButton2.setImage(starFill, for: .selected)
    }

    func backgroundChanged3() {
        self.starButton3.setImage(starFill, for: .selected)
    }

    func backgroundChanged4() {
        self.starButton4.setImage(starFill, for: .selected)
    }

    func backgroundChanged5() {
        self.starButton5.setImage(starFill, for: .selected)
    }

    ///星ボタンを偶数回押した時に元に戻るメソッド
    func resetBackground() {
        if tapCount % 2 == 0 {
            starButton1.setImage(star, for: .normal)
            starButton2.setImage(star, for: .normal)
            starButton3.setImage(star, for: .normal)
            starButton4.setImage(star, for: .normal)
            starButton5.setImage(star, for: .normal)
            starNum = 0
        }
    }
    
    // MARK: NavigationItem  methods
    @objc func addButtonPressed(_ sender: UIBarButtonItem) {
        guard let text = self.taskTextField.text else { return }
        //textを保存するメソッドを書く
    }
    
    @objc func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
