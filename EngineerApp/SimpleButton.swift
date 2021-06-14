//
//  SimpleButton.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2020/11/26.
//

import UIKit

class SimpleButton: UIButton {
    
    var selectView: UIView! = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        myInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        myInit()
    }
    
    func myInit() {
        // 角を丸くする
        self.layer.cornerRadius = 10
        self.layer.cornerCurve = .continuous
        self.backgroundColor = UIColor(hexString: "7868e6")
        //影の設定
        self.layer.shadowColor = UIColor.shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 5
        
        // ボタンを押している時にボタンの色を暗くするためのView
        selectView = UIView(frame: self.bounds)
        selectView.backgroundColor = UIColor.black
        selectView.alpha = 0.0
        self.addSubview(selectView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectView.frame = self.bounds
    }
    
    // タッチ開始
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {() -> Void in
            self.selectView.alpha = 0.5
        }, completion: {(finished: Bool) -> Void in
        })
    }
    
    // タッチ終了
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveLinear, animations: {() -> Void in
            
            self.selectView.alpha = 0.0
            
        }, completion: {(finished: Bool) -> Void in
        })
    }
}

extension UIColor {
    static let shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
}
