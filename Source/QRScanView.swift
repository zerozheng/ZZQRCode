//
//  QRScanView.swift
//  QRCode
//
//  Created by zero on 17/2/7.
//  Copyright © 2017年 zero. All rights reserved.
//

import Foundation
import UIKit

class QRScanView: UIView, QRScanViewable {
    var rectOfInterest: CGRect = CGRect.zero
    lazy var beginScanHandle: (()->())? = { [unowned self] in
        self.imageView.isHidden = false
        self.link?.isPaused = false
    }
    
    lazy var finishScanHandle: (()->())? = {[unowned self] in
        self.link?.isPaused = true
        self.link?.remove(from: RunLoop.current, forMode:.commonModes)
        self.link?.invalidate()
        self.link = nil
        self.imageView.isHidden = true
    }
    
    lazy var link: CADisplayLink? = {
        let link = CADisplayLink(target: QRScanProxy(target:self), selector: #selector(QRScanProxy.linkHandle(link:)))
        link.add(to: RunLoop.current, forMode: .commonModes)
        link.isPaused = true
        return link
    }()
    
    lazy var maskLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor(white: 0, alpha: 0.5).cgColor
        layer.mask = self.shapeLayer
        return layer
    }()
    
    lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        return layer
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "将二维码放在扫描框内即可自动扫描"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    lazy var box: QRScanBox = {
        let box = QRScanBox()
        return box
    }()
    
    lazy var gradientLayer:CALayer = {
        let layer = CALayer()
        layer.contents = UIImage(named: "scanline.jpeg")?.cgImage
        layer.isHidden = true
        return layer
    }()
    
    lazy var imageView: UIView = {
        let imageView = UIView()
        imageView.backgroundColor = UIColor.green
        imageView.contentMode = .scaleToFill
        imageView.isHidden = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(maskLayer)
        self.addSubview(self.box)
        self.box.addSubview(self.imageView)
        self.addSubview(self.label)
        configuration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuration() {
        maskLayer.frame = self.frame
        
        let w = ceil(min(self.bounds.maxX, self.bounds.maxY)*0.6)
        let x = ceil((self.bounds.maxX-w)*0.5)
        let y = ceil((self.bounds.maxY-w)*0.5)
        
        let path = UIBezierPath(rect: self.bounds)
        path.append(UIBezierPath(roundedRect: CGRect(x: x, y: y, width: w, height: w), cornerRadius: 0).reversing())
        self.shapeLayer.path = path.cgPath
        self.rectOfInterest = CGRect(x: x, y: y, width: w, height: w)
        self.box.frame = CGRect(x: x, y: y, width: w, height: w)
        self.imageView.frame = CGRect(x: 10, y: 0, width: max(w-20,0), height: 1)
        self.label.frame = CGRect(x: x, y: y+w+10, width: w, height: 20)
        
    }
    
}


class QRScanProxy {
    weak var target: QRScanView?
    
    init(target: QRScanView?) {
        self.target = target
    }
    
    @objc func linkHandle(link: CADisplayLink) {
        guard let scanView = self.target else {
            return
        }
        
        let maxY = scanView.imageView.frame.maxY
        let totalHeight = scanView.box.frame.height
        
        if maxY < totalHeight {
            scanView.imageView.frame.origin.y += 1
        }else {
            scanView.imageView.frame.origin.y = 0
        }
    }
    
}


class QRScanBox: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        if rect.width == 0 || rect.height == 0 {
            return
        }
        
        var path = UIBezierPath(rect: rect)
        path.lineWidth = 3
        UIColor.white.setStroke()
        //UIColor.clear.setFill()
        path.stroke()
        
        guard rect.width >= 80 && rect.height >= 80 else{
            return
        }
        
        UIColor.green.setStroke()
        path = UIBezierPath()
        path.lineWidth = 5
        path.move(to: CGPoint(x: rect.minX, y: rect.minY+20))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX+20, y: rect.minY))
        path.stroke()
        
        path = UIBezierPath()
        path.lineWidth = 5
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY+20))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX-20, y: rect.minY))
        path.stroke()
        
        path = UIBezierPath()
        path.lineWidth = 5
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY-20))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX+20, y: rect.maxY))
        path.stroke()
        
        path = UIBezierPath()
        path.lineWidth = 5
        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY-20))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX-20, y: rect.maxY))
        path.stroke()
        
    }
}
