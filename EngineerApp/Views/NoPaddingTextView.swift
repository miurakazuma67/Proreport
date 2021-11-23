//
//  NoPaddingTextView.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/11/20.
//

import UIKit

@IBDesignable class NoPaddingTextView: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        removePadding()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        removePadding()
    }
}
