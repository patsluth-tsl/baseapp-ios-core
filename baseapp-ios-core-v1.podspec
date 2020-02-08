#
# Be sure to run `pod lib lint baseapp-ios-core-v1.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'baseapp-ios-core-v1'
  s.version          = '0.1.0'
  s.summary          = 'A short description of baseapp-ios-core-v1.'
  s.description      = s.summary
  s.homepage         = 'https://bitbucket.org/silverlogic/baseapp-ios-core-v1'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'patsluth' => 'ps@tsl.io' }
  s.source           = { :git => 'https://bitbucket.org/silverlogic/baseapp-ios-core-v1', :tag => s.version.to_s }
  
  s.swift_version = '5.0'
  s.requires_arc = true
  s.static_framework = true

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.11'
  
  s.default_subspecs = 'Default'

  s.source_files = 'baseapp-ios-core-v1/Classes/**/*'
  
  s.default_subspecs = 'Default'
  
  
  
  
  
  s.subspec 'Default' do |ss|
      ss.ios.dependency 'RxSwift'
      ss.ios.dependency 'RxCocoa'
      ss.ios.dependency 'RxSwiftExt'
      ss.ios.dependency 'PromiseKit'
      ss.ios.dependency 'CancelForPromiseKit'
      ss.ios.dependency 'Kingfisher', '~> 5.9.0'
      ss.ios.dependency 'SwiftDate'
      ss.ios.dependency 'SwiftyBeaver'
      ss.ios.dependency 'R.swift'
      ss.ios.dependency 'SegueManager/R.swift'
      
      ss.ios.frameworks = 'Foundation',
      'CoreFoundation',
      'CoreGraphics',
      'CoreLocation',
      'UIKit',
      'SystemConfiguration',
      'AVKit'
      ss.osx.frameworks = 'Foundation',
      'CoreFoundation',
      'CoreGraphics',
      'CoreLocation',
      'SystemConfiguration'
      
      ss.ios.source_files = 'baseapp-ios-core-v1/Classes/Default/**/*',
      ss.osx.source_files = 'baseapp-ios-core-v1/Classes/Default/**/*',
      
      ss.ios.resource = 'baseapp-ios-core-v1/Resources/**/*'
      ss.osx.resource = 'baseapp-ios-core-v1/Resources/**/*'
      # ss.resource_bundles = {
      #   'baseapp-ios-core-v1' => ['baseapp-ios-core-v1/Assets/*.png']
      # }
  end
  
  s.subspec 'simd' do |ss|
      ss.dependency 'baseapp-ios-core-v1/Default'
      
      ss.frameworks = 'Foundation',
      'CoreFoundation'
      
      ss.ios.source_files = 'baseapp-ios-core-v1/Classes/simd/**/*'
  end
  
  s.subspec 'SceneKit' do |ss|
      ss.dependency 'baseapp-ios-core-v1/Default'
      ss.dependency 'baseapp-ios-core-v1/simd'
      
      ss.frameworks = 'Foundation',
      'CoreFoundation',
      'SceneKit'
      
      ss.ios.source_files = 'baseapp-ios-core-v1/Classes/SceneKit/**/*'
  end
  
  s.subspec 'ARKit' do |ss|
      ss.dependency 'baseapp-ios-core-v1/Default'
      ss.dependency 'baseapp-ios-core-v1/SceneKit'
      ss.dependency 'baseapp-ios-core-v1/simd'
      
      ss.frameworks = 'Foundation',
      'CoreFoundation',
      'ARKit'
      
      ss.ios.source_files = 'baseapp-ios-core-v1/Classes/ARKit/**/*'
  end

end
