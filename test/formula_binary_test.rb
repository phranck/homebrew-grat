class Formula
  class << self
    attr_reader :urls, :checksums, :dependencies, :heads

    def desc(*)
    end

    def homepage(*)
    end

    def license(*)
    end

    def version(*)
    end

    def head(value, **)
      (@heads ||= []) << value
    end

    def test(*)
    end

    def url(value)
      (@urls ||= []) << value
    end

    def sha256(value)
      (@checksums ||= []) << value
    end

    def depends_on(value)
      (@dependencies ||= []) << value
    end

    def on_macos(&block)
      class_eval(&block)
    end

    def on_linux(&block)
      class_eval(&block)
    end

    def on_arm(&block)
      class_eval(&block)
    end

    def on_intel(&block)
      class_eval(&block)
    end
  end
end

load File.expand_path("../Formula/grat.rb", __dir__)

def assert_equal(expected, actual, message)
  return if expected == actual

  raise "#{message}: expected #{expected.inspect}, got #{actual.inspect}"
end

expected_assets = %w[
  grat_v1.1.1_darwin_amd64
  grat_v1.1.1_darwin_arm64
  grat_v1.1.1_linux_amd64
  grat_v1.1.1_linux_arm64
]
expected_checksums = %w[
  1d862a40869b3e7b2966954614e5b58857666dcdd9351a0bce7335ea654128a5
  73002b5faa75104cd675d8684c280668ffa7cddf1cbb7e67cb97f72fb58e70b6
  c35df18e1435e810873408d03ae6858b0dcd2b1485dc462f97c419a209e50917
  ed6e3546b11e53c78933b4b2f45f99c12bde5780bf1cded682bab03132506623
]

assert_equal [], Grat.dependencies || [], "formula must not require Go"
assert_equal [], Grat.heads || [], "binary-only formula must not advertise a source head"
assert_equal expected_assets.sort, Grat.urls.map { |url| File.basename(url) }.sort,
             "formula must declare every release binary"
assert_equal expected_checksums.sort, Grat.checksums.sort,
             "formula checksums must match the published release assets"

puts "formula binary declaration: PASS"
