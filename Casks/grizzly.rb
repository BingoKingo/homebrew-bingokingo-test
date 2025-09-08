cask "grizzly" do
  version "0.2.4"
  sha256 "0ab98dc8e471990b2b73bab6165bd4f092dcf744e1d6bef799f4958476baa9ea"

  url "https://github.com/harshal2030/Grizzly/releases/download/v#{version}/Grizzly-#{version}.dmg",
      verified: "github.com/"
  name "Grizzly"
  desc "Zip viewer"
  homepage "https://harshal2030.github.io/Grizzly/"

  depends_on macos: ">= :sonoma"

  app "Grizzly.app"

  postflight do
    system_command "xattr",
                   args: [
                     "-dr", "com.apple.quarantine", "#{appdir}/Grizzly.app"
                   ]
  end

  zap trash: "~/Library/Preferences/com.grizzly.Grizzly.plist"
end
