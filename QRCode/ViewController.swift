//
//  ViewController.swift
//  QRCode
//
//  Created by zero on 17/2/6.
//  Copyright © 2017年 zero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func scan(_ sender: Any) {
        
        let vc = ScanVC()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func detect(button:UIButton) {
        QRImageDetector.detectImage(image: button.currentImage!) { (result, error) in
            if error == false {
                self.showMessage(result!)
            }
        }
    }
    
    @IBAction func generate() {
        let image = QRCodeGenerator.generateImage("develop by zero zheng", avatarImage: UIImage(named: "default.jpeg"))
        let vc: GenerateVC = GenerateVC()
        vc.imageView.image = image
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showMessage(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .`default`, handler: nil))
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension ViewController: ScanVCDelegate {
    func scanVC(vc: ScanVC, didFoundResult result: String) {
        self.showMessage(result)
    }
}
