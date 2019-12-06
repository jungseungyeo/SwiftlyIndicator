Pod::Spec.new do |s|

  s.name         = "SwiftlyIndicator"
  s.version      = "1.1.3"
  s.summary      = "SwiftylIndcator"
  s.description  = "This is such a SwiftylIndcator framework"
  s.homepage     = "https://github.com/jungseungyeo/SwiftlyIndicator"
  s.license      = "MIT"
  s.author       = { "linsaeng" => "duwjdtmd91@gmail.com" }
  s.platform     = :ios, '13.0'
  s.source       = { :git => "https://github.com/jungseungyeo/SwiftlyIndicator.git", :tag => '1.1.3' }
  s.source_files = "SwiftlyIndicator/**/*.swift"
  s.swift_version = "5.0"
  s.ios.deployment_target = '13.0'


end
