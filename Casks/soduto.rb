cask "soduto" do
  version "3.0.0"
  sha256 "c05a022864138e88ca812b4be575aa70f65f92a595eb589a4606755d9e572f56"

  url "https://github.com/sannidhyaroy/Soduto/releases/download/v#{version}-nightly/Soduto.Nightly.dmg",
      verified: "github.com/sannidhyaroy/Soduto/"
  name "Soduto"
  desc "Communicate and share information between devices"
  homepage "https://soduto.thenoton.com/"

  livecheck do
    url :url
    regex(/v?(\d+(?:\.\d+)+)-nightly/i)
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :big_sur"

  app "Soduto.app"

  postflight do
    system_command "xattr",
                   args: [
                     "-dr", "com.apple.quarantine", "#{appdir}/Soduto.app"
                   ]
  end

  zap trash: [
    "~/Library/Containers/com.soduto.Soduto",
    "~/Library/Containers/com.soduto.SodutoBrowser",
    "~/Library/Containers/com.soduto.SodutoLauncher",
    "~/Library/Saved Application State/com.soduto.SodutoBrowser.savedState",
  ]

  caveats do
    <<~EOS
      [F] Forked version, modified from
      https://github.com/Homebrew/homebrew-cask/blob/HEAD/Casks/s/soduto.rb
    EOS
  end
end
