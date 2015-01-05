Pod::Spec.new do |s|

  s.name         = "VVBlurPresentation"
  s.version      = "0.1.1"
  s.summary      = "A simple way to present a view controller with keeping the blurred previous one."

  s.description  = <<-DESC
                   Sometimes you may want to present a new view controller and keep the old one visible, but blurred.
                   This repo will do the exactly thing for you. Just subclass the `VVBlurViewController` and present it as usual, 
                   `VVBlurPresentation` will handle other things for you.
                   DESC

  s.homepage     = "https://github.com/onevcat/VVBlurPresentation"
  s.screenshots  = "https://raw.github.com/onevcat/VVBlurPresentation/master/Gif/screenshot.gif"

  s.license      = "MIT"

  s.author             = { "onevcat" => "onev@onevcat.com" }
  s.social_media_url   = "http://twitter.com/onevcat"

  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/onevcat/VVBlurPresentation.git", :tag => "0.1.1" }
  s.source_files  = "Source"
  s.requires_arc = true
end
