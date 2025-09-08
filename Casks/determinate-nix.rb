cask "determinate-nix" do
  version "3.15.1"
  sha256 "ed0ed0c88df41a36ded9c60f1384e3d911042b46ed245200ca6a674c2d16d9f1"

  url "https://determinate-pkg20240826203520431200000001.s3.dualstack.us-east-2.amazonaws.com/v#{version}/Determinate.pkg-Universal",
      verified: "determinate-pkg20240826203520431200000001.s3.dualstack.us-east-2.amazonaws.com/"
  name "Determinate Nix Installer"
  homepage "https://determinate.systems/"

  livecheck do
    url "https://github.com/DeterminateSystems/nix-installer"
    strategy :github_latest
  end

  pkg "Determinate.pkg"

  uninstall script:  {
              executable: "/nix/nix-installer",
              args:       ["uninstall"],
              input:      ["Y"],
              sudo:       true,
            },
            pkgutil: "systems.determinate.Determinate"
end
