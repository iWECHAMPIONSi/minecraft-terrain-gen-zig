const std = @import("std");
const ArrayList = std.ArrayList;

const noise = @import("comptime/noise.zig");
const random = @import("random.zig");
const ImprovedNoise = random.ImprovedNoise;
const Xoroshiro = random.Xoroshiro;
const perlin_noise_round_off = noise.perlin_noise_round_off;

pub const PerlinNoise = struct {
    round_off: i32 = perlin_noise_round_off,
    noise_levels: []?ImprovedNoise,
    first_octive: i32,
    amplitudes: ArrayList(f64),
    lowest_freq_value_factor: f64,
    lowest_freq_input_factor: f64,
    max_value: f64,
    allocator: std.mem.Allocator,
};

pub fn makeAmplitudes(

