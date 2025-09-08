cask "goldendict-ng@alpha" do
  arch arm: "arm64", intel: "x86_64"

  version "25.07.0,ef1eaebe"
  qt_version="6.9.1"

  sha256 arm:   "7152256476eb2a0a507544fafdceccea5683d73f5c6612fa76000f871aa12fcd",
         intel: "93f7dcd44180dd205f6cf27ae2602f93ff7299410cca4ec19b891d2225885184"

  url "https://github.com/xiaoyifang/goldendict-ng/releases/download/v#{version.csv.first}-alpha.#{version.csv.second}/GoldenDict-ng-#{version.csv.first}-Qt#{qt_version}-macOS-#{arch}.dmg",
      verified: "github.com/xiaoyifang/goldendict-ng/"
  name "GoldenDict-ng"
  desc "Next Generation GoldenDict"
  homepage "https://xiaoyifang.github.io/goldendict-ng/"

  livecheck do
    url "https://api.github.com/repos/xiaoyifang/goldendict-ng/releases"
    regex(/v?(\d+(?:\.\d+)+)-alpha\.([a-zA-Z0-9]+)/i)
    strategy :json do |json_array|
      result = []
      json_array.each do |json|
        if (tag = json["tag_name"]) && (match = tag.match(/v?(\d+(?:\.\d+)+)-alpha\.([a-zA-Z0-9]+)/i))
          result << "#{match[1]},#{match[2]}"
        end
      end
      result
    end
  end

  conflicts_with cask: "goldendict-ng"
  depends_on macos: ">= :monterey"

  shimscript = "#{staged_path}/goldendict.wrapper.sh"
  app "GoldenDict-ng.app", target: "GoldenDict.app"
  binary shimscript, target: "goldendict"

  preflight do
    File.write shimscript, <<~EOS
      #!/bin/sh
      exec '#{appdir}/GoldenDict.app/Contents/MacOS/goldendict' "$@"
    EOS
  end

  postflight do
    system_command "xattr",
                   args: [
                     "-dr", "com.apple.quarantine", "#{appdir}/GoldenDict.app"
                   ]
  end

  zap trash: [
    "~/.goldendict",
    "~/Library/Caches/GoldenDict-ng",
    "~/Library/Preferences/org.xiaoyifang.plist",
    "~/Library/Saved Application State/org.xiaoyifang.savedState",
  ]

  caveats do
    <<~EOS
      [F] Forked application, modified from:
      https://github.com/Homebrew/homebrew-cask/blob/HEAD/Casks/g/goldendict.rb
    EOS
  end
end
