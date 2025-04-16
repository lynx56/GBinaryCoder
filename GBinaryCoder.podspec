Pod::Spec.new do |s|
  s.name             = 'GBinaryCoder'
  s.version          = '1.0.1'
  s.summary          = 'A library for binary encoding and decoding with extensions for common data types.'
  s.description      = <<-DESC
                         GBinaryCoder provides a set of tools for binary encoding and decoding. 
                         It includes extensions for encoding and decoding custom types, 
                         reading/writing bits, and manipulating binary data in Swift.
                       DESC
  s.homepage         = 'https://github.com/lynx56/GBinaryCoder'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Gulnaz Almukhametova' => 'lynx56reg@gmail.com' }
  s.source           = { :git => 'https://github.com/lynx56/GBinaryCoder.git', :tag => '1.0.1' }
  s.platform         = :ios, '13.0'
  s.source_files     = 'Sources/GBinaryCoder/**/*.{swift}'
  s.requires_arc     = true
  
  # Specify the Swift version (optional)
  s.swift_versions   = ['5.0']
end
