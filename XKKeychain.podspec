#
# Be sure to run `pod lib lint XKKeychain.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "XKKeychain"
  s.version          = "1.0.1"
  s.summary          = "A completely flexible keychain wrapper for generic password keychain items."
  s.description      = <<-DESC
                       XKKeychain provides a flexible and generic Objective C wrapper for accessing the keychain.
                       It provides access to all of the possible attributes, so that it should suit all applications,
                       while still being simple and convenient to use.
                       DESC
  s.homepage         = "https://github.com/karlvr/XKKeychain"
  s.license          = 'MIT'
  s.author           = { "Karl von Randow" => "karl@xk72.com" }
  s.source           = { :git => "https://github.com/karlvr/XKKeychain.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/avon'

  s.ios.deployment_target = '7.0'
  s.tvos.deployment_target = '9.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
end
