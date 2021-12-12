//
//  StarView.swift
//  EngineerApp
//
//  Created by 三浦　一真 on 2021/09/19.
//

import UIKit

// 5個の星のView
class RatingStarView: UIView {
    
    @IBInspectable var rate: CGFloat = 0
    @IBInspectable var starColor: UIColor = UIColor.yellow
    @IBInspectable var emptyColor: UIColor = UIColor.lightGray
    @IBInspectable var starSize: CGFloat = 30
    @IBInspectable var margin: CGFloat = 5          // ★と★の間隔
    @IBInspectable var paddingTop: CGFloat = 0
    @IBInspectable var paddingBottom: CGFloat = 0
    @IBInspectable var paddingLeft: CGFloat = 0
    @IBInspectable var paddingRight: CGFloat = 0
    
    /// 外枠と星の間
    var padding: UIEdgeInsets {
        return UIEdgeInsets(top: paddingTop, left: paddingLeft, bottom: paddingBottom, right: paddingRight)
    }
    /// サイズを取得
    func getTotalSize() -> CGSize {
        let width = padding.left + starSize * 5.0 + margin * 4.0 + padding.right
        let height = padding.top + starSize + padding.bottom
        return CGSize(width: width, height: height)
    }
    var innerView: UIView?

    override func awakeFromNib() {
        refresh(rate: rate)
    }

    func setup(rate: CGFloat, starColor: UIColor? = nil, emptyColor: UIColor? = nil, starSize: CGFloat? = nil, margin: CGFloat? = nil, padding: UIEdgeInsets? = nil) {
        
        self.rate = rate
        if let starColor = starColor {
            self.starColor = starColor
        }
        if let emptyColor = emptyColor {
            self.emptyColor = emptyColor
        }
        if let starSize = starSize {
            self.starSize = starSize
        }
        if let margin = margin {
            self.margin = margin
        }
        if let padding = padding {
            self.paddingTop = padding.top
            self.paddingLeft = padding.left
            self.paddingRight = padding.right
            self.paddingBottom = padding.bottom
        }
                
        refresh(rate: rate)
    }
    
    /// rateを更新（innerViewの作り直し）
    func refresh(rate: CGFloat) {
        innerView?.removeFromSuperview()
        let newOne = create(rate: rate)
        self.addSubview(newOne)
        innerView = newOne
    }
}


extension RatingStarView {
    
    private func create(rate: CGFloat) -> UIView {
        let ratingStarView = createRatingView(rate: rate, starColor: starColor, emptyColor: emptyColor, starSize: starSize, margin: margin, padding: padding)
        return ratingStarView
    }
    
    private func createRatingView(rate: CGFloat,
                                  starColor: UIColor,
                                  emptyColor: UIColor,
                                  starSize: CGFloat,
                                  margin: CGFloat,
                                  padding: UIEdgeInsets) -> UIView {
        
        let starImage = UIImage(named: "star_fill")!.cgImage
        
        // 総合サイズ
        let width = padding.left + starSize * 5.0 + margin * 4.0 + padding.right
        let height = padding.top + starSize + padding.bottom
        
        let ratingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        ratingView.backgroundColor = .clear
        
        
        // star1　☆★★★★
        let emptyLayer1 = CALayer()
        emptyLayer1.frame = CGRect(x: padding.left,
                                   y: padding.top,
                                   width: starSize,
                                   height: starSize)
        emptyLayer1.backgroundColor = emptyColor.cgColor
        
        let emptyMask1 = CALayer()
        emptyMask1.contents = starImage
        emptyMask1.contentsGravity = CALayerContentsGravity.resizeAspect
        emptyMask1.bounds = CGRect(x: 0, y: 0, width: starSize, height: starSize)
        emptyMask1.position = CGPoint(x: starSize/2.0, y: starSize/2.0)
        emptyLayer1.mask = emptyMask1
        
        ratingView.layer.addSublayer(emptyLayer1)
        
        // star2　★☆★★★
        let emptyLayer2 = CALayer()
        emptyLayer2.frame = CGRect(x: padding.left + starSize * 1.0 + margin * 1.0,
                                   y: padding.top,
                                   width: starSize,
                                   height: starSize)
        emptyLayer2.backgroundColor = emptyColor.cgColor
        
        let emptyMask2 = CALayer()
        emptyMask2.contents = starImage
        emptyMask2.contentsGravity = CALayerContentsGravity.resizeAspect
        emptyMask2.bounds = CGRect(x: 0, y: 0, width: starSize, height: starSize)
        emptyMask2.position = CGPoint(x: starSize/2.0, y: starSize/2.0)
        emptyLayer2.mask = emptyMask2
        
        ratingView.layer.addSublayer(emptyLayer2)
        
        // star3　★★☆★★
        let emptyLayer3 = CALayer()
        emptyLayer3.frame = CGRect(x: padding.left + starSize * 2.0 + margin * 2.0,
                                   y: padding.top,
                                   width: starSize,
                                   height: starSize)
        emptyLayer3.backgroundColor = emptyColor.cgColor
        
        let emptyMask3 = CALayer()
        emptyMask3.contents = starImage
        emptyMask3.contentsGravity = CALayerContentsGravity.resizeAspect
        emptyMask3.bounds = CGRect(x: 0, y: 0, width: starSize, height: starSize)
        emptyMask3.position = CGPoint(x: starSize/2.0, y: starSize/2.0)
        emptyLayer3.mask = emptyMask3
        
        ratingView.layer.addSublayer(emptyLayer3)
        
        // star4　★★★☆★
        let emptyLayer4 = CALayer()
        emptyLayer4.frame = CGRect(x: padding.left + starSize * 3.0 + margin * 3.0,
                                   y: padding.top,
                                   width: starSize,
                                   height: starSize)
        emptyLayer4.backgroundColor = emptyColor.cgColor
        
        let emptyMask4 = CALayer()
        emptyMask4.contents = starImage
        emptyMask4.contentsGravity = CALayerContentsGravity.resizeAspect
        emptyMask4.bounds = CGRect(x: 0, y: 0, width: starSize, height: starSize)
        emptyMask4.position = CGPoint(x: starSize/2.0, y: starSize/2.0)
        emptyLayer4.mask = emptyMask4
        
        ratingView.layer.addSublayer(emptyLayer4)
        
        // star5　★★★★☆
        let emptyLayer5 = CALayer()
        emptyLayer5.frame = CGRect(x: padding.left + starSize * 4.0 + margin * 4.0,
                                   y: padding.top,
                                   width: starSize,
                                   height: starSize)
        emptyLayer5.backgroundColor = emptyColor.cgColor
        
        let emptyMask5 = CALayer()
        emptyMask5.contents = starImage
        emptyMask5.contentsGravity = CALayerContentsGravity.resizeAspect
        emptyMask5.bounds = CGRect(x: 0, y: 0, width: starSize, height: starSize)
        emptyMask5.position = CGPoint(x: starSize/2.0, y: starSize/2.0)
        emptyLayer5.mask = emptyMask5
        
        ratingView.layer.addSublayer(emptyLayer5)
        
        
        
        // star1　★☆☆☆☆
        let starLayer1 = CALayer()
        starLayer1.frame = CGRect(x: padding.left,
                                  y: padding.top,
                                  width: (rate >= 1) ? starSize : (rate < 0) ? 0 : starSize * (rate),
                                  height: starSize)
        starLayer1.backgroundColor = starColor.cgColor
        
        let mask1 = CALayer()
        mask1.contents = starImage
        mask1.contentsGravity = CALayerContentsGravity.resizeAspect
        mask1.bounds = CGRect(x: 0, y: 0, width: starSize, height: starSize)
        mask1.position = CGPoint(x: starSize/2.0, y: starSize/2.0)
        starLayer1.mask = mask1
        
        ratingView.layer.addSublayer(starLayer1)
        
        
        // star2　☆★☆☆☆
        let starLayer2 = CALayer()
        starLayer2.frame = CGRect(x: padding.left + starSize * 1.0 + margin * 1.0,
                                  y: padding.top,
                                  width: (rate >= 2) ? starSize : (rate < 1) ? 0 : starSize * (rate - 1.0),
                                  height: starSize)
        starLayer2.backgroundColor = starColor.cgColor
        
        let mask2 = CALayer()
        mask2.contents = starImage
        mask2.contentsGravity = CALayerContentsGravity.resizeAspect
        mask2.bounds = CGRect(x: 0, y: 0, width: starSize, height: starSize)
        mask2.position = CGPoint(x: starSize/2.0, y: starSize/2.0)
        starLayer2.mask = mask2
        
        ratingView.layer.addSublayer(starLayer2)
        
        
        // star3　☆☆★☆☆
        let starLayer3 = CALayer()
        starLayer3.frame = CGRect(x: padding.left + starSize * 2.0 + margin * 2.0,
                                  y: padding.top,
                                  width: (rate >= 3) ? starSize : (rate < 2) ? 0 : starSize * (rate - 2.0),
                                  height: starSize)
        starLayer3.backgroundColor = starColor.cgColor
        
        let mask3 = CALayer()
        mask3.contents = starImage
        mask3.contentsGravity = CALayerContentsGravity.resizeAspect
        mask3.bounds = CGRect(x: 0, y: 0, width: starSize, height: starSize)
        mask3.position = CGPoint(x: starSize/2.0, y: starSize/2.0)
        starLayer3.mask = mask3
        
        ratingView.layer.addSublayer(starLayer3)
        
        // star4　☆☆☆★☆
        let starLayer4 = CALayer()
        starLayer4.frame = CGRect(x: padding.left + starSize * 3.0 + margin * 3.0,
                                  y: padding.top,
                                  width: (rate >= 4) ? starSize : (rate < 3) ? 0 : starSize * (rate - 3.0),
                                  height: starSize)
        starLayer4.backgroundColor = starColor.cgColor
        
        let mask4 = CALayer()
        mask4.contents = starImage
        mask4.contentsGravity = CALayerContentsGravity.resizeAspect
        mask4.bounds = CGRect(x: 0, y: 0, width: starSize, height: starSize)
        mask4.position = CGPoint(x: starSize/2.0, y: starSize/2.0)
        starLayer4.mask = mask4
        
        ratingView.layer.addSublayer(starLayer4)
        
        // star5　☆☆☆☆★
        let starLayer5 = CALayer()
        starLayer5.frame = CGRect(x: padding.left + starSize * 4.0 + margin * 4.0,
                                  y: padding.top,
                                  width: (rate >= 5) ? starSize : (rate < 4) ? 0 : starSize * (rate - 4.0),
                                  height: starSize)
        starLayer5.backgroundColor = starColor.cgColor
        
        let mask5 = CALayer()
        mask5.contents = starImage
        mask5.contentsGravity = CALayerContentsGravity.resizeAspect
        mask5.bounds = CGRect(x: 0, y: 0, width: starSize, height: starSize)
        mask5.position = CGPoint(x: starSize/2.0, y: starSize/2.0)
        starLayer5.mask = mask5
        
        ratingView.layer.addSublayer(starLayer5)
        
        return ratingView
    }
    
    
}
