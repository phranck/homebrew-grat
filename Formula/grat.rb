class Grat < Formula
  desc "Run approved local development tasks safely"
  homepage "https://github.com/phranck/grat"
  url "https://github.com/phranck/grat/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "c705d1c37a8327b7d4a13f5509517e085d79c0dc92e0b52276243d6b8add568b"
  license "MIT"

  bottle do
    root_url "https://github.com/phranck/grat/releases/download/v1.3.0"
    sha256 cellar:       :any_skip_relocation,
           arm64_tahoe:  "3dd1cef06b1011ef6e7c2e3b24bbf0766c8823039edbf266068447b1aee9deba",
           arm64_linux:  "55cfeff86ef75f45bf10bb831480844271e6110944d17ae0ae2e7c2c056fb5ca",
           tahoe:        "9dec9004811976325b4a0fb503fd7a16508e3beb51bb758a0969ecdf4e9e8530",
           x86_64_linux: "a67a6cdd57090e45c9a65350cecc9453a1aa6e64dce1f12caf0da829b8f082e5"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/phranck/grat/internal/version.buildVersion=v#{version}"), "./cmd/grat"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/grat version")
  end
end
