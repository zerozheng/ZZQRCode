//
//  QRScanComponent.swift
//  QRCode
//
//  Created by zero on 17/2/7.
//  Copyright © 2017年 zero. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

public class QRScanComponent: NSObject, QRScanComponentable {
    
    public var didFoundResultHandle: ((String) -> ())?
    
    public var metadataObjectTypes: [String]!
    
    private(set) lazy public var session: AVCaptureSession? = {
        let session = AVCaptureSession()
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do {
            let input: AVCaptureDeviceInput = try AVCaptureDeviceInput(device: device)
            session.addInput(input)
        }catch{
            return nil
        }
        
        let output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        session.addOutput(output)
        output.metadataObjectTypes = self.metadataObjectTypes
        return session
    }()
    
    private(set) lazy public var layer: AVCaptureVideoPreviewLayer? = {
        guard let _ = self.session else {
            return nil
        }
        let layer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session!)
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        return layer
    }()
    
    init?(types: [String] = [AVMetadataObjectTypeQRCode]) {
        self.metadataObjectTypes = types
        super.init()
        guard let _ = session, let _ = layer else {
            return nil
        }
    }
}

extension QRScanComponent: AVCaptureMetadataOutputObjectsDelegate {
    public func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        guard let result: AVMetadataMachineReadableCodeObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject, metadataObjectTypes.contains(result.type) else {
            return
        }
        
        if let _ = self.didFoundResultHandle {
            self.didFoundResultHandle!(result.stringValue)
        }
    }
}
