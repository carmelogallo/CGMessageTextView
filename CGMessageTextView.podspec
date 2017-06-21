#
# Be sure to run `pod lib lint CGMessageTextView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CGMessageTextView'
  s.version          = '0.1.1'
  s.summary          = 'A UITextView subclass that adds support for changing dinamically the height in base of the text.'
  s.description      = <<-DESC
                       A UITextView subclass that adds support for changing dinamically the height in base of the text. Also it has multiline placeholder thansk to https://github.com/MoZhouqi/KMPlaceholderTextView. All is written in Swift and it use AutoLayout.
                       DESC
  s.homepage         = 'https://github.com/cikpis/CGMessageTextView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Carmelo Gallo' => 'work@carmelogallo.com' }
  s.source           = { :git => 'https://github.com/cikpis/CGMessageTextView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/cikpis'
  s.ios.deployment_target = '8.0'
  s.source_files = 'CGMessageTextView/Classes/**/*'
  s.frameworks = "UIKit"
  s.requires_arc = true
end
