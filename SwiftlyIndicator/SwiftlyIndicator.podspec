Pod::Spec.new do |s|

  s.name         = "SwiftlyIndicator"
  s.version      = "1.0.0"
  s.summary      = "SwiftlyIndicator"
  s.description  = "This is such a SwiftylIndcator framework"
  s.homepage     = "https://github.com/jungseungyeo/SwiftlyIndicator"
  s.license      = "MIT"
  s.author       = { "linsaeng" => "duwjdtmd91@gmail.com" }
  s.ios.deployment_target = "11.0"
  s.swift_version = "4.2"
  s.source       = { :git => "https://github.com/jungseungyeo/SwiftlyIndicator.git", :tag => s.version }
  s.source_files = "SwiftlyIndicator/**/*.swift"

end
