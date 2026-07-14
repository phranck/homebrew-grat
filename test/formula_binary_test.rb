# typed: strict
# frozen_string_literal: true

class Formula
  class << self
    attr_reader :urls, :checksums, :dependencies, :heads, :bottle_root_url,
                :bottle_checksums

    def desc(*)
      nil
    end

    def homepage(*)
      nil
    end

    def license(*)
      nil
    end

    def version(*)
      nil
    end

    def head(value, **)
      (@heads ||= []) << value
    end

    def test(*)
      nil
    end

    def url(value)
      (@urls ||= []) << value
    end

    def sha256(value = nil, **keywords)
      if keywords.empty?
        (@checksums ||= []) << value
      else
        (@bottle_checksums ||= []) << keywords
      end
    end

    def depends_on(value)
      (@dependencies ||= []) << value
    end

    def bottle(&block)
      class_eval(&block)
    end

    def root_url(value)
      @bottle_root_url = value
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

  module BinaryTest
    module_function

    def assert_equal(expected, actual, message)
      return if expected == actual

      raise "#{message}: expected #{expected.inspect}, got #{actual.inspect}"
    end
  end
end

load File.expand_path("../Formula/grat.rb", __dir__)

expected_bottle_tags = [:arm64_tahoe, :arm64_linux, :tahoe, :x86_64_linux]
expected_source_url = "https://github.com/phranck/grat/archive/refs/tags/v1.1.4.tar.gz"
expected_source_checksum = "c3b32408b69743a906d506f6e4cb49fc2ad86d2e6618601a2abdfd77a5df8412"
expected_bottle_root = "https://github.com/phranck/grat/releases/download/v1.1.4"
expected_bottle_checksums = {
  arm64_tahoe:  "7a0c2d87fc86ae3def14126748e84aa7ddb64ed20d539269ceac707224a97998",
  arm64_linux:  "71fa1d580ad212d87dc197cf1ce45d81efa259050e56851586f6d0b16db9fb17",
  tahoe:        "3c5a25da52a28e9b600e491079a730348570acf91854fc99a0abb112b05f58e6",
  x86_64_linux: "98e78d81222892ca7be38ef91c268dc977fc7d8e50372ca68c71eadcbdd725d7",
}.freeze

Formula::BinaryTest.assert_equal [{ "go" => :build }], Grat.dependencies,
                                 "formula must declare Go only for source fallback builds"
Formula::BinaryTest.assert_equal [], Grat.heads || [], "formula must not advertise a source head"
Formula::BinaryTest.assert_equal [expected_source_url], Grat.urls,
                                 "formula must use the matching source archive"
Formula::BinaryTest.assert_equal [expected_source_checksum], Grat.checksums,
                                 "formula source checksum must match the published tag"
Formula::BinaryTest.assert_equal expected_bottle_root, Grat.bottle_root_url,
                                 "bottles must come from the matching grat release"

bottle_checksums = Grat.bottle_checksums || []
Formula::BinaryTest.assert_equal 1, bottle_checksums.length,
                                 "formula must declare one portable bottle set"
bottle = bottle_checksums.first || {}
Formula::BinaryTest.assert_equal :any_skip_relocation, bottle[:cellar],
                                 "bottles must be relocatable"
Formula::BinaryTest.assert_equal expected_bottle_tags.sort, (bottle.keys - [:cellar]).sort,
                                 "formula must provide every supported bottle"
bottle_checksums_without_cellar = bottle.each_with_object({}) do |(key, value), checksums|
  checksums[key] = value if key != :cellar
end
Formula::BinaryTest.assert_equal expected_bottle_checksums,
                                 bottle_checksums_without_cellar,
                                 "formula checksums must match the published bottle archives"

puts "formula bottle declaration: PASS"
