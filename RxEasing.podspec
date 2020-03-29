#
# Be sure to run `pod lib lint RxEasing.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "RxEasing"
  s.version          = "2.7.0"
  s.summary          = "An easing library for use with RxSwift."

  s.description      = <<-DESC
    RxEasing provides a few utility functions for applying easing functions to RxSwift Observable streams.
  DESC

  s.homepage         = "https://github.com/lintmachine/RxEasing"
  s.license          = 'MIT'
  s.author           = { "cdann" => "cdann@lintmachine.com" }
  s.source           = { :git => "https://github.com/lintmachine/RxEasing.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/lintmachine'

  s.platform     = :ios, '10.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.dependency 'RxSwift', '~> 5.0'
end
