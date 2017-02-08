//
//  QRScaner.swift
//  QRCode
//
//  Created by zero on 17/2/6.
//  Copyright © 2017年 zero. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation



open class QRScaner: NSObject, QRScanerable {
        
    public var view: QRScanViewable
    
    public var component: QRScanComponentable
    
    init?<T: QRScanViewable>(view: T, component: QRScanComponentable? = QRScanComponent(), didFoundResultHandle: ((String) -> ())?) where T: UIView {
        guard let _ = component else {
            return nil
        }
        self.view = view
        self.component = component!
        super.init()
        
        self.component.didFoundResultHandle = { [unowned self] result in
            self.stopScanning()
            didFoundResultHandle?(result)
        }
        configuration()
    }
    
    private func configuration() {
        guard let layer = self.component.layer else {
            return
        }
        
        (self.view as! UIView).layer.insertSublayer(layer, at: 0)
        layer.frame = (self.view as! UIView).frame
        
        NotificationCenter.default.addObserver(self, selector: #selector(rectOfInterestChage), name: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func rectOfInterestChage() {
        guard let session = self.component.session, let layer = self.component.layer else {
            return
        }
        let output = session.outputs.first as! AVCaptureMetadataOutput
        output.rectOfInterest = layer.metadataOutputRectOfInterest(for: self.view.rectOfInterest)
    }
    
    public func startScanning() {
        if let session = self.component.session, session.isRunning != true {
            session.startRunning()
            if let _ = view.beginScanHandle {
                view.beginScanHandle!()
            }
        }
    }
    
    public func stopScanning() {
        if let session = self.component.session, session.isRunning == true {
            session.stopRunning()
            if let _ = view.finishScanHandle {
                view.finishScanHandle!()
            }
        }
    }
}


