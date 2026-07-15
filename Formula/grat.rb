class Grat < Formula
  desc "Run approved local development tasks safely"
  homepage "https://github.com/phranck/grat"
  url "https://github.com/phranck/grat/archive/refs/tags/v1.1.5.tar.gz"
  sha256 "7c6cc8cda0687a8b73fb114ba75cb1896370a5f8ce5bfaf5eabe9c4fa960c92e"
  license "MIT"

  bottle do
    root_url "https://github.com/phranck/grat/releases/download/v1.1.5"
    sha256 cellar:       :any_skip_relocation,
           arm64_tahoe:  "981aed5c174231b77edcd08784facc1ffa606a5ddc1cf886c9b0e527eecb999d",
           arm64_linux:  "5db5c761df6a814461418a68e2407a914ce7fe3ed4c7cbbc652de25e991b5c7f",
           tahoe:        "23093d74233f25b011645de4d9256d4385aa14bbdc4fbffcd61abe6137f702e7",
           x86_64_linux: "3dba03caf505bd88b60fc014e4fb6590140f25695f66967c1a9ecdf6c3d6902c"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/phranck/grat/internal/version.buildVersion=v#{version}"), "./cmd/grat"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/grat version")
  end
end
