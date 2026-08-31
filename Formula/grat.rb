class Grat < Formula
  desc "Run approved local development tasks safely"
  homepage "https://github.com/phranck/grat"
  url "https://github.com/phranck/grat/archive/refs/tags/v1.3.1.tar.gz"
  sha256 "7c1d415cda93c8de4ae67b3145a2870525dc0b9dfd1600d01f0c1f67e987c066"
  license "MIT"

  bottle do
    root_url "https://github.com/phranck/grat/releases/download/v1.3.1"
    sha256 cellar:       :any_skip_relocation,
           arm64_tahoe:  "ec289c1ce28e0f79575d253423d3db134748408e16e7c3a9803ddfadf7289b23",
           arm64_linux:  "c48a0072cb1d82e18c79d814fce8e45182556a7962d4dbb5bb18b1a40022ddf4",
           tahoe:        "ce218e73a709734dc8f821b6d40694fbd092b1b6f02d7d35f950b334c0d8bae8",
           x86_64_linux: "5725914aa2bd0a462aee4a275c152021b0b2fd3eb03495d4fe8e681dfaacea7f"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/phranck/grat/internal/version.buildVersion=v#{version}"), "./cmd/grat"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/grat version")
  end
end
