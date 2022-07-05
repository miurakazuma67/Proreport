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
        setTabbarColor()
        self.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
       }

    ///tabbarの色変更
    private func setTabbarColor() {
        self.tabBar.tintColor = Colors.MainGreen
        self.tabBar.barTintColor = Colors.PopGreen

        //ios15対応
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = Colors.PopGreen
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
