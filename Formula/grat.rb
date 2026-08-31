class Grat < Formula
  desc "Run approved local development tasks safely"
  homepage "https://github.com/phranck/grat"
  url "https://github.com/phranck/grat/archive/refs/tags/v1.2.3.tar.gz"
  sha256 "2f24e945ea2ede1eea20d7080e7ed3efad3bd69bfd7e843f758294cab1acfe07"
  license "MIT"

  bottle do
    root_url "https://github.com/phranck/grat/releases/download/v1.2.3"
    sha256 cellar:       :any_skip_relocation,
           arm64_tahoe:  "891bd10ed4199ab5cd265f9a326bc1333f197a8047007b6dde251ee66ce0d820",
           arm64_linux:  "22bab50eac939850f9c9dce4b3c9834b2f0bbb3fd9498a1f65f83dd9869739a5",
           tahoe:        "5de2e6dd3a54fc7dd7c08acaec0f78ffb2c89e14f110aa7416a839d54c09e50a",
           x86_64_linux: "5745389dffc77380634d475a80b14fd7e6d629eb0c4db9317e06f08c34a8d548"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/phranck/grat/internal/version.buildVersion=v#{version}"), "./cmd/grat"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/grat version")
  end
end
