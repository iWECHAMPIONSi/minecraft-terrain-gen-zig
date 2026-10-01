const std = @import("std");
const ArrayList = std.ArrayList;
const StdErr = @import("errors.zig").StdErr;

const noise = @import("comptime/noise.zig");
const random = @import("random.zig");
const ImprovedNoise = random.ImprovedNoise;
const Xoroshiro = random.Xoroshiro;
const perlin_noise_round_off = noise.perlin_noise_round_off;

pub const PerlinNoise = struct {
    noise_levels: []?ImprovedNoise,
    first_octive: i32,
    amplitudes: ArrayList(f64),
    lowest_freq_value_factor: f64,
    lowest_freq_input_factor: f64,
    max_value: f64,
    allocator: std.mem.Allocator,
    const round_off: i32 = perlin_noise_round_off;
    const Self = @This();

    pub fn init(allocator: std.mem.Allocator, random_source: Xoroshiro, pair: .{ i32, ArrayList(f64) }, use_new_initialization: bool) StdErr!Self {}
};

pub fn makeAmplitudes(allocator: std.mem.Allocator, octave_set: []i32) StdErr!struct { i32, ArrayList(f64) } {
    if (octave_set.len == 0) {
        return StdErr.InvalidParameter;
    }

    for (octave_set[1..], 1..) |octave, i| {
        std.debug.assert(octave_set[i - 1] <= octave);
    }

    const low_freq_octaves: i32 = -octave_set[0];
    const high_freq_octaves: i32 = octave_set[octave_set.len - 1];
    const octaves: i32 = low_freq_octaves + high_freq_octaves + 1;
    if (octaves < 1) {
        return StdErr.InvalidParameter;
    }
    var amplitudes: ArrayList(f64) = .empty;
    errdefer amplitudes.deinit(allocator);

    try amplitudes.appendNTimes(allocator, 0.0, @intCast(octaves)) catch {
        return StdErr.MemoryAllocationFail;
    };

    for (octave_set) |octave| {
        amplitudes.items[octave + low_freq_octaves] = 1.0;
    }
    return .{ -low_freq_octaves, amplitudes };
}
