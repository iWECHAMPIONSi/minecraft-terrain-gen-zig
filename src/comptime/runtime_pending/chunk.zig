pub const OverworldChunk = struct {
    x: i64,
    z: i64,
    blocks: []const u8,
    overworld_biome: []const u8,
    underground_biome: []const u8,
    bottom_biome: []const u8
};
