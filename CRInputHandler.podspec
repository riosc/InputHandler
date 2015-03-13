#
# Be sure to run `pod lib lint InputHandler.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CRInputHandler"
  s.version          = "0.1.4"
  s.summary          = "Inputhandler is a helper library that facilitates set on focus an input like UITextField or UITextView in your iOS application."
  s.description      = <<-DESC
                       InputHandler lets manage correctly the keyboard when user taps over an input. Also this class manages the keyboard hiding when user tap outside of input.
                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/riosc/InputHandler"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Carlos Rios" => "rioscarlosd@gmail.com" }
  s.source           = { :git => "https://github.com/riosc/InputHandler.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/cadamel'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'InputHandler' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
