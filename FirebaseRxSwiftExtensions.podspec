

Pod::Spec.new do |s|
  s.name             = "FirebaseRxSwiftExtensions"
  s.version          = "0.4"
  s.summary          = "RxSwift method Extensions on Firebase's Objects to create highly functional responsive systems"
  s.homepage         = "https://github.com/mbalex99/FirebaseRxSwiftExtensions"
  s.license          = 'MIT'
  s.author           = { "Maximilian Alexander" => "mbalex99@gmail.com" }
  s.source           = { :git => "https://github.com/mbalex99/FirebaseRxSwiftExtensions.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mbalex99'

  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.8'
  s.frameworks = ['CFNetwork', 'Security', 'Firebase', 'SystemConfiguration']
  s.libraries = ['icucore', 'c++']
  s.dependency 'Firebase', '~> 2.3.3'
  s.dependency 'RxSwift', '~> 1.8.1'
  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '"${PODS_ROOT}/Firebase"' }
end
