#
# Be sure to run `pod lib lint SNAdapter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SNAdapter'
  s.version          = '0.0.4'
	s.swift_version   = '4.2'
  s.summary          = 'iOS swift tableview and collectionView Adapter, powered by generics and associated types.'


  s.homepage         = 'https://github.com/ahmedAlmasri/SNAdapter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ahmedAlmasri' => 'ahmed.almasri@ymail.com' }
  s.source           = { :git => 'https://github.com/ahmedAlmasri/SNAdapter.git' }

  s.ios.deployment_target = '10.0'

  s.source_files = 'SNAdapter/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SNAdapter' => ['SNAdapter/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
end
