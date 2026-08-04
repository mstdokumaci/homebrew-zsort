class Zsort < Formula
  desc "Opinionated import organizer for Zig"
  homepage "https://github.com/mstdokumaci/zsort"
  url "https://github.com/mstdokumaci/zsort/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "872a3cc101ceab67b93909251d9bb02d42ebf6ef1a23db03a113ff5f9556cc92"
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
