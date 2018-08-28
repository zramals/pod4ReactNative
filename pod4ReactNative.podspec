# coding: utf-8
require "json"

folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1'
folly_version = '2016.09.26.00'

Pod::Spec.new do |s|
  s.name         = "pod for ReactNative"
  s.version      = "0.55.4"
  s.summary      = "pod4ReactNative"
  s.description  = <<-DESC
                    pod for ReactNative with RN v0.55.4.
                   DESC

  s.homepage     = "https://github.com/zramals/pod4ReactNative"
  s.license      = "MIT"
  s.author             = { "zramals" => "525456448@qq.com" }
  s.source       = { :git => "http://gitlab.yixinonline.org/YRD_CreditPerson_ios/YRDReactNative.git", :tag => "rnsource#{s.version}" }

  s.default_subspec         = 'yoga', 'Core', 'CxxBridge', 'DevSupport', 'RCTWebSocket', 'RCTText', 'RCTAnimation', 'RCTImage'
  s.header_dir              = "React"
  s.requires_arc            = true
  s.platforms               = { :ios => "8.0"}
  s.pod_target_xcconfig     = { "CLANG_CXX_LANGUAGE_STANDARD" => "c++14",
                                'OTHER_LDFLAGS' => '-ObjC',
                                'HEADER_SEARCH_PATHS' => '\'$(PODS_TARGET_SRCROOT)/rn-source/ReactCommon\' \'$(PODS_ROOT)/Folly\' \'$(PODS_ROOT)/boost-for-react-native\' \'$(PODS_ROOT)/DoubleConversion\'' 
                              }
  s.cocoapods_version       = ">= 1.2.0"

  s.subspec "Core" do |ss|
    ss.dependency             "YRDReact/yoga"
    ss.source_files         = "rn-source/React/**/*.{c,h,m,mm,S,cpp}"
    ss.exclude_files        = "rn-source/**/__tests__/*",
                              "rn-source/IntegrationTests/*",
                              "rn-source/React/DevSupport/*",
                              "rn-source/React/Inspector/*",
                              "rn-source/ReactCommon/yoga/*",
                              "rn-source/React/Cxx*/*",
                              "rn-source/React/Fabric/*",
    ss.ios.exclude_files    = "rn-source/React/**/RCTTV*.*"
    # ss.tvos.exclude_files   = "rn-source/React/Modules/RCTClipboard*",
    #                           "rn-source/React/Views/RCTDatePicker*",
    #                           "rn-source/React/Views/RCTPicker*",
    #                           "rn-source/React/Views/RCTRefreshControl*",
    #                           "rn-source/React/Views/RCTSlider*",
    #                           "rn-source/React/Views/RCTSwitch*",
    #                           "rn-source/React/Views/RCTWebView*"
    ss.header_dir           = "React"
    ss.framework            = "JavaScriptCore"
    ss.libraries            = "stdc++"
  end

  s.subspec "CxxBridge" do |ss|
    ss.dependency             "Folly", "2016.09.26.00"
    ss.dependency             "YRDReact/Core"
    ss.dependency             "YRDReact/cxxreact"
    ss.compiler_flags       = folly_compiler_flags
    ss.private_header_files = "rn-source/React/Cxx*/*.h"
    ss.source_files         = "rn-source/React/Cxx*/*.{h,m,mm}"
  end

  s.subspec "DevSupport" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.dependency             "YRDReact/RCTWebSocket"
    ss.source_files         = "rn-source/React/DevSupport/*",
                              "rn-source/React/Inspector/*"
  end

  # s.subspec "tvOS" do |ss|
  #   ss.dependency             "YRDReact/Core"
  #   ss.source_files         = "rn-source/React/**/RCTTV*.{h, m}"
  # end

  s.subspec "jschelpers" do |ss|
    ss.dependency             "Folly", "2016.09.26.00"
    ss.dependency             "YRDReact/PrivateDatabase"
    ss.compiler_flags       = folly_compiler_flags
    ss.source_files         = "rn-source/ReactCommon/jschelpers/*.{cpp,h}"
    ss.private_header_files = "rn-source/ReactCommon/jschelpers/*.h"
    ss.framework            = "JavaScriptCore"
  end

  s.subspec "jsinspector" do |ss|
    ss.source_files         = "rn-source/ReactCommon/jsinspector/*.{cpp,h}"
    ss.private_header_files = "rn-source/ReactCommon/jsinspector/*.h"
  end

  s.subspec "PrivateDatabase" do |ss|
    ss.source_files         = "rn-source/ReactCommon/privatedata/*.{cpp,h}"
    ss.private_header_files = "rn-source/ReactCommon/privatedata/*.h"
  end

  s.subspec "cxxreact" do |ss|
    ss.dependency             "YRDReact/jschelpers"
    ss.dependency             "YRDReact/jsinspector"
    ss.dependency             "boost-for-react-native", "1.63.0"
    ss.dependency             "Folly", "2016.09.26.00"
    ss.compiler_flags       = folly_compiler_flags
    ss.source_files         = "rn-source/ReactCommon/cxxreact/*.{cpp,h}"
    ss.exclude_files        = "rn-source/ReactCommon/cxxreact/SampleCxxModule.*"
    ss.private_header_files = "rn-source/ReactCommon/cxxreact/*.h"
  end

  s.subspec "ART" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.source_files         = "rn-source/Libraries/ART/**/*.{h,m}"
  end

  s.subspec "RCTActionSheet" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.source_files         = "rn-source/Libraries/ActionSheetIOS/*.{h,m}"
  end

  s.subspec "RCTAnimation" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.source_files         = "rn-source/Libraries/NativeAnimation/{Drivers/*,Nodes/*,*}.{h,m}"
    ss.header_dir           = "RCTAnimation"
  end

  s.subspec "RCTBlob" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.source_files         = "rn-source/Libraries/Blob/*.{h,m,mm}"
    ss.preserve_paths       = "rn-source/Libraries/Blob/*.js"
  end

  s.subspec "RCTCameraRoll" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.dependency             'YRDReact/RCTImage'
    ss.source_files         = "rn-source/Libraries/CameraRoll/*.{h,m}"
  end

  s.subspec "RCTGeolocation" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.source_files         = "rn-source/Libraries/Geolocation/*.{h,m}"
  end

  s.subspec "RCTImage" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.dependency             "YRDReact/RCTNetwork"
    ss.source_files         = "rn-source/Libraries/Image/*.{h,m}"
  end

  s.subspec "RCTNetwork" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.source_files         = "rn-source/Libraries/Network/*.{h,m,mm}"
  end

  s.subspec "RCTPushNotification" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.source_files         = "rn-source/Libraries/PushNotificationIOS/*.{h,m}"
  end

  s.subspec "RCTSettings" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.source_files         = "rn-source/Libraries/Settings/*.{h,m}"
  end

  s.subspec "RCTText" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.source_files         = "rn-source/Libraries/Text/**/*.{h,m}"
  end

  s.subspec "RCTVibration" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.source_files         = "rn-source/Libraries/Vibration/*.{h,m}"
  end

  s.subspec "RCTWebSocket" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.dependency             "YRDReact/RCTBlob"
    ss.dependency             "YRDReact/fishhook"
    ss.source_files         = "rn-source/Libraries/WebSocket/*.{h,m}"
  end

  s.subspec "fishhook" do |ss|
    ss.header_dir           = "fishhook"
    ss.source_files         = "rn-source/Libraries/fishhook/*.{h,c}"
  end

  s.subspec "RCTLinkingIOS" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.source_files         = "rn-source/Libraries/LinkingIOS/*.{h,m}"
  end

  s.subspec "RCTTest" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.source_files         = "rn-source/Libraries/RCTTest/**/*.{h,m}"
    ss.frameworks           = "XCTest"
  end

  s.subspec "_ignore_me_subspec_for_linting_" do |ss|
    ss.dependency             "YRDReact/Core"
    ss.dependency             "YRDReact/CxxBridge"
  end
  
  s.subspec "yoga" do |spec|
    spec.header_dir           = "yoga"
    spec.requires_arc = false
    spec.compiler_flags = [
        '-fno-omit-frame-pointer',
        '-fexceptions',
        '-Wall',
        '-Werror',
        '-std=c++1y',
        '-fPIC'
    ]
    spec.source_files = 'rn-source/ReactCommon/yoga/yoga/**/*.{cpp,h}'
  end
end
