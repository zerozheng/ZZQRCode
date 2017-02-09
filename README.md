# ZZQRCode

简单的`二维码`扫描器，不仅可以扫描二维码，生成二维码，还可以直接识别图片中的二维码
![GitHub set up-w300](https://github.com/zerozheng/ZZQRCode/blob/master/Resources/generate.png)
![GitHub set up-w300](https://github.com/zerozheng/ZZQRCode/blob/master/Resources/scan.png)

sample code
```
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
```


