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
        self.tabBar.tintColor = Colors.MainGreen
        self.tabBar.barTintColor = Colors.PopGreen
        self.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
       }
}
