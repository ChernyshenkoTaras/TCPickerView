Pod::Spec.new do |s|
  s.name             = 'TCPickerView'
  s.version          = '0.2.5'
  s.summary          = 'Picker view popup with multiply rows selection written in Swift'

  s.description      = <<-DESC
    Picker view popup with ability to select multiply rows written in Swift
                       DESC

  s.homepage         = 'https://github.com/ChernyshenkoTaras/TCPickerView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Taras Chernyshenko' => 'taras.chernyshenko@gmail.com' }
  s.source           = { :git => 'https://github.com/ChernyshenkoTaras/TCPickerView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/@t_chernyshenko'

  s.ios.deployment_target = '9.0'

  s.source_files = 'TCPickerView/Source/Classes/**/*'
  s.ios.resource_bundle = {'TCPickerView' => ['TCPickerView/Source/Resources/**/*.{xcassets}']}
end
