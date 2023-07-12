#
# Be sure to run `pod lib lint HYUKSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HYUKSDK'
  s.version          = '0.1.4'
  s.summary          = 'A short description of HYUKSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A short description of LHYADTool Test.
                       DESC

  s.homepage         = 'https://github.com/huboceanLi/HYUKSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'li437277219@gmail.com' => 'li437277219@gmail.com' }
  s.source           = { :git => 'https://github.com/huboceanLi/HYUKSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.requires_arc = true
  #s.swift_version = '5.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.static_framework = true
  s.source_files = 'HYUKSDK/Classes/**/*'
  s.resources = "HYUKSDK/Resources/*"
  
  # s.resource_bundles = {
  #   'HYUKSDK' => ['HYUKSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.dependency "QMUIKit"
  s.dependency "Masonry"
  s.dependency "HYBaseTool", '1.0.4'
  s.dependency "AFNetworking"
  s.dependency "CTNetworking"
  s.dependency "MBProgressHUD+JDragon"
  s.dependency "JXCategoryView"
  s.dependency "WCDB.swift", '1.1.0'
  s.dependency "YYModel"
  s.dependency "YYText"
  s.dependency "YYCategories"
  s.dependency "YYWebImage"
  s.dependency "MJRefresh"
  
  s.dependency "Bugly"

  s.dependency "Ads-CN"
  s.dependency "UMCommon"

end
