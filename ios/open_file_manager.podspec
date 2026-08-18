#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint open_file_manager.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'open_file_manager'
  s.version          = '0.1.1'
  s.summary          = 'A flutter plugin to open default file manager app'
  s.description      = <<-DESC
A flutter plugin to open default file manager app
                       DESC
  s.homepage         = 'https://www.aubergine.co'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Aubergine Solutions Pvt. Ltd.' => 'flutterdev@aubergine.co' }
  s.source           = { :path => '.' }
  s.source_files = 'open_file_manager/Sources/open_file_manager/**/*.swift'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
