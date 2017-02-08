//
//  QRCode.swift
//  QRCode
//
//  Created by zero on 17/2/6.
//  Copyright © 2017年 zero. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

public protocol QRScanerable {
    var view: QRScanViewable {get}
    var component: QRScanComponentable {get}

    func startScanning()
    func stopScanning()
}

public protocol QRScanComponentable {
    var metadataObjectTypes: [String]! {get}
    var session: AVCaptureSession? {get}
    var layer: AVCaptureVideoPreviewLayer? {get}
    
    var didFoundResultHandle: ((String) -> ())? {get set}
}

public protocol QRScanViewable {
    var rectOfInterest: CGRect {get set}
    
    var beginScanHandle: (()->())? {get set}
    var finishScanHandle: (()->())? {get set}
}
