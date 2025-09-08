cask "qlstephenswift" do
  version "20251108"
  sha256 "b573860ea8a11246230d6d5b24a0591e6a1702223f92380697ee140f71e3dfa6"

  url "https://github.com/MyCometG3/QLStephenSwift/releases/download/#{version}/QLStephenSwift.#{version}.dmg"
  name "QLStephenSwift"
  desc "QuickLook extension for text files without extensions"
  homepage "https://github.com/MyCometG3/QLStephenSwift/"

  depends_on macos: ">=:sequoia"

  app "QLStephenSwift.app"

  zap trash: [
    "~/Library/Application Scripts/com.mycometg3.qlstephenswift",
    "~/Library/Application Scripts/com.mycometg3.qlstephenswift.qlstephenswiftpreview",
    "~/Library/Application Scripts/group.com.mycometg3.qlstephenswift",
    "~/Library/Containers/com.mycometg3.qlstephenswift",
    "~/Library/Containers/com.mycometg3.qlstephenswift.qlstephenswiftpreview",
    "~/Library/Group Containers/group.com.mycometg3.qlstephenswift",
  ]
end
