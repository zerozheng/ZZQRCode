#
#  Be sure to run `pod spec lint ZZQRCode.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "ZZQRCode"
  s.version      = "0.0.1"
  s.summary      = "ZZQRCode, detect or generate a qrcode"
  s.description  = <<-DESC
A qrcode framework, which is simple and easy for using, to detect or generate qrCode
                   DESC

  s.homepage     = "https://github.com/zerozheng/ZZQRCode"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = "zero"  # s.platform     = :ios
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/zerozheng/ZZQRCode.git", :tag => s.version }
  s.source_files  = "Source"
  s.pod_target_xcconfig = { 'swift-version' => '3.0' }

end
