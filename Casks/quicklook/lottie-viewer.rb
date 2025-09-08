cask "lottie-viewer" do
  version "1.6.0"
  sha256 "70fe5eff95e3d32a12342188ae7cc9ccd12404571b0a79f0d824b3ced8e86b27"

  url "https://github.com/mkj-is/LottieViewerMac/releases/download/#{version}/Lottie.Preview.app.zip"
  name "LottieViewer"
  desc "Lottie animations Viewer"
  homepage "https://github.com/mkj-is/LottieViewerMac/"

  depends_on macos: ">=:sonoma"

  app "Lottie Preview.app"

  zap trash: [
    "~/Library/Application Scripts/dev.mkj.LottieViewer",
    "~/Library/Application Scripts/dev.mkj.LottieViewer.Preview",
    "~/Library/Containers/dev.mkj.LottieViewer",
    "~/Library/Containers/dev.mkj.LottieViewer.Preview",
  ]
end
