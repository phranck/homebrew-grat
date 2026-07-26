class Grat < Formula
  desc "Run approved local development tasks safely"
  homepage "https://github.com/phranck/grat"
  url "https://github.com/phranck/grat/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "19e76e9eb56024622e753da26e7f2dd8cbd46e6a6e963904e305733bd77e8769"
  license "MIT"

  bottle do
    root_url "https://github.com/phranck/grat/releases/download/v1.2.1"
    sha256 cellar:       :any_skip_relocation,
           arm64_tahoe:  "52c5c781ebf99310aab22234d34debf4d5f457c0d2c1b0bb52262efedf6b957a",
           arm64_linux:  "74e8cecce371fa241862e65f5435e1725fe8a941485e49e7f636b96804c0084c",
           tahoe:        "6411b846ae0f7d754a2bdb505be10576d36f7621d6c762892956ff068cb7f13a",
           x86_64_linux: "cf180eb305346b44c63d257562c7692735d821222ecb31b0a0b818ab8ae24500"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/phranck/grat/internal/version.buildVersion=v#{version}"), "./cmd/grat"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/grat version")
  end
end
