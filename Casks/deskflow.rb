cask "deskflow" do
  arch arm: "arm64", intel: "x86_64"

  version "1.25.0"
  sha256 arm:   "1ecd0b043049b89717b8650f1ac6cecd56b795df82a45efdfa617c565cfda2d8",
         intel: "5396dfea389494089417003a0c6c237147a85107eb1db8faa18c849ec0e67fb6"

  url "https://github.com/deskflow/deskflow/releases/download/v#{version}/deskflow-#{version}-macos-#{arch}.dmg"
  name "Deskflow"
  desc "Mouse and keyboard sharing utility"
  homepage "https://github.com/deskflow/deskflow/"

  conflicts_with cask: "deskflow@continuous"
  depends_on macos: ">= :sonoma"

  app "Deskflow.app"
  binary "#{appdir}/Deskflow.app/Contents/MacOS/deskflow-core"
  binary "#{staged_path}/deskflow-client"
  binary "#{staged_path}/deskflow-server"

  preflight do
    File.write "#{staged_path}/deskflow-client", <<~EOS
      #!/bin/bash
      exec '#{appdir}/Deskflow.app/Contents/MacOS/deskflow-core' "client" "$@"
    EOS
    File.write "#{staged_path}/deskflow-server", <<~EOS
      #!/bin/bash
      exec '#{appdir}/Deskflow.app/Contents/MacOS/deskflow-core' "server" "$@"
    EOS
  end

  postflight do
    system_command "xattr",
                   args: [
                     "-dr", "com.apple.quarantine", "#{appdir}/Deskflow.app"
                   ]
  end

  zap trash: [
    "~/Library/Application Support/Deskflow",
    "~/Library/Deskflow",
    "~/Library/Preferences/Deskflow",
    "~/Library/Preferences/org.deskflow.Deskflow.plist",
    "~/Library/Saved Application State/Deskflow.savedState",
  ]
end
