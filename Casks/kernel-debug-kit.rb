cask "kernel-debug-kit" do
  version "26.2,25C5031i"
  sha256 "6c4ae0a5a31d501042f66cbd8cb5737dd941a9e5a91b67c1930686695cb41bf7"

  url "https://download.developer.apple.com/macOS/Kernel_Debug_Kit_#{version.csv.first}_build_#{version.csv.second}/Kernel_Debug_Kit_#{version.csv.first}_build_#{version.csv.second}.dmg",
      referer:    "https://developer.apple.com/",
      user_agent: :browser,
      cookies:    {
        "ADCDownloadAuth" => ENV.fetch("ADC_DOWNLOAD_AUTH", nil).to_s,
      }
  name "Kernel Debug Kit"
  homepage "https://developer.apple.com/download/all/"

  pkg "KernelDebugKit.pkg"

  uninstall pkgutil: ["com.apple.pkg.KDK.#{version.csv.second}",
                      "com.apple.pkg.KDK_SDK.#{version.csv.second}"]

  caveats do
    <<~EOS
      [L] Log in to https://developer.apple.com/download/ in your browser,
      get the value of the cookie `ADCDownloadAuth` from F12 Developer Tools,
      and paste it in your terminal before installation
           export ADC_DOWNLOAD_AUTH="Value"
    EOS
  end
end
