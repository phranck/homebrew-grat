class Grat < Formula
  desc "Run approved local development tasks safely"
  homepage "https://github.com/phranck/grat"
  url "https://github.com/phranck/grat/archive/refs/tags/v1.1.6.tar.gz"
  sha256 "4a49bc6cec63420e61c25f7b9cc3307e6c4f2b5f9e52bb62f1677b2ffe61d931"
  license "MIT"

  bottle do
    root_url "https://github.com/phranck/grat/releases/download/v1.1.6"
    sha256 cellar:       :any_skip_relocation,
           arm64_tahoe:  "e4ceb0f0a79f37a665d996fa606b8cc2fd3893bab757b1e658f130407fe95aa7",
           arm64_linux:  "fa9c5f321eb649b642688eb0c7a6e7e89f136b7b87bbc6e5074187a7096ab9e9",
           tahoe:        "62d500b02cdc7e3c5eb040019b43f2696a4b2b91dc8a99346e396a547a5e759a",
           x86_64_linux: "e52f2ee291e3dfcaf353676c119da438dc2c578b8d3b80fc0cb36827ed923a61"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/phranck/grat/internal/version.buildVersion=v#{version}"), "./cmd/grat"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/grat version")
  end
end
