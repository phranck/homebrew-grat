class Grat < Formula
  desc "Run approved local development tasks safely"
  homepage "https://github.com/phranck/grat"
  version "1.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/phranck/grat/releases/download/v1.1.1/grat_v1.1.1_darwin_arm64"
      sha256 "73002b5faa75104cd675d8684c280668ffa7cddf1cbb7e67cb97f72fb58e70b6"
    end

    on_intel do
      url "https://github.com/phranck/grat/releases/download/v1.1.1/grat_v1.1.1_darwin_amd64"
      sha256 "1d862a40869b3e7b2966954614e5b58857666dcdd9351a0bce7335ea654128a5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/phranck/grat/releases/download/v1.1.1/grat_v1.1.1_linux_arm64"
      sha256 "ed6e3546b11e53c78933b4b2f45f99c12bde5780bf1cded682bab03132506623"
    end

    on_intel do
      url "https://github.com/phranck/grat/releases/download/v1.1.1/grat_v1.1.1_linux_amd64"
      sha256 "c35df18e1435e810873408d03ae6858b0dcd2b1485dc462f97c419a209e50917"
    end
  end

  def install
    target = if OS.mac?
      Hardware::CPU.arm? ? "darwin_arm64" : "darwin_amd64"
    else
      Hardware::CPU.arm? ? "linux_arm64" : "linux_amd64"
    end
    bin.install "grat_v#{version}_#{target}" => "grat"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/grat version")
  end
end
