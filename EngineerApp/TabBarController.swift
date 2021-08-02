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
        self.tabBar.tintColor = UIColor(hexString: "91C788")
        self.tabBar.barTintColor = UIColor(hexString: "DDFFBC")
        self.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
       }
}
