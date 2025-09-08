cask "deskflow@continuous" do
  arch arm: "arm64", intel: "x86_64"

  version "1.25.0.161"
  sha256 arm:   "dab5cc3f960f27dabf1fc021746255459a85d815b11462bf9ed0b3f018b4bc9a",
         intel: "1751b040327135f843b88151fbe646b7b17325517b90e8d0f08a4943837cdfce"

  url "https://github.com/deskflow/deskflow/releases/download/continuous/deskflow-continuous-macos-#{arch}.dmg"
  name "Deskflow"
  desc "Mouse and keyboard sharing utility"
  homepage "https://github.com/deskflow/deskflow/"

  livecheck do
    url "https://api.github.com/repos/deskflow/deskflow/releases"
    regex(/Continuous v?(\d+(?:\.\d+)+)/i)
    strategy :json do |json_array|
      result = []
      json_array.each do |json|
        if (name = json["name"]) && (match = name.match(/Continuous v?(\d+(?:\.\d+)+)/i))
          result << match[1]
        end
      end
      result
    end
  end

  conflicts_with cask: "deskflow"
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
