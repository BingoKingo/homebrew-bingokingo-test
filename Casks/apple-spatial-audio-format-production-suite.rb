cask "apple-spatial-audio-format-production-suite" do
  version "2.1.9"
  sha256 "1010b251ed188619abe019f7d061aaccde1b60b3bd72098f0e68123b6d3c476a"

  url "https://download.developer.apple.com/Developer_Tools/Apple_Spatial_Audio_Format__Production_Suite_AAX/ASAF_AAX_v#{version}.dmg",
      referer:    "https://developer.apple.com/",
      user_agent: :browser,
      cookies:    {
        "ADCDownloadAuth" => ENV.fetch("ADC_DOWNLOAD_AUTH", nil).to_s,
      }
  name "Apple Spatial Audio Format - Production Suite"
  homepage "https://developer.apple.com/download/all/"

  pkg "ASAF AAX v#{version}.pkg"

  uninstall pkgutil: "com.Apple.pkg.ASAF.AAX"

  caveats do
    <<~EOS
      [L] Log in to https://developer.apple.com/download/ in your browser,
      get the value of the cookie `ADCDownloadAuth` from F12 Developer Tools,
      and paste it in your terminal before installation
           export ADC_DOWNLOAD_AUTH="Value"
    EOS
  end
end
