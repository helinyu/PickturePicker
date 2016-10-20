Pod::Spec.new do |s|
s.name        = "ipaynowplugin"
s.version      = "1.0.0"
s.summary      = "ipaynowplugin SDK"
s.description  = <<-DESC
   Help developer to quickly intergrate variety of payment methods
DESC
s.homepage    = "https://github.com/helinyu/PickturePicker"
s.license      = "MIT"
s.author      = { "Hstripe" => "felix" }
s.platform    = :ios, '8.0'
s.source      = { :git => "https://github.com/helinyu/PickturePic", :tag => s.version }
s.default_subspec = 'Core'
s.requires_arc = true
s.subspec 'Core' do |core|
core.source_files = "lib/*.h"
core.public_header_files = "lib/*.h"
core.ios.library = 'z', 'sqlite3.0','c++', 'stdc++'
core.xcconfig = { 'OTHER_LDFLAGS' => '-ObjC' }
end

end
