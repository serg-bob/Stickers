Pod::Spec.new do |s|
  s.name                = "Stickers"
  s.version             = "0.0.1"
  s.summary             = "Text and image stickers with resizing, rotation and scaling."
  s.description         = <<-DESC
                          This is library for manipulating a text and image stickers in iOS apps.
                          DESC

  s.homepage            = "https://github.com/serg-bob/Stickers.git"
  s.license             = 'MIT'
  s.authors             = { "Sergey Penziy" => "sergbob84@gmail.com" }
  s.source              = { :git => "https://github.com/serg-bob/Stickers.git", :tag => s.version.to_s }
  s.platform            = :ios, "11.0"

  s.source_files        = [ 'sources/**/*.{m,h}' ]

  s.frameworks          = [ 'Foundation', 'UIKit', 'CoreGraphics' ]
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
end
