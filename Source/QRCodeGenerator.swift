//
//  QRCodeGenerator.swift
//  QRCode
//
//  Created by zero on 17/2/7.
//  Copyright © 2017年 zero. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

public class QRCodeGenerator {
    
    class public func generateImage(_ stringValue: String, avatarImage: UIImage?, avatarScale: CGFloat = 0.25, color: UIColor = UIColor.black, backColor: UIColor = UIColor.white) -> UIImage? {
        
        // generate qrcode image
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")!
        qrFilter.setDefaults()
        qrFilter.setValue(stringValue.data(using: String.Encoding.utf8, allowLossyConversion: false), forKey: "inputMessage")
        qrFilter.setValue("H", forKey: "inputCorrectionLevel")
        
        let ciImage = qrFilter.outputImage
        
        // scale qrcode image
        let colorFilter = CIFilter(name: "CIFalseColor")!
        colorFilter.setDefaults()
        colorFilter.setValue(ciImage, forKey: "inputImage")
        colorFilter.setValue(CIColor(color: color), forKey: "inputColor0")
        colorFilter.setValue(CIColor(color: backColor), forKey: "inputColor1")
        
        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let transformedImage = qrFilter.outputImage!.applying(transform)
        
        let image = UIImage(ciImage: transformedImage)
        
        if avatarImage != nil {
            return insertAvatarImage(image, avatarImage: avatarImage!, scale: avatarScale)
        }
        
        return image
    }
    
    class func insertAvatarImage(_ codeImage: UIImage, avatarImage: UIImage, scale: CGFloat) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: codeImage.size.width, height: codeImage.size.height)
        UIGraphicsBeginImageContext(rect.size)
        
        codeImage.draw(in: rect)
        
        let avatarSize = CGSize(width: rect.size.width * scale, height: rect.size.height * scale)
        let x = (rect.width - avatarSize.width) * 0.5
        let y = (rect.height - avatarSize.height) * 0.5
        avatarImage.draw(in: CGRect(x: x, y: y, width: avatarSize.width, height: avatarSize.height))
        
        if avatarSize.width >= 10 && avatarSize.height >= 10, x >= 5, y >= 5 {
            let bpath = UIBezierPath(roundedRect: CGRect(x: x-5, y: y-5, width: avatarSize.width+10, height: avatarSize.height+10), cornerRadius: 5)
            bpath.append(UIBezierPath(roundedRect: CGRect(x: x, y: y, width: avatarSize.width, height: avatarSize.height), cornerRadius: 3).reversing())
            UIColor.white.setFill()
            bpath.fill()
        }
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result!
    }
    
    
}
