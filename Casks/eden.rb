cask "eden" do
  version "0.0.4"
  sha256 "fd094f0d50f3fd08c5a0709aba8a2aeab7309b11c052427a4823fd1ff4c00a5f"

  url "https://git.eden-emu.dev/eden-emu/eden/releases/download/v#{version}/Eden-macOS-v#{version}.tar.gz"
  name "eden"
  desc "Nintendo Switch 1 emulator in c++"
  homepage "https://eden-emu.dev/"

  livecheck do
    url "https://git.eden-emu.dev/eden-emu/eden/releases"
    regex(/Eden-macOS-v([0-9.]+(?:-rc\d+)?)\.tar\.gz/i)
  end

  depends_on macos: ">= :big_sur"
  depends_on arch: :arm64

  # conflict_with cask: "yuzu"

  app "eden.app"

  postflight do
    system_command "xattr",
                   args: [
                     "-dr", "com.apple.quarantine", "#{appdir}/eden.app"
                   ]
  end

  zap trash: [
    "~/.config/eden",
    "~/.local/share/eden",
    "~/Library/Preferences/com.yuzu-emu.yuzu.plist",
  ]
end
