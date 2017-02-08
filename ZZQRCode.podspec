Pod::Spec.new do |s|

  s.name         = "ZZQRCode"
  s.version      = "0.0.3"
  s.summary      = "ZZQRCode, detect or generate a qrcode"
  s.description  = <<-DESC
A qrcode framework, which is simple and easy for using, to detect or generate qrCode
                   DESC

  s.homepage     = "https://github.com/zerozheng/ZZQRCode"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "zero"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/zerozheng/ZZQRCode.git", :tag => s.version }
  s.source_files  = "Source"

end
