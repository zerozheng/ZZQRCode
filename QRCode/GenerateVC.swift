//
//  DetectVC.swift
//  QRCode
//
//  Created by zero on 17/2/7.
//  Copyright © 2017年 zero. All rights reserved.
//

import UIKit

class GenerateVC: UIViewController {

    var imageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        self.view.addSubview(imageView)
        
        imageView.frame = CGRect(x: (self.view.bounds.width-200)*0.5, y: (self.view.bounds.height-200)*0.5, width: 200, height: 200)
        // Do any additional setup after loading the view.
    }
}
