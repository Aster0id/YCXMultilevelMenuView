Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name = "YCXMultilevelMenuView"
  s.version = "0.0.5"
  s.summary = "多级菜单控件."

  s.homepage = "https://github.com/Aster0id/YCXMultilevelMenuView"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.license = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.author = "Aster0id"
  s.social_media_url = "http://weibo.com/aster0id"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.platform = :ios, "7.0"
  s.ios.deployment_target = "7.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source = { :git => "https://github.com/Aster0id/YCXMultilevelMenuView.git", :tag => "0.0.5" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source_files  = "YCXMultilevelMenuView/YCXMultilevelMenuView/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "YCXMultilevelMenuView/YCXMultilevelMenuView/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # s.resource  = "icon.png"
  s.resources = "YCXMultilevelMenuView/YCXMultilevelMenuView/**/*.{xib,png}",

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # s.framework  = "SomeFramework"
  s.frameworks = "UIKit", "QuartzCore"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "SDWebImage"

end
