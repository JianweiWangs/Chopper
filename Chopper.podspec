#
# Be sure to run `pod lib lint Chopper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Chopper'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Chopper.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/JianweiWangs/Chopper'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JianweiWangs' => 'wangfei@zhihu.com' }
  s.source           = { :git => 'https://github.com/JianweiWangs/Chopper.git', :tag => s.version.to_s }
  s.platform = :ios, '8.0'
  s.default_subspecs = 'Core'

  s.subspec 'Core' do |sub|
    sub.source_files = 'Chopper/Classes/Core/**/*.swift'
  end

  s.subspec 'Interceptor' do |sub|
    sub.source_files = 'Chopper/Classes/Interceptor/**/*.swift'
    sub.platform = :ios, '11.0'
    sub.dependency 'Chopper/Broswer'
  end

  s.subspec 'Broswer' do |sub|
    sub.source_files = 'Chopper/Classes/Broswer/**/*.swift'
    sub.dependency 'Chopper/Core'
  end
end
