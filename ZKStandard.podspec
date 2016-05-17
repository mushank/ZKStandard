
Pod::Spec.new do |s|
  s.name     = 'ZKStandard'
  s.version  = '1.0'
  s.license  = 'MIT'
  s.summary  = 'A basic framework for iOS App written in Objective-C'
  s.homepage = 'https://github.com/mushank/ZKStandard'
  s.author   = { 'Jack' => 'mushank@Gmail.com' }
  s.source   = { :git => 'https://github.com/mushank/ZKStandard.git', :tag => s.version }
  s.platform = :ios  
  s.source_files = 'ZKStandard/ZKStandard.h'
  s.framework = 'UIKit','AFNetworking','MBProgressHUD'
  s.requires_arc = true
end