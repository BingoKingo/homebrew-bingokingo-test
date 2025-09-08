class Adflib < Formula
  desc "Free, portable and open implementation of the Amiga filesystem"
  homepage "https://github.com/adflib/ADFlib/"
  url "https://github.com/adflib/ADFlib/archive/refs/tags/v0.10.2.tar.gz"
  sha256 "1181cda574fcc87ba6564d519ecf58f63fbc468e0bd408485471ffa2e9745c5c"
  license any_of: ["LGPL-2.1-or-later", "GPL-2.0-or-later"]
  head "https://github.com/adflib/ADFlib.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/bingokingo/homebrew"
    sha256 cellar: :any,                 arm64_tahoe:   "adde046565a7a606468ab9a9117c12b3137e0f39cf9b99136fd97ba4c418b9a6"
    sha256 cellar: :any,                 arm64_sequoia: "3578c12b0b2ee672deae804403476d9aeba1ff4436c8abf196d0134e39a88ed2"
    sha256 cellar: :any,                 arm64_sonoma:  "0f874ec801fc79cb5c16820036dde6af542954f83d3d223795a6adc59539df50"
    sha256 cellar: :any,                 ventura:       "de248911fe1a28120e306046b772c7675e6ccd3bd754222e46a0e701e850ec38"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ffeafa699014855d4a3d5d032315861f54aab085855ea0f0838e5e09f80fb51d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "012c09c067a718f00380132b803e63278acd805c4fd74e79f4b5b34ed2cc1deb"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build

  def install
    # Remove unrecognized options if they cause configure to fail
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    args = []
    args += std_configure_args.reject { |s| s["--disable-debug"] || s["--disable-dependency-tracking"] }

    system "./autogen.sh"
    system "./configure", "--disable-silent-rules", *args
    system "make", "install"
  end

  def caveats
    <<~EOS
      [M] Modified from
      https://github.com/barn/homebrew-misc/blob/main/adflib.rb
    EOS
  end

  test do
    assert_match "Usage", shell_output("#{bin}/unadf -h")
    assert_match version.to_s, shell_output("#{bin}/unadf -V")
  end
end
