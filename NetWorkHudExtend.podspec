#
# Be sure to run `pod lib lint NetWorkHudExtend.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NetWorkHudExtend'
  s.version          = '1.3.0'
  s.summary          = 'A short description of NetWorkHudExtend.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: AFNetworking的二次封装+Hud的二次封装结合使用
                       DESC

  s.homepage         = 'https://github.com/YueWangChina/NetWorkHudExtend'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '454431208@qq.com' => 'wangyuexdy@163.com' }
  s.source           = { :git => 'https://github.com/YueWangChina/NetWorkHudExtend.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.source_files='NetWorkHudExtend/Classes/HUDExtend/*.{h,m}','NetWorkHudExtend/Classes/NetWork/*.{h,m}','NetWorkHudExtend/Classes/*.{h}'
  #  end
  #  s.subspec 'NetWork' do |netWork|
  #      netWork.source_files=
  #  end
  # s.resource_bundles = {
  #   'NetWorkHudExtend' => ['NetWorkHudExtend/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'AFNetworking', 'MBProgressHUD'
    s.dependency 'AFNetworking'
    s.dependency 'MBProgressHUD'
end
