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
    let star = UIImage(named: "star.fill")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    
    @IBOutlet weak var starButton1: UIButton!
    @IBOutlet weak var starButton2: UIButton!
    @IBOutlet weak var starButton3: UIButton!
    @IBOutlet weak var starButton4: UIButton!
    @IBOutlet weak var starButton5: UIButton!
    
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
        starButton1.setBackgroundImage(star, for: .normal)
    }
    
    @IBAction func star2Tapped(_ sender: UIButton) {
    }
    
    @IBAction func star3Tapped(_ sender: UIButton) {
    }
    
    @IBAction func star4Tapped(_ sender: UIButton) {
    }
    
    @IBAction func star5Tapped(_ sender: UIButton) {
    }
    
    //buttonの色変更メソッド
    func backgroundChanged() {
        
    }
    
    
    
    // MARK: NavigationItem  methods
    @objc func addButtonPressed(_ sender: UIBarButtonItem) {
        print("追加ボタンが押されました")
    }
    
    @objc func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
