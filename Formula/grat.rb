class Grat < Formula
  desc "Run approved local development tasks safely"
  homepage "https://github.com/phranck/grat"
  url "https://github.com/phranck/grat/archive/refs/tags/v1.1.4.tar.gz"
  sha256 "c3b32408b69743a906d506f6e4cb49fc2ad86d2e6618601a2abdfd77a5df8412"
  license "MIT"

  bottle do
    root_url "https://github.com/phranck/grat/releases/download/v1.1.4"
    sha256 cellar:       :any_skip_relocation,
           arm64_tahoe:  "7a0c2d87fc86ae3def14126748e84aa7ddb64ed20d539269ceac707224a97998",
           arm64_linux:  "71fa1d580ad212d87dc197cf1ce45d81efa259050e56851586f6d0b16db9fb17",
           tahoe:        "3c5a25da52a28e9b600e491079a730348570acf91854fc99a0abb112b05f58e6",
           x86_64_linux: "98e78d81222892ca7be38ef91c268dc977fc7d8e50372ca68c71eadcbdd725d7"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/phranck/grat/internal/version.buildVersion=v#{version}"), "./cmd/grat"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/grat version")
  end
end
