class Zsort < Formula
  desc "Opinionated import organizer for Zig"
  homepage "https://github.com/mstdokumaci/zsort"
  url "https://github.com/mstdokumaci/zsort/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "38b2d6ec95788201428e75934f41120bc8731e3980498b933dd2b687b63e5821"
  license "MIT"

  head "https://github.com/mstdokumaci/zsort.git", branch: "main"

  livecheck do
    url "https://github.com/mstdokumaci/zsort/releases"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  # zsort supports Zig 0.15.2+. The versioned (keg-only) formula is used so
  # that building zsort never touches the user's own zig installation.
  depends_on "zig@0.15" => :build

  def install
    system "zig", "build", *std_zig_args
  end

  test do
    (testpath/"main.zig").write <<~EOS
      const b = @import("a.zig");
      const std = @import("std");
    EOS
    system bin/"zsort", "fix", testpath/"main.zig"
    assert_equal <<~EOS, (testpath/"main.zig").read
      const std = @import("std");

      const b = @import("a.zig");
    EOS
  end
end
