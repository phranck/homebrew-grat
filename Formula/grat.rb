class Grat < Formula
  desc "Run approved local development tasks safely"
  homepage "https://github.com/phranck/grat"
  url "https://github.com/phranck/grat/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "0820cf8a7288a630afc948d86619eb5cf592605c831ca2b5ad1fb12972dcabe9"
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
