const std = @import("std");
const core = @import("comptime/core.zig");

pub fn floor(v: f64) i32 {
    return @intFromFloat(@floor(v));
}

pub fn lfloor(v: f64) i64 {
    return @intFromFloat(@floor(v));
}

pub fn lerp(alpha1: f64, p0: f64, p1: f64) f64 {
    return p0 + alpha1 * (p1 - p0);
}

// for some reason these are NOT binary but are coordinate representations
pub fn lerp2(alpha1: f64, alpha2: f64, x00: f64, x10: f64, x01: f64, x11: f64) f64 {
    return lerp(alpha2, lerp(alpha1, x00, x10), lerp(alpha1, x01, x11));
}

pub fn lerp3(alpha1: f64, alpha2: f64, alpha3: f64, x000: f64, x100: f64, x010: f64, x110: f64, x001: f64, x101: f64, x011: f64, x111: f64) f64 {
    return lerp(alpha3, lerp2(alpha1, alpha2, x000, x100, x010, x110), lerp2(alpha1, alpha2, x001, x101, x011, x111));
}

pub fn smoothstepDerivative(x: f64) f64 {
    return 30.0 * x * x * (x - 1.0) * (x - 1.0);
}

pub fn rotateLeftI64(l: i64, b: i32) i64 {
    return @bitCast(std.math.rotl(u64, @bitCast(l), b));
}

pub fn getSeed(x: i32, y: i32, z: i32) i64 {
    var seed: i64 = @as(i64, x *% 3129871) ^ @as(i64, z) *% 11629781 ^ @as(i64, y);
    seed = seed *% seed *% 423167861 +% seed *% 11;
    return seed >> 16;
}
