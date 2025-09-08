cask "reality-converter" do
  version "1.0,53"
  sha256 "33070c16adf85f2d1ebf0e9f85c32a814b7be4e3166c2cea8d417b5cfb3b5ca1"

  url "https://developer.apple.com/augmented-reality/tools/files/Reality_Converter_beta_6.dmg"
  name "Reality Converter"
  desc "Convert, view, and customize USDZ 3D objects"
  homepage "https://developer.apple.com/download/applications/"

  depends_on macos: ">= :monterey"
  container nested: "RealityConverter.pkg"

  pkg "RealityConverter.pkg"

  uninstall pkgutil: "com.apple.pkg.RealityConverter"

  zap trash: [
    "~/Library/Application Scripts/com.apple.RealityConverter",
    "~/Library/Caches/com.apple.helpd/Generated/com.apple.RealityConverter.help*1.0",
    "~/Library/Containers/com.apple.RealityConverter",
  ]
end
