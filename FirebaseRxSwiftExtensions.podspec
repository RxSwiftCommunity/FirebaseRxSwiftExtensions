#
# Be sure to run `pod lib lint FirebaseRxSwiftExtensions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "FirebaseRxSwiftExtensions"
  s.version          = "2.0.3"
  s.summary          = "Untangle your messy Firebase code with RxSwift Extension Methods"

  s.description      = "Firebase is a block or closure based API, unfortunately doing anything robust takes a lot of nesting.
 This makes your code get out hand very fast. RxSwift 2.0.0-beta.3 or higher is required. Swift 2 and XCode 7.1 are required."

  s.homepage         = "https://github.com/mbalex99/FirebaseRxSwiftExtensions"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Maximilian Alexander" => "mbalex99@gmail.com" }
  s.source           = { :git => "https://github.com/mbalex99/FirebaseRxSwiftExtensions.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/mbalex99'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'FirebaseRxSwiftExtensions' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Firebase', '~> 2.4.3'
  s.dependency 'RxSwift', '~> 2.0.0-beta.3'
end
