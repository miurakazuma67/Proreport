//
//  MyNavigationController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2022/01/29.
//

import UIKit

final class MyNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        // ナビゲーションバーのテキストを変更する
        navigationBar.titleTextAttributes = [
            // 文字の色
            .foregroundColor: UIColor.white
        ]
    }
}
