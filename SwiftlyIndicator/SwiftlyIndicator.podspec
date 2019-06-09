Pod::Spec.new do |s|

  s.name = "SwiftlyIndicator"

  s.version = "1.0.2"
  s.license = "MIT"
  s.summary = "SwiftlyIndicator"
  s.homepage = "https://github.com/jungseungyeo/SwiftlyIndicator"
  s.authors = { "linsaeng" => "duwjdtmd91@gmail.com" }
  s.source = { :git => "https://github.com/jungseungyeo/SwiftlyIndicator.git", :tag => s.version }
  s.swift_version = "4.2"

  s.ios.deployment_target = "11.0"

  s.requires_arc = true

  s.default_subspec = "Core"

end
