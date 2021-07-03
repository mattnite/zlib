const std = @import("std");
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;

const src_files = [_][]const u8{
    "inffast.c",
    "gzread.c",
    "crc32.c",
    "inftrees.c",
    "gzwrite.c",
    "gzclose.c",
    "gzlib.c",
    "inflate.c",
    "compress.c",
    "trees.c",
    "infback.c",
    "adler32.c",
    "zutil.c",
    "deflate.c",
    "uncompr.c",
};

fn root() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}

pub fn includeDir() []const u8 {
    return root();
}

pub fn link(step: *LibExeObjStep) void {
    step.addIncludeDir(root());
    step.linkLibC();

    inline for (src_files) |file|
        step.addCSourceFile(root() ++ std.fs.path.sep_str ++ file, &.{});
}
