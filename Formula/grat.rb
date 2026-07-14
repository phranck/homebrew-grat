class Grat < Formula
  desc "Run approved local development tasks safely"
  homepage "https://github.com/phranck/grat"
  url "https://github.com/phranck/grat/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "60e46249e57cc7ce682643dc6eb47823217e7b9c31b12c473584ff0dec62f664"
  license "MIT"
  head "https://github.com/phranck/grat.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/phranck/grat/internal/version.buildVersion=v#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/grat"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/grat version")
  end
end
