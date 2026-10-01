const std = @import("std");
const mth = @import("mth_fn.zig");
const core = @import("comptime/core.zig");
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;

// needs init due to rare edge case
/// this serves as RandomSource and Xoroshiro
pub const Xoroshiro = struct {
    seed_lo: i64,
    seed_hi: i64,

    const Self = @This();

    pub fn init(seed_lo: i64, seed_hi: i64) Self {
        if ((seed_lo | seed_hi) == 0) {
            return Self{ .seed_lo = -7046029254386353131, .seed_hi = 7640891576956012809 };
        }
        return Self{ .seed_lo = seed_lo, .seed_hi = seed_hi };
    }

    pub fn initFromSeed128Bit(seed: Seed128Bit) Self {
        if ((seed.seed_lo | seed.seed_hi) == 0) {
            return Self{ .seed_lo = -7046029254386353131, .seed_hi = 7640891576956012809 };
        }

        return Self{ .seed_lo = seed.seed_lo, .seed_hi = seed.seed_hi };
    }

    pub fn nextI64(self: *Self) i64 {
        const s0: i64 = self.seed_lo;
        var s1: i64 = self.seed_hi;
        const result: i64 = mth.rotateLeftI64(s0 +% s1, 17) +% s0;
        s1 ^= s0;
        var lo: u64 = @bitCast(mth.rotateLeftI64(s0, 49));
        const u_s1: u64 = @bitCast(s1);
        lo = lo ^ u_s1 ^ u_s1 << 21;
        self.seed_lo = @bitCast(lo);
        self.seed_hi = mth.rotateLeftI64(s1, 28);
        return result;
    }

    pub fn nextI32(self: *Self, bound: ?i32) i32 {
        if (bound) |b| {
            var random_bits: i64 = @intCast(@as(u32, @bitCast(self.nextI32(null))));
            var mul_random_bits: i64 = random_bits * @as(i64, b);
            var fractional_part: i64 = mul_random_bits & 4294967295;
            if (fractional_part < @as(i64, b)) {
                const unbiased_buckets_start_index: i64 = @as(i64, @as(u32, @rem(@as(u32, @as(u32, @bitCast(~b)) +% 1), @as(u32, @bitCast(b)))));

                while (fractional_part < unbiased_buckets_start_index) : (fractional_part = mul_random_bits & 4294967295) {
                    random_bits = @intCast(@as(u32, @bitCast(self.nextI32(null))));
                    mul_random_bits = random_bits *% @as(i64, @intCast(b));
                }
            }
            return @as(i32, @intCast(mul_random_bits >> 32));
        } else {
            return @truncate(self.nextI64());
        }
        unreachable;
    }

    pub fn nextBool(self: *Self) bool {
        return self.nextI64() & 1 != 0;
    }

    pub fn nextBits(self: *Self, bits: i32) i64 {
        return @bitCast(@as(u64, @bitCast(self.nextI64())) >> @intCast(64 - bits));
    }

    pub fn nextF32(self: *Self) f32 {
        return @as(f32, @floatFromInt(self.nextBits(24))) * 5.9604645E-8;
    }

    pub fn nextF64(self: *Self) f64 {
        return @as(f64, @floatFromInt(self.nextBits(53))) * 1.110223E-16;
    }

    pub fn fork(self: *Self) Self {
        return self.init(self.nextI64(), self.nextI64());
    }

    pub fn forkPositional(self: *Self) XoroshiroFactory {
        return XoroshiroFactory.init(self.nextI64(), self.nextI64());
    }
};

pub const XoroshiroFactory = struct {
    seed_lo: i64,
    seed_hi: i64,

    const Self = @This();

    pub fn init(seed_lo: i64, seed_hi: i64) Self {
        if ((seed_lo | seed_hi) == 0) {
            return Self{ .seed_lo = -7046029254386353131, .seed_hi = 7640891576956012809 };
        }
        return Self{ .seed_lo = seed_lo, .seed_hi = seed_hi };
    }

    // pub fn
};

pub const RandomType = enum {
    xoroshiro,
};

const RandomThing = union {
    xoroshiro: *Xoroshiro,
};

pub const ImprovedNoise = struct {
    p: [256]u8,
    xo: f64,
    yo: f64,
    zo: f64,

    const Self = @This();

    pub fn initXoroshiro(random: *Xoroshiro) Self {
        var po: [256]u8 = undefined;
        for (0..256) |i| {
            po[i] = @intCast(i);
        }
        var s: Self = .{
            .xo = random.nextF64() * 256.0,
            .yo = random.nextF64() * 256.0,
            .zo = random.nextF64() * 256.0,
            .p = po,
        };
        for (0..256) |i| {
            const offset = random.nextI32(@intCast(256 - i));
            std.mem.swap(u8, &s.p[i], &s.p[i + @as(usize, @intCast(offset))]);
        }
        return s;
    }
};

pub fn mixStafford13(z: i64) i64 {
    var bit_mod: u64 = @bitCast(z);
    bit_mod = bit_mod ^ bit_mod >> 30;
    var multiply: i64 = @bitCast(bit_mod);
    multiply = multiply *% -4_658_895_280_553_007_687;
    bit_mod = @bitCast(multiply);
    bit_mod = bit_mod ^ bit_mod >> 27;
    multiply = @bitCast(bit_mod);
    multiply = multiply *% -7_723_592_293_110_705_685;
    bit_mod = @bitCast(multiply);
    return @bitCast(bit_mod ^ bit_mod >> 31);
}

pub const Seed128Bit = struct {
    seed_lo: i64,
    seed_hi: i64,

    const Self = @This();

    pub fn initFromHashOf(str: []const u8) Self {
        var hash: [std.crypto.hash.Md5.digest_length]u8 = undefined;
        std.crypto.hash.Md5.hash(str, &hash, .{});

        return .{ .seed_lo = @bitCast(std.mem.readInt(u64, hash[0..8], .big)), .seed_hi = @bitCast(std.mem.readInt(u64, hash[8..16], .big)) };
    }

    pub fn initUpgradeSeedTo128Bit(seed: i64, mixed: bool) Self {
        var seed_lo: i64 = seed ^ 7640891576956012809;
        var seed_hi: i64 = seed_lo +% -7046029254386353131;
        if (mixed) {
            seed_lo = mixStafford13(seed_lo);
            seed_hi = mixStafford13(seed_hi);
        }
        return Self{ .seed_lo = seed_lo, .seed_hi = seed_hi };
    }
};

pub fn mixSeed128Bit(seed: *Seed128Bit) void {
    seed.seed_lo = mixStafford13(seed.seed_lo);
    seed.seed_hi = mixStafford13(seed.seed_hi);
}

pub fn xorSeed128Bit(seed: *Seed128Bit, other: Seed128Bit) void {
    seed.seed_lo ^= other.seed_lo;
    seed.seed_hi ^= other.seed_hi;
}

test "hash" {
    const seed = Seed128Bit.initFromHashOf("octave_0");
    try expect(seed.seed_lo == -3096497386513543812);
    try expect(seed.seed_hi == 7932617871068508937);
    const seed1 = Seed128Bit.initFromHashOf("octave_-1");
    try expect(seed1.seed_lo == -2307493697404144120);
    try expect(seed1.seed_hi == -5064731985740145495);
}

test "xoroshiro128++ sequence" {
    var random = Xoroshiro.init(1, 1);
    try expectEqual(1, random.seed_lo);
    try expectEqual(1, random.seed_hi);
    try expectEqual(0, random.nextI32(10000));
    try expectEqual(562949953421312, random.seed_lo);
    try expectEqual(0, random.seed_hi);
    try expectEqual(0, random.nextI32(10000));
    try expectEqual(562967133290496, random.seed_lo);
    try expectEqual(8192, random.seed_hi);
    try expectEqual(2500, random.nextI32(10000));
    try expectEqual(36591764152786944, random.seed_lo);
    try expectEqual(4611688217450651648, random.seed_hi);
    try expectEqual(5001, random.nextI32(10000));
    try expectEqual(4612251167404064784, random.seed_lo);
    try expectEqual(4611826755983384608, random.seed_hi);
    try expectEqual(2514, random.nextI32(10000));
    try expectEqual(4621400203759984688, random.seed_lo);
    try expectEqual(18157347906005024, random.seed_hi);

    var x: ImprovedNoise = .initXoroshiro(&random);
    _ = &x;
}

// test "xoroshiro zero seed fallback" {
// var random = Xoroshiro.init(0, 0);

// try expect(
// random.seed_lo ==
// -7_046_029_254_386_353_131,
// );

// try expect(
// random.seed_hi ==
// 7_640_891_576_956_012_809,
// );

// try expect(
// random.nextI64() ==
// 6_807_859_099_481_836_695,
// );

// try expect(
// random.nextI64() ==
// 5_275_285_228_792_843_439,
// );

// try expect(
// random.nextI64() ==
// -1_883_134_111_310_439_721,
// );
// }
