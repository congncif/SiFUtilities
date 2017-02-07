#
# Be sure to run `pod lib lint SiFUtilities.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SiFUtilities'
  s.version          = '1.2.6'
  s.summary          = 'A set of utilities for app.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
- Get instance view controller from Storyboard shortly
- Handle viewcontroller did finished layout at first time
- Configure status bar quickly
- More extensions
                       DESC

  s.homepage         = 'https://github.com/congncif/SiFUtilities'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'NGUYEN CHI CONG' => 'congnc.if@gmail.com' }
  s.source           = { :git => 'https://github.com/congncif/SiFUtilities.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/congncif'

  s.ios.deployment_target = '8.0'

  #s.source_files = 'SiFUtilities/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SiFUtilities' => ['SiFUtilities/Assets/*.png']
  # }

s.vendored_frameworks = 'SiFUtilities/SiFUtilities.framework'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
