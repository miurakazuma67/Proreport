//
//  TabBarController.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/11/20.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarColor()
        self.delegate = self
    }

    ///tabbarの色変更
    private func setTabBarColor() {
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

extension TabBarController: UITabBarControllerDelegate {
    /// 返り値に指定したUIViewControllerAnimatedTransitioningオブジェクトのanimateTransitionメソッドを使って、アニメーーションさせる
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard
            let viewControllers = tabBarController.viewControllers,
            let fromIndex = viewControllers.firstIndex(of: fromVC),
            let toIndex = viewControllers.firstIndex(of: toVC)
        else { return nil }

        // 横スクロールを生成(trueなら右スクロール、falseなら左スクロール)
        let scrollRight = toIndex > fromIndex

        return TabBarAnimatedTransitioning(scrollRight)
    }
}

// NSObjectプロトコルを継承しているプロトコルなので、NSObject継承
final class TabBarAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    let scrollRight: Bool

    init(_ scrollRight: Bool) {
        self.scrollRight = scrollRight
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from),
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        else { return }

        transitionContext.containerView.addSubview(toView)

        let screenWidth = UIScreen.main.bounds.size.width / 4
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.alpha = 0
        toView.center.x += offset

        // animateメソッドを使うことでアニメーションをおこなってる
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseOut], animations: {

            fromView.alpha = 1
            fromView.center.x = fromView.center.x - offset
            toView.alpha = 1
            toView.center.x = toView.center.x - offset
        }, completion: {
            transitionContext.completeTransition($0)
        })
    }
}
