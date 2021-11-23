//
//  UITextView+ Utility.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/11/23.
//

import Foundation
import UIKit

extension UITextView {
    /// 余計なpaddingを消す
    func removePadding() {
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0.0
    }
}
