#
# Be sure to run `pod lib lint SiFUtilities.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SiFUtilities'
  s.version          = '4.14.0'
  s.summary          = 'A set of utilities for your app.'
  s.swift_versions = ['4.0', '4.2', '5.0', '5.1', "5.2", "5.3"]

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

  s.ios.deployment_target = '9.0'
#  s.frameworks = 'UIKit', 'Foundation', 'AVFoundation', 'CoreData'

  s.default_subspec = 'Default'

  s.subspec 'Foundation' do |co|
      co.source_files = 'Foundation/**/*'
  end
  
  s.subspec 'UIKit' do |co|
      co.source_files = 'UIKit/**/*.swift'
  end
  
  s.subspec 'Media' do |co|
      co.source_files = 'Media/**/*.swift'
  end

  s.subspec 'Endpoint' do |co|
    co.source_files = 'Endpoint/**/*'
  end

  s.subspec 'Helpers' do |co|
    co.source_files = 'Helpers/**/*'
  end

  s.subspec 'IBDesignable' do |co|
    co.source_files = 'IBDesignable/**/*'

    co.dependency 'SiFUtilities/UIKit'
  end

  s.subspec 'KeyValue' do |co|
    co.source_files = 'KeyValue/**/*'
  end

  s.subspec 'Loading' do |co|
      co.source_files = 'Loading/**/*'
  end

  s.subspec 'Localize' do |co|
    co.source_files = 'Localize/**/*.swift'
    co.preserve_paths = 'Localize/localizable2appstrings'
    
    co.dependency 'SiFUtilities/Foundation'
    co.dependency 'SiFUtilities/UIKit'
    co.dependency 'SiFUtilities/Runtime'
    co.dependency 'Localize-Swift'
  end

  s.subspec 'CommandLineTool' do |co|
    co.preserve_paths = 'CommandLineTool/localizable2appstrings'
  end
    
  s.subspec 'Nib' do |co|
    co.source_files = 'Nib/**/*'

    co.dependency 'SiFUtilities/Foundation'
  end

  s.subspec 'Runtime' do |co|
    co.source_files = 'Runtime/**/*'
  end

  s.subspec 'Show' do |co|
    co.source_files = 'Show/**/*'
    
    co.dependency 'SiFUtilities/UIKit'
  end

  s.subspec 'WeakObject' do |co|
    co.source_files = 'WeakObject/**/*'
  end

  s.subspec 'Default' do |co|
    co.dependency 'SiFUtilities/Foundation'
    co.dependency 'SiFUtilities/UIKit'
    co.dependency 'SiFUtilities/Media'
    co.dependency 'SiFUtilities/Endpoint'
    co.dependency 'SiFUtilities/Helpers'
    co.dependency 'SiFUtilities/IBDesignable'
    co.dependency 'SiFUtilities/KeyValue'
    co.dependency 'SiFUtilities/Loading'
    co.dependency 'SiFUtilities/Localize'
    co.dependency 'SiFUtilities/Nib'
    co.dependency 'SiFUtilities/Runtime'
    co.dependency 'SiFUtilities/Show'
    co.dependency 'SiFUtilities/WeakObject'
  end
end
