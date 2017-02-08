//
//  QRImageDetector.swift
//  QRCode
//
//  Created by zero on 17/2/7.
//  Copyright © 2017年 zero. All rights reserved.
//

import Foundation
import CoreImage
import UIKit

public class QRImageDetector {
    
    public class func detectImage(image: UIImage, completeHandle:((_ result:String?, _ error: Bool)->())?) {
        guard let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh]), let ciImage: CIImage = CIImage(image: image) else {
            if let _ = completeHandle {
                completeHandle!(nil,true)
            }
            return
        }
        
        guard let feature: CIQRCodeFeature = detector.features(in: ciImage).first as? CIQRCodeFeature else {
            if let _ = completeHandle {
                completeHandle!(nil,true)
            }
            return
        }
        
        if let _ = completeHandle {
            completeHandle!(feature.messageString,false)
        }
    }
}
