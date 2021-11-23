//
//  PlaceholderNoPaddingTextView.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/11/20.
//

import UIKit

//refs: https://qiita.com/uhooi/items/40059a1d987b64fd1aa7

/// Placeholderを持ち、PaddingがないUITextView
@IBDesignable class PlaceholderNoPaddingTextView: NoPaddingTextView {

    // MARK: Stored Instance Properties

    @IBInspectable private var placeHolder: String = "" {
        willSet {
            self.placeHolderLabel.text = newValue
            self.placeHolderLabel.sizeToFit()
        }
    }
    
    override var text: String! {
        didSet {
            changeVisiblePlaceHolder()
        }
    }
    
    private lazy var placeHolderLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0.0, height: 0.0))
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = self.font
        label.textColor = UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
        label.backgroundColor = .clear
        self.addSubview(label)
        return label
    }()

    // MARK: Initializers

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: View Life-Cycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        changeVisiblePlaceHolder()
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged),
                                               name: UITextView.textDidChangeNotification, object: nil)
    }

    // MARK: Other Private Methods

    private func changeVisiblePlaceHolder() {
        self.placeHolderLabel.alpha = (self.placeHolder.isEmpty || !self.text.isEmpty) ? 0.0 : 1.0
    }

    @objc private func textChanged(notification: NSNotification?) {
        changeVisiblePlaceHolder()
    }

}

