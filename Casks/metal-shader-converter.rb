cask "metal-shader-converter" do
  version "3.0_beta_5"
  sha256 "ffe7f807f1399217767aa459df0bb144c52de6112f44c374699e99d6d93a5873"

  url "https://download.developer.apple.com/Developer_Tools/Metal_Shader_Converter_#{version}/Metal_Shader_Converter_#{version}.pkg",
      referer:    "https://developer.apple.com/",
      user_agent: :browser,
      cookies:    {
        "ADCDownloadAuth" => ENV.fetch("ADC_DOWNLOAD_AUTH", nil).to_s,
      }
  name "Metal Shader Converter"
  homepage "https://developer.apple.com/download/all/"

  pkg "Metal_Shader_Converter_#{version}.pkg"

  uninstall pkgutil: "com.apple.metal"

  caveats do
    <<~EOS
      [L] Log in to https://developer.apple.com/download/ in your browser,
      get the value of the cookie `ADCDownloadAuth` from F12 Developer Tools,
      and paste it in your terminal before installation
           export ADC_DOWNLOAD_AUTH="Value"
    EOS
  end
end
