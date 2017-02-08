//
//  ScanVC.swift
//  QRCode
//
//  Created by zero on 17/2/7.
//  Copyright © 2017年 zero. All rights reserved.
//

import UIKit

@objc protocol ScanVCDelegate: NSObjectProtocol {
    func scanVC(vc:ScanVC, didFoundResult result: String)
}


class ScanVC: UIViewController {

    weak var delegate: ScanVCDelegate?
    
    var qrScaner: QRScaner?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let qrScanView: QRScanView = QRScanView(frame: self.view.bounds)
        
        self.qrScaner = QRScaner(view: qrScanView, didFoundResultHandle: { [unowned self] (string) in
            
            let _ = self.navigationController?.popViewController(animated: true)

            
            if let delegate = self.delegate, delegate.responds(to: #selector(ScanVCDelegate.scanVC(vc:didFoundResult:))) {
                delegate.scanVC(vc: self, didFoundResult: string)
            }
            
        })
        
        if let qrScaner = self.qrScaner {
            self.view.addSubview(qrScanView)
            qrScaner.startScanning()
        }
    }
}
