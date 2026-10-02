const std = @import("std");
const math = std.math;
const ArrayList = std.ArrayList;
const StdErr = @import("errors.zig").StdErr;

const noise = @import("comptime/noise.zig");
const random = @import("random.zig");
const ImprovedNoise = random.ImprovedNoise;
const Xoroshiro = random.Xoroshiro;
const XoroshiroFactory = random.XoroshiroFactory;
const perlin_noise_round_off = noise.perlin_noise_round_off;

pub const PerlinNoise = struct {
    noise_levels: []?ImprovedNoise,
    first_octave: i32,
    amplitudes: ArrayList(f64),
    lowest_freq_value_factor: f64,
    lowest_freq_input_factor: f64,
    max_value: f64,
    allocator: std.mem.Allocator,
    const round_off: i32 = perlin_noise_round_off;
    const Self = @This();

    pub fn init(allocator: std.mem.Allocator, random_source: *Xoroshiro, pair: .{ i32, ArrayList(f64) }, use_new_initialization: bool) StdErr!Self {
        const first_octave: i32 = pair[0];
        const amplitudes: ArrayList(f64) = pair[1];
        const octaves: i32 = @intCast(amplitudes.items.len);
        const zero_octave_index: i32 = -first_octave;
        var noise_levels: []?ImprovedNoise = try allocator.alloc(?ImprovedNoise, octaves) catch {
            return StdErr.MemoryAllocationFail;
        };
        errdefer allocator.free(noise_levels);
        for (0..octaves) |e| {
            noise_levels[e] = null;
        }

        if (use_new_initialization) {
            var positional: XoroshiroFactory = random_source.forkPositional();

            for (0..octaves) |i| {
                if (amplitudes.items[i] != 0.0) {
                    const octave: i32 = first_octave + @as(i32, @intCast(i));

                    var buffer: [18]u8 = undefined;
                    const octave_name = std.fmt.bufPrint(
                        &buffer,
                        "octave_{d}",
                        .{octave},
                    ) catch unreachable;

                    var octave_random = positional.fromHashOf(octave_name);
                    noise_levels[i] = ImprovedNoise.initXoroshiro(&octave_random);
                }
            }
        } else {
            const zero_octave: ImprovedNoise = ImprovedNoise.initXoroshiro(random_source);
            if (zero_octave_index >= 0 and zero_octave_index < octaves) {
                const zero_octave_amplitude: f64 = amplitudes.items[zero_octave_index];
                if (zero_octave_amplitude != 0.0) {
                    noise_levels[zero_octave_index] = zero_octave;
                }
            }

            var i: i32 = zero_octave_index - 1;

            while (i >= 0) : (i -= 1) {
                if (i < octaves) {
                    const amplitude: f64 = amplitudes.items[i];
                    if (amplitude != 0.0) {
                        noise_levels[i] = ImprovedNoise.initXoroshiro(random_source);
                    } else {
                        skipOctave(random_source);
                    }
                } else {
                    skipOctave(random_source);
                }
            }
            var non_null: usize = 0;
            for (noise_levels) |e| {
                if (e != null) {
                    non_null += 1;
                }
            }
            var non_zero: usize = 0;
            for (amplitudes) |e| {
                if (e != 0.0) {
                    non_zero += 1;
                }
            }
            if (non_null != non_zero) {
                return StdErr.InvalidState;
            }
        }
        const lowest_freq_input_factor: f64 = math.pow(f64, 2.0, @floatFromInt(-zero_octave_index));
        const lowest_freq_value_factor: f64 = math.pow(f64, 2.0, @as(f64, @floatFromInt(octaves - 1))) / (math.pow(f64, 2.0, @floatFromInt(octaves)) - 1.0);

        const noise_value: f64 = 2.0;

        var value: f64 = 0.0;
        var value_factor: f64 = lowest_freq_value_factor;

        for (0..noise_levels.len) |e| {
            const noise_t: ?ImprovedNoise = noise_levels[e];
            if (noise_t != null) {
                value += amplitudes.items[e] * noise_value * value_factor;
            }

            value_factor /= 2.0;
        }

        return .{
            .noise_levels = noise_levels,
            .first_octave = first_octave,
            .amplitudes = amplitudes,
            .lowest_freq_value_factor = lowest_freq_value_factor,
            .lowest_freq_input_factor = lowest_freq_input_factor,
            .max_value = value,
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *Self) void {
        self.allocator.free(self.noise_levels);
        self.amplitudes.deinit(self.allocator);
    }
};

pub fn skipOctave(random_source: *Xoroshiro) void {
    random_source.consumeCount(262);
}

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
