//
//  UITableView+.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/12/08.
//

import UIKit

public extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle = Bundle(for: T.self)) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    func register<T: UITableViewCell>(cellTypes: [T.Type], bundle: Bundle = Bundle(for: T.self)) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}
