//
//  Colors + Utility.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/10/09.
//


import Foundation
import UIKit

extension UIColor {
    /// degree分白くする
    func whitlyColor(degree: CGFloat) -> UIColor {
        return UIColor(
            red:   (1.0 - self.red()) * degree + self.red(),
            green: (1.0 - self.green()) * degree + self.green(),
            blue:  (1.0 - self.blue()) * degree + self.blue(),
            alpha: alphaColor())
    }
    
    /// カラーコードからUIColor生成
    convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    convenience init?(hex: String, alpha: Double = 1.0) {
        let r, g, b: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
                    return
                }
            }
        }
        
        return nil
    }
}

extension UIColor {
    /// 色から、RGB+Alphaに変換する
    func convertToRGBA() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let components = cgColor.components!
        return (red: components[0], green: components[1], blue: components[2], alpha: components[3])
    }
    /// 色から、赤を取り出す
    func red() -> CGFloat {
        return convertToRGBA().red
    }
    /// 色から、緑を取り出す
    func green() -> CGFloat {
        return convertToRGBA().green
    }
    /// 色から、青を取り出す
    func blue() -> CGFloat {
        return convertToRGBA().blue
    }
    /// 色から、透明度を取り出す
    func alphaColor() -> CGFloat {
        return convertToRGBA().alpha
    }
}
