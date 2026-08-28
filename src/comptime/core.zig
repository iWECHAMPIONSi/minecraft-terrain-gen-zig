//! Shared compile-time world-generation foundation.
//! Contains only immutable data/types; no generation execution.

const strings = @import("strings.zig");

const IdentifierStrings = strings.IdentifierStrings;

// =============================================================================
// Vector types
// =============================================================================

pub const Vector3i64 = struct { x: i64, y: i64, z: i64 };

pub const Vector3i32 = struct { x: i32, y: i32, z: i32 };

pub const Vector3f32 = struct { x: f32, y: f32, z: f32 };

pub const Vector3f64 = struct { x: f64, y: f64, z: f64 };

pub const Vector2i64 = struct { x: i64, y: i64 };

pub const Vector2i32 = struct { x: i32, y: i32 };

// =============================================================================
// World-generation enums
// =============================================================================

pub const Direction = enum(i32) {
    down = 0,
    up = 1,
    north = 2,
    south = 3,
    west = 4,
    east = 5,
};

pub const DirectionAxis = enum(i32) {
    x = 0,
    y = 1,
    z = 2,
};

pub const DirectionAxisDirection = enum(i32) {
    positive = 0,
    negative = 1,
};

pub const DirectionPlane = enum(i32) {
    horizontal = 0,
    vertical = 1,
};

pub const AxisCycle = enum(i32) {
    none = 0,
    forward = 1,
    backward = 2,
};

pub const Direction8 = enum(i32) {
    north = 0,
    north_east = 1,
    east = 2,
    south_east = 3,
    south = 4,
    south_west = 5,
    west = 6,
    north_west = 7,
};

pub const Rotation = enum(i32) {
    none = 0,
    clockwise_90 = 1,
    clockwise_180 = 2,
    counterclockwise_90 = 3,
};

pub const Mirror = enum(i32) {
    none = 0,
    left_right = 1,
    front_back = 2,
};

pub const BiomePrecipitation = enum(i32) {
    none = 0,
    rain = 1,
    snow = 2,
};

pub const BiomeTemperatureModifier = enum(i32) {
    none = 0,
    frozen = 1,
};

pub const BiomeGrassColorModifier = enum(i32) {
    none = 0,
    dark_forest = 1,
    swamp = 2,
};

pub const GenerationStepDecoration = enum(i32) {
    raw_generation = 0,
    lakes = 1,
    local_modifications = 2,
    underground_structures = 3,
    surface_structures = 4,
    strongholds = 5,
    underground_ores = 6,
    underground_decoration = 7,
    fluid_springs = 8,
    vegetal_decoration = 9,
    top_layer_modification = 10,
};

pub const HeightmapUsage = enum(i32) {
    worldgen = 0,
    live_world = 1,
    client = 2,
};

pub const HeightmapType = enum(i32) {
    world_surface_wg = 0,
    world_surface = 1,
    ocean_floor_wg = 2,
    ocean_floor = 3,
    motion_blocking = 4,
    motion_blocking_no_leaves = 5,
};

pub const WorldgenRandomAlgorithm = enum(i32) {
    legacy = 0,
    xoroshiro = 1,
};

pub const CaveSurface = enum(i32) {
    ceiling = 0,
    floor = 1,
};

pub const OreVeinType = enum(i32) {
    copper = 0,
    iron = 1,
};

pub const DensityMarkerType = enum(i32) {
    interpolated = 0,
    flat_cache = 1,
    cache_2d = 2,
    cache_once = 3,
    cache_all_in_cell = 4,
    blend_density = 5,
};

pub const DensityMappedType = enum(i32) {
    abs = 0,
    square = 1,
    cube = 2,
    half_negative = 3,
    quarter_negative = 4,
    invert = 5,
    squeeze = 6,
};

pub const DensityTwoArgumentType = enum(i32) {
    add = 0,
    mul = 1,
    min = 2,
    max = 3,
};

pub const DensityMulOrAddType = enum(i32) {
    mul = 0,
    add = 1,
};

pub const BambooLeaves = enum(i32) {
    none = 0,
    small = 1,
    large = 2,
};

pub const CreakingHeartState = enum(i32) {
    uprooted = 0,
    dormant = 1,
    awake = 2,
};

pub const DoubleBlockHalf = enum(i32) {
    upper = 0,
    lower = 1,
};

pub const PotentSulfurState = enum(i32) {
    dry = 0,
    wet = 1,
    dormant = 2,
    erupting = 3,
    continuous = 4,
};

pub const SpeleothemThickness = enum(i32) {
    tip_merge = 0,
    tip = 1,
    frustum = 2,
    middle = 3,
    base = 4,
};

pub const MobCategory = enum(i32) {
    monster = 0,
    creature = 1,
    ambient = 2,
    axolotls = 3,
    underground_water_creature = 4,
    water_creature = 5,
    water_ambient = 6,
    misc = 7,
};

pub const EntitySpawnReason = enum(i32) {
    natural = 0,
    chunk_generation = 1,
    spawner = 2,
    structure = 3,
    breeding = 4,
    mob_summoned = 5,
    jockey = 6,
    event = 7,
    conversion = 8,
    reinforcement = 9,
    triggered = 10,
    bucket = 11,
    spawn_item_use = 12,
    command = 13,
    dispenser = 14,
    patrol = 15,
    trial_spawner = 16,
    load = 17,
    dimension_travel = 18,
};

pub const LightLayer = enum(i32) {
    sky = 0,
    block = 1,
};

// =============================================================================
// Shared immutable data types
// =============================================================================

pub const ChunkPos = struct {
    x: i32,
    z: i32,
};

pub const Identifier = struct {
    namespace: []const u8,
    path: []const u8,
};

// Java ResourceKey<T> erases T at runtime. These are its two stored Identifier fields.

pub const ResourceKey = struct {
    registry_name: Identifier,
    identifier: Identifier,
};

pub const NoiseSettings = struct {
    min_y: i32,
    height: i32,
    noise_size_horizontal: i32,
    noise_size_vertical: i32,
};

// Java NormalNoise.NoiseParameters stores an int and a fastutil DoubleList.
// A read-only Zig slice preserves the ordered f64 amplitude data without allocator state.

pub const NormalNoiseParameters = struct {
    first_octave: i32,
    amplitudes: []const f64,
};

pub const ClimateTargetPoint = struct {
    temperature: i64,
    humidity: i64,
    continentalness: i64,
    erosion: i64,
    depth: i64,
    weirdness: i64,
};

pub const ClimateParameter = struct {
    min: i64,
    max: i64,
};

pub const ClimateParameterPoint = struct {
    temperature: ClimateParameter,
    humidity: ClimateParameter,
    continentalness: ClimateParameter,
    erosion: ClimateParameter,
    depth: ClimateParameter,
    weirdness: ClimateParameter,
    offset: i64,
};

// Java VerticalAnchor is a sealed-by-convention interface with exactly these three record implementations.

pub const VerticalAnchor = union(enum) {
    absolute: i32,
    above_bottom: i32,
    below_top: i32,
};

pub const WorldGenerationContext = struct {
    min_y: i32,
    height: i32,
};

pub fn Weighted(comptime T: type) type {
    return struct {
        value: T,
        weight: i32,
    };
}

// Java WeightedList additionally owns a Selector cache. The selector is an execution optimization,
// so this immutable form stores only the source items and the Java int totalWeight.

pub fn WeightedList(comptime T: type) type {
    return struct {
        total_weight: i32,
        items: []const Weighted(T),
    };
}

pub const ConstantInt = struct { value: i32 };

pub const UniformInt = struct { min_inclusive: i32, max_inclusive: i32 };

pub const BiasedToBottomInt = struct { min_inclusive: i32, max_inclusive: i32 };

pub const ClampedNormalInt = struct {
    mean: f32,
    deviation: f32,
    min_inclusive: i32,
    max_inclusive: i32,
};

pub const TrapezoidInt = struct {
    min_inclusive: i32,
    max_inclusive: i32,
    plateau: i32,
};

pub const ClampedInt = struct {
    source: *const IntProvider,
    min_inclusive: i32,
    max_inclusive: i32,
};

pub const WeightedListInt = struct {
    distribution: WeightedList(*const IntProvider),
    min_value: i32,
    max_value: i32,
};

// Procedural sum type corresponding to Java's IntProvider interface + registered implementations.

pub const IntProvider = union(enum) {
    constant: ConstantInt,
    uniform: UniformInt,
    biased_to_bottom: BiasedToBottomInt,
    clamped: ClampedInt,
    weighted_list: WeightedListInt,
    clamped_normal: ClampedNormalInt,
    trapezoid: TrapezoidInt,
};

pub const ConstantFloat = struct { value: f32 };

pub const UniformFloat = struct { min: f32, max: f32 };

pub const ClampedNormalFloat = struct {
    mean: f32,
    deviation: f32,
    min: f32,
    max: f32,
};

pub const TrapezoidFloat = struct {
    min: f32,
    max: f32,
    plateau: f32,
};

// Procedural sum type corresponding to Java's FloatProvider interface.

pub const FloatProvider = union(enum) {
    constant: ConstantFloat,
    uniform: UniformFloat,
    clamped_normal: ClampedNormalFloat,
    trapezoid: TrapezoidFloat,
};

pub const ConstantHeight = struct { value: VerticalAnchor };

pub const UniformHeight = struct {
    min_inclusive: VerticalAnchor,
    max_inclusive: VerticalAnchor,
};

pub const BiasedToBottomHeight = struct {
    min_inclusive: VerticalAnchor,
    max_inclusive: VerticalAnchor,
    inner: i32,
};

pub const VeryBiasedToBottomHeight = struct {
    min_inclusive: VerticalAnchor,
    max_inclusive: VerticalAnchor,
    inner: i32,
};

pub const TrapezoidHeight = struct {
    min_inclusive: VerticalAnchor,
    max_inclusive: VerticalAnchor,
    plateau: i32,
};

pub const WeightedListHeight = struct {
    distribution: WeightedList(*const HeightProvider),
};

// UniformHeight's Java LongSet warnedFor is intentionally absent: it is mutable warning/cache state,
// not immutable provider configuration.

pub const HeightProvider = union(enum) {
    constant: ConstantHeight,
    uniform: UniformHeight,
    biased_to_bottom: BiasedToBottomHeight,
    very_biased_to_bottom: VeryBiasedToBottomHeight,
    trapezoid: TrapezoidHeight,
    weighted_list: WeightedListHeight,
};

pub const ChunkOffset = struct {
    x: i32,
    z: i32,
};

// =============================================================================
// Enum-associated immutable data
// =============================================================================

pub const direction_data3d: [6]i32 = .{
    0,
    1,
    2,
    3,
    4,
    5,
};

pub const direction_opposite_index: [6]i32 = .{
    1,
    0,
    3,
    2,
    5,
    4,
};

pub const direction_data2d: [6]i32 = .{
    -1,
    -1,
    2,
    0,
    1,
    3,
};

pub const direction_axis: [6]DirectionAxis = .{
    .y,
    .y,
    .z,
    .z,
    .x,
    .x,
};

pub const direction_axis_direction: [6]DirectionAxisDirection = .{
    .negative,
    .positive,
    .negative,
    .positive,
    .negative,
    .positive,
};

pub const direction_normal: [6]Vector3i32 = .{
    .{ .x = 0, .y = -1, .z = 0 },
    .{ .x = 0, .y = 1, .z = 0 },
    .{ .x = 0, .y = 0, .z = -1 },
    .{ .x = 0, .y = 0, .z = 1 },
    .{ .x = -1, .y = 0, .z = 0 },
    .{ .x = 1, .y = 0, .z = 0 },
};

// Java Direction.normalVec3 is net.minecraft.world.phys.Vec3, whose components
// are double.

pub const direction_normal_vec3: [6]Vector3f64 = .{
    .{ .x = 0.0, .y = -1.0, .z = 0.0 },
    .{ .x = 0.0, .y = 1.0, .z = 0.0 },
    .{ .x = 0.0, .y = 0.0, .z = -1.0 },
    .{ .x = 0.0, .y = 0.0, .z = 1.0 },
    .{ .x = -1.0, .y = 0.0, .z = 0.0 },
    .{ .x = 1.0, .y = 0.0, .z = 0.0 },
};

// Java Direction.normalVec3f is a JOML Vector3f exposed as Vector3fc.

pub const direction_normal_vec3f: [6]Vector3f32 = .{
    .{ .x = 0.0, .y = -1.0, .z = 0.0 },
    .{ .x = 0.0, .y = 1.0, .z = 0.0 },
    .{ .x = 0.0, .y = 0.0, .z = -1.0 },
    .{ .x = 0.0, .y = 0.0, .z = 1.0 },
    .{ .x = -1.0, .y = 0.0, .z = 0.0 },
    .{ .x = 1.0, .y = 0.0, .z = 0.0 },
};

// -----------------------------------------------------------------------------
// Direction.AxisDirection
// Java: net.minecraft.core.Direction.AxisDirection
// Array order: positive, negative.
// -----------------------------------------------------------------------------

pub const direction_axis_direction_step: [2]i32 = .{
    1,
    -1,
};

// -----------------------------------------------------------------------------
// Direction8
// Java: net.minecraft.core.Direction8
// Array order: north, north_east, east, south_east, south, south_west, west,
// north_west.
// -----------------------------------------------------------------------------

pub const direction8_step: [8]Vector3i32 = .{
    .{ .x = 0, .y = 0, .z = -1 },
    .{ .x = 1, .y = 0, .z = -1 },
    .{ .x = 1, .y = 0, .z = 0 },
    .{ .x = 1, .y = 0, .z = 1 },
    .{ .x = 0, .y = 0, .z = 1 },
    .{ .x = -1, .y = 0, .z = 1 },
    .{ .x = -1, .y = 0, .z = 0 },
    .{ .x = -1, .y = 0, .z = -1 },
};

// -----------------------------------------------------------------------------
// Rotation
// Java: net.minecraft.world.level.block.Rotation
// Array order: none, clockwise_90, clockwise_180, counterclockwise_90.
// -----------------------------------------------------------------------------

pub const rotation_index: [4]i32 = .{
    0,
    1,
    2,
    3,
};

// -----------------------------------------------------------------------------
// Heightmap.Types
// Java: net.minecraft.world.level.levelgen.Heightmap.Types
// Array order matches HeightmapType.ordinal().
// -----------------------------------------------------------------------------

pub const heightmap_type_id: [6]i32 = .{
    0,
    1,
    2,
    3,
    4,
    5,
};

pub const heightmap_type_usage: [6]HeightmapUsage = .{
    .worldgen,
    .client,
    .worldgen,
    .live_world,
    .client,
    .client,
};

// -----------------------------------------------------------------------------
// CaveSurface
// Java: net.minecraft.world.level.levelgen.placement.CaveSurface
// Array order: ceiling, floor.
// -----------------------------------------------------------------------------

pub const cave_surface_direction: [2]Direction = .{
    .up,
    .down,
};

pub const cave_surface_y: [2]i32 = .{
    1,
    -1,
};

// -----------------------------------------------------------------------------
// OreVeinifier.VeinType
// Java: net.minecraft.world.level.levelgen.OreVeinifier.VeinType
// BlockState fields are intentionally omitted until BlockState exists.
// Array order: copper, iron.
// -----------------------------------------------------------------------------

pub const ore_vein_type_min_y: [2]i32 = .{
    0,
    -60,
};

pub const ore_vein_type_max_y: [2]i32 = .{
    50,
    -8,
};

// -----------------------------------------------------------------------------
// DoubleBlockHalf
// Java: net.minecraft.world.level.block.state.properties.DoubleBlockHalf
// Array order: upper, lower.
// -----------------------------------------------------------------------------

pub const double_block_half_direction_to_other: [2]Direction = .{
    .down,
    .up,
};

// -----------------------------------------------------------------------------
// MobCategory
// Java: net.minecraft.world.entity.MobCategory
// Array order: monster, creature, ambient, axolotls,
// underground_water_creature, water_creature, water_ambient, misc.
// -----------------------------------------------------------------------------

pub const mob_category_max: [8]i32 = .{
    70,
    10,
    15,
    5,
    5,
    5,
    20,
    -1,
};

pub const mob_category_is_friendly: [8]bool = .{
    false,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
};

pub const mob_category_is_persistent: [8]bool = .{
    false,
    true,
    false,
    false,
    false,
    false,
    false,
    true,
};

// Every MobCategory enum instance initializes this Java int field to 32.

pub const mob_category_no_despawn_distance: i32 = 32;

pub const mob_category_despawn_distance: [8]i32 = .{
    128,
    128,
    128,
    128,
    128,
    128,
    64,
    128,
};

// =============================================================================
// Coordinates, dimensions, math, and random constants
// =============================================================================

pub const level_max_size: i32 = 30_000_000;

pub const level_across_whole_world: i32 = 60_000_000;

pub const vec3i_zero: Vector3i32 = .{
    .x = 0,
    .y = 0,
    .z = 0,
};

pub const block_pos_zero: Vector3i32 = vec3i_zero;

pub const block_pos_packed_horizontal_length: i32 = 26;

pub const block_pos_packed_y_length: i32 = 12;

pub const block_pos_packed_x_mask: i64 = 67_108_863;

pub const block_pos_packed_y_mask: i64 = 4_095;

pub const block_pos_packed_z_mask: i64 = 67_108_863;

pub const block_pos_y_offset: i32 = 0;

pub const block_pos_z_offset: i32 = 12;

pub const block_pos_x_offset: i32 = 38;

pub const block_pos_max_horizontal_coordinate: i32 = 33_554_431;

pub const section_pos_section_bits: i32 = 4;

pub const section_pos_section_size: i32 = 16;

pub const section_pos_section_block_count: i32 = 4_096;

pub const section_pos_section_mask: i32 = 15;

pub const section_pos_section_half_size: i32 = 8;

pub const section_pos_section_max_index: i32 = 15;

pub const section_pos_packed_x_length: i32 = 22;

pub const section_pos_packed_y_length: i32 = 20;

pub const section_pos_packed_z_length: i32 = 22;

pub const section_pos_packed_x_mask: i64 = 4_194_303;

pub const section_pos_packed_y_mask: i64 = 1_048_575;

pub const section_pos_packed_z_mask: i64 = 4_194_303;

pub const section_pos_y_offset: i32 = 0;

pub const section_pos_z_offset: i32 = 20;

pub const section_pos_x_offset: i32 = 42;

pub const section_pos_relative_x_shift: i32 = 8;

pub const section_pos_relative_y_shift: i32 = 0;

pub const section_pos_relative_z_shift: i32 = 4;

pub const quart_pos_bits: i32 = 2;

pub const quart_pos_size: i32 = 4;

pub const quart_pos_mask: i32 = 3;

pub const quart_pos_section_to_quarts_bits: i32 = 2;

pub const chunk_pos_safety_margin: i32 = 1_056;

pub const chunk_pos_invalid: i64 = 8_053_347_149_716_602;

pub const chunk_pos_coord_bits: i64 = 32;

pub const chunk_pos_coord_mask: i64 = 4_294_967_295;

pub const chunk_pos_region_bits: i32 = 5;

pub const chunk_pos_region_size: i32 = 32;

pub const chunk_pos_region_mask: i32 = 31;

pub const chunk_pos_region_max_index: i32 = 31;

pub const chunk_pos_hash_a: i32 = 1_664_525;

pub const chunk_pos_hash_c: i32 = 1_013_904_223;

pub const chunk_pos_hash_z_xor: i32 = -559_038_737;

pub const chunk_access_no_filled_section: i32 = -1;

pub const level_chunk_section_biome_container_bits: i32 = 2;

pub const chunk_status_max_structure_distance: i32 = 8;

// -----------------------------------------------------------------------------
// Dimension constants
// -----------------------------------------------------------------------------

pub const dimension_overworld_min_y: i32 = -64;

pub const dimension_overworld_level_height: i32 = 384;

pub const dimension_overworld_generation_height: i32 = 384;

pub const dimension_overworld_logical_height: i32 = 384;

pub const dimension_nether_min_y: i32 = 0;

pub const dimension_nether_level_height: i32 = 256;

pub const dimension_nether_generation_height: i32 = 128;

pub const dimension_nether_logical_height: i32 = 128;

pub const dimension_end_min_y: i32 = 0;

pub const dimension_end_level_height: i32 = 256;

pub const dimension_end_generation_height: i32 = 128;

pub const dimension_end_logical_height: i32 = 256;

pub const dimension_end_island_base_y: i32 = 63;

pub const dimension_type_bits_for_y: i32 = 12;

pub const dimension_type_min_height: i32 = 16;

pub const dimension_type_y_size: i32 = 4_064;

pub const dimension_type_max_y: i32 = 2_031;

pub const dimension_type_min_y: i32 = -2_032;

pub const dimension_type_way_above_max_y: i32 = 32_496;

pub const dimension_type_way_below_min_y: i32 = -32_512;

// -----------------------------------------------------------------------------
// Biome-coordinate and climate constants
// -----------------------------------------------------------------------------

pub const mth_pi: f32 = 3.1415927;

pub const mth_half_pi: f32 = 1.5707964;

pub const mth_two_pi: f32 = 6.2831855;

pub const mth_deg_to_rad: f32 = 0.017453292;

pub const mth_rad_to_deg: f32 = 57.295776;

pub const mth_epsilon: f32 = 1.0e-5;

pub const mth_sqrt_of_two: f32 = 1.4142135;

pub const mth_sin_quantization: i32 = 65_536;

pub const mth_sin_mask: i32 = 65_535;

pub const mth_cos_offset: i32 = 16_384;

pub const mth_sin_scale: f64 = 10_430.378350470453;

pub const mth_one_sixth: f64 = 0.16666666666666666;

pub const mth_frac_exp: i32 = 8;

pub const mth_lut_size: i32 = 257;

pub const mth_frac_bias: f64 = 17_592_186_044_416.0;

// -----------------------------------------------------------------------------
// Random-number-generation constants
// -----------------------------------------------------------------------------

pub const bit_random_float_multiplier: f32 = 5.9604645e-8;

pub const bit_random_double_multiplier: f64 = 1.1102230246251565e-16;

pub const legacy_random_modulus_bits: i32 = 48;

pub const legacy_random_modulus_mask: i64 = 281_474_976_710_655;

pub const legacy_random_multiplier: i64 = 25_214_903_917;

pub const legacy_random_increment: i64 = 11;

pub const xoroshiro_random_float_unit: f32 = bit_random_float_multiplier;

pub const xoroshiro_random_double_unit: f64 = bit_random_double_multiplier;

pub const random_support_golden_ratio_64: i64 = -7_046_029_254_386_353_131;

pub const random_support_silver_ratio_64: i64 = 7_640_891_576_950_612_809;

// Numeric literals used as fixed parameters by RandomSupport.

pub const random_support_mix_stafford_13_first_shift: i32 = 30;

pub const random_support_mix_stafford_13_first_multiplier: i64 = -4_658_895_280_553_007_687;

pub const random_support_mix_stafford_13_second_shift: i32 = 27;

pub const random_support_mix_stafford_13_second_multiplier: i64 = -7_723_592_293_110_705_685;

pub const random_support_mix_stafford_13_final_shift: i32 = 31;

pub const random_support_seed_uniquifier_multiplier: i64 = 1_181_783_497_276_652_981;

// Numeric literals used as fixed parameters by Xoroshiro128PlusPlus.

pub const xoroshiro_result_rotate_left: i32 = 17;

pub const xoroshiro_seed_lo_rotate_left: i32 = 49;

pub const xoroshiro_seed_lo_shift_left: i32 = 21;

pub const xoroshiro_seed_hi_rotate_left: i32 = 28;

pub const xoroshiro_unsigned_int_mask: i64 = 4_294_967_295;

// Numeric literals used as fixed parameters by WorldgenRandom.

pub const worldgen_feature_step_multiplier: i32 = 10_000;

pub const worldgen_large_feature_x_multiplier: i64 = 341_873_128_712;

pub const worldgen_large_feature_z_multiplier: i64 = 132_897_987_541;

pub const worldgen_slime_x_square_multiplier: i32 = 4_987_142;

pub const worldgen_slime_x_multiplier: i32 = 5_947_611;

pub const worldgen_slime_z_square_multiplier: i64 = 4_392_871;

pub const worldgen_slime_z_multiplier: i32 = 389_711;

// -----------------------------------------------------------------------------
// Primitive noise constants
// -----------------------------------------------------------------------------

// =============================================================================
// Shared constant data
// =============================================================================

pub const chunk_pos_zero: ChunkPos = .{ .x = 0, .z = 0 };

pub const vertical_anchor_bottom: VerticalAnchor = .{ .above_bottom = 0 };

pub const vertical_anchor_top: VerticalAnchor = .{ .below_top = 0 };

pub const constant_int_zero: ConstantInt = .{ .value = 0 };

pub const constant_float_zero: ConstantFloat = .{ .value = 0.0 };

pub const constant_height_zero: ConstantHeight = .{ .value = .{ .absolute = 0 } };

pub const RegistryIdentifierData = struct {
    pub const root: Identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = IdentifierStrings.root_registry };
    pub const noise: Identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = IdentifierStrings.noise_registry };
    pub const biome: Identifier = .{ .namespace = IdentifierStrings.default_namespace, .path = IdentifierStrings.biome_registry };
};

pub const RegistryKeyData = struct {
    pub const noise: ResourceKey = .{ .registry_name = RegistryIdentifierData.root, .identifier = RegistryIdentifierData.noise };
    pub const biome: ResourceKey = .{ .registry_name = RegistryIdentifierData.root, .identifier = RegistryIdentifierData.biome };
};

pub const dimension_type_moon_brightness_per_phase: [8]f32 = .{ 1.0, 0.75, 0.5, 0.25, 0.0, 0.25, 0.5, 0.75 };

pub const direction_yxz_axis_order: [3]DirectionAxis = .{ .y, .x, .z };

pub const direction_yzx_axis_order: [3]DirectionAxis = .{ .y, .z, .x };

pub const direction_plane_faces: [2][]const Direction = .{
    &.{ .north, .east, .south, .west },
    &.{ .up, .down },
};

pub const direction_plane_axes: [2][]const DirectionAxis = .{
    &.{ .x, .z },
    &.{.y},
};

pub const direction8_directions: [8][]const Direction = .{
    &.{.north},
    &.{ .north, .east },
    &.{.east},
    &.{ .south, .east },
    &.{.south},
    &.{ .south, .west },
    &.{.west},
    &.{ .north, .west },
};
