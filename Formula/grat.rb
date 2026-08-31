class Grat < Formula
  desc "Run approved local development tasks safely"
  homepage "https://github.com/phranck/grat"
  url "https://github.com/phranck/grat/archive/refs/tags/v1.3.2.tar.gz"
  sha256 "ccaa040e91d90d879f357ebe6c3e9ebd52009d14f5f1ee8102f3de5e0d2844b2"
  license "MIT"

  bottle do
    root_url "https://github.com/phranck/grat/releases/download/v1.3.2"
    sha256 cellar:       :any_skip_relocation,
           arm64_tahoe:  "13eea60513bf77006e3e2d6717e90b801bc7b48eea11f5675f0b0c5fbd7e5085",
           arm64_linux:  "b0937b518f2d285028f47b9acd4b53b20294033bf0f86bb8ec396055e59e6c7a",
           tahoe:        "00fbee688f618e55c1acff7510f773ac39e6a365196262002b27fd1ae51f59c9",
           x86_64_linux: "d8302348ebb625eeaf1b29e9c9f378a869f5a35e935996e6cbe44f53d518bd06"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/phranck/grat/internal/version.buildVersion=v#{version}"), "./cmd/grat"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/grat version")
  end
end
