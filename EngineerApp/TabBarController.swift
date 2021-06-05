//
//  TabBarController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/11/20.
//

import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor(red: 0.11, green: 0.44, blue: 1, alpha: 1)
        self.tabBar.barTintColor = UIColor(red: 0.87, green: 0.91, blue: 0.96, alpha: 1)
        self.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
       }
}
