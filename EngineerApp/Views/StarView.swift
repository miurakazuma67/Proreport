//
//  StarView.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2022/01/13.
//

import UIKit

// MARK: - StarView
/// ★を表示するカスタムビュー
@IBDesignable
public final class StarView: UIView {

    // MARK: -

    /// ★の塗りつぶしの色
    @IBInspectable public var fillColor: UIColor = UIColor.black
    /// ★の枠線の色
    @IBInspectable public var strokeColor: UIColor = UIColor.black
    /// ★の丸み
    @IBInspectable public var roundness: CGFloat = 40
    /// ★の角の数
    @IBInspectable public var vertexes: Int = 5
    /// ★のパディング
    @IBInspectable public var padding: CGFloat = 0
    /// ★の枠線
    @IBInspectable public var lineWidth: CGFloat = 0

    // MARK: -

    override public func draw(_ rect: CGRect) {
        // 星型のパスを作成する
        let starPath = UIBezierPath
            .polygon(.starVertexes(
                in: rect,
                padding: padding,
                roundness: roundness,
                numberOfVertexes: vertexes))
            .configure(
                lineWidth: lineWidth)

        // 星を塗りつぶす
        fillColor.setFill()
        starPath.fill()

        // 星に枠線を引く
        strokeColor.setStroke()
        starPath.stroke()
    }
}


// MARK: - Array<CGPoint>
private extension Array where Element==CGPoint {

    /// 星型正多角形の頂点
    ///
    /// - Parameters:
    ///   - frame: 外接する矩形
    ///   - padding: パディング
    ///   - roundness: 外接円と内接円の比（min:0, max:100）
    ///   - vertexes: 外接正多角形の頂点の数
    static func starVertexes(in frame: CGRect, padding: CGFloat, roundness: CGFloat, numberOfVertexes vertexes: Int) -> [CGPoint] {
        return starVertexes(
            radius: Swift.min(frame.width-padding, frame.height-padding)/2,
            center: CGPoint(x: frame.midX, y: frame.midY),
            roundness: Swift.max(Swift.min(roundness, 100), 0)/100,
            numberOfVertexes: Swift.max(vertexes, 2))
    }

    /// 星型正多角形の頂点
    ///
    /// - Parameters:
    ///   - radius: 外接円の半径
    ///   - center: 中心の座標
    ///   - roundness: 外接円と内接円の比（min:0, max:1）
    ///   - vertexes: 外接正多角形の頂点の数
    static func starVertexes(radius: CGFloat, center: CGPoint, roundness: CGFloat, numberOfVertexes vertexes: Int) -> [CGPoint] {
        let vertexes = (vertexes * 2)
        return [Int](0...vertexes).map { offset in
            let r = (offset % 2 == 0) ? radius : roundness * radius
            let θ = CGFloat(offset)/CGFloat(vertexes) * (2 * CGFloat.pi) - CGFloat.pi/2
            return CGPoint(x: r * cos(θ) + center.x, y: r * sin(θ) + center.y)
        }
    }
}

// MARK: - UIBezierPath
private extension UIBezierPath {

    /// 頂点から頂点へ直線を引き、閉じたパスを作る
    ///
    /// - Parameter vertexes: 頂点
    static func polygon(_ vertexes: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        /// 最初の頂点へ移動
        path.move(to: vertexes.first!)
        /// 頂点から頂点へ線を引く
        vertexes.forEach { path.addLine(to: $0) }
        /// 曲線を閉じる
        path.close()

        return path
    }

    @discardableResult
    func configure(lineWidth width: CGFloat,
                   capStyle: CGLineCap = .butt,
                   joinStyle: CGLineJoin = .miter) -> UIBezierPath {
        lineWidth = width
        lineCapStyle = capStyle
        lineJoinStyle = joinStyle
        return self
    }
}
