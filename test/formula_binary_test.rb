# typed: strict
# frozen_string_literal: true

# The class below stubs the parts of the Formula DSL that Formula/grat.rb calls, so
# the formula can be loaded and asserted without Homebrew. RuboCop reads those stubs
# as redefinitions of the real Formula methods, which is exactly what they are meant
# to be here.
# rubocop:disable Lint/DuplicateMethods
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

  # Assertions used by the checks below this class.
  module BinaryTest
    module_function

    def assert_equal(expected, actual, message)
      return if expected == actual

      raise "#{message}: expected #{expected.inspect}, got #{actual.inspect}"
    end
  end
end
# rubocop:enable Lint/DuplicateMethods

load File.expand_path("../Formula/grat.rb", __dir__)

expected_bottle_tags = [:arm64_tahoe, :arm64_linux, :tahoe, :x86_64_linux]
checksum_shape = /\A[0-9a-f]{64}\z/

# The version comes from the formula rather than from a copy kept here. A copy
# would have to be raised for every release, which makes the test fire on a
# decision instead of on a defect, and it would say only that somebody changed
# both places. What can genuinely be wrong is the source archive and the bottles
# naming different tags, which is what is checked below.
source_url = (Grat.urls || []).first.to_s
release_tag = source_url[%r{/tags/(v[^/]+)\.tar\.gz\z}, 1]

Formula::BinaryTest.assert_equal [{ "go" => :build }], Grat.dependencies,
                                 "formula must declare Go only for source fallback builds"
Formula::BinaryTest.assert_equal [], Grat.heads || [], "formula must not advertise a source head"
Formula::BinaryTest.assert_equal false, release_tag.nil?,
                                 "formula must take its source from a tagged archive"
Formula::BinaryTest.assert_equal true, checksum_shape.match?((Grat.checksums || []).first.to_s),
                                 "formula source checksum must be a sha256 digest"
Formula::BinaryTest.assert_equal "https://github.com/phranck/grat/releases/download/#{release_tag}",
                                 Grat.bottle_root_url,
                                 "bottles must come from the release of the tag the source names"

# The formula generates the manual page from the binary it just built, so a
# source build without these two lines installs a binary with no manual and
# nothing else says so. The stub cannot run the install block, so the source is
# read instead.
formula_source = File.read(File.expand_path("../Formula/grat.rb", __dir__))
[
  ['Utils.safe_popen_read(bin/"grat", "manual")', "formula must generate the command page"],
  ['Utils.safe_popen_read(bin/"grat", "manual", "grat.config")', "formula must generate the config page"],
  ['man1.install "grat.1"', "formula must install the command page"],
  ['man7.install "grat.config.7"', "formula must install the config page"],
].each do |needle, message|
  Formula::BinaryTest.assert_equal true, formula_source.include?(needle), message
end

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
bottle_checksums_without_cellar.each do |tag, checksum|
  Formula::BinaryTest.assert_equal true, checksum_shape.match?(checksum.to_s),
                                   "the #{tag} bottle checksum must be a sha256 digest"
end

puts "formula bottle declaration: PASS"
