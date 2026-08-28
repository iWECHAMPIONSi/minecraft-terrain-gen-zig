//! Block identities and declarative block/fluid state data.

const core = @import("core.zig");

const Identifier = core.Identifier;
const ResourceKey = core.ResourceKey;

// =============================================================================
// Block identities
// =============================================================================

pub const Blocks = enum(u8) {
    acacia_leaves,
    acacia_log,
    air,
    allium,
    amethyst_block,
    amethyst_cluster,
    ancient_debris,
    andesite,
    azalea,
    azalea_leaves,
    azure_bluet,
    bamboo,
    basalt,
    bedrock,
    bee_nest,
    big_dripleaf,
    big_dripleaf_stem,
    birch_leaves,
    birch_log,
    blackstone,
    blue_ice,
    blue_orchid,
    bone_block,
    brain_coral,
    brain_coral_block,
    brain_coral_fan,
    brain_coral_wall_fan,
    brown_mushroom,
    brown_mushroom_block,
    brown_terracotta,
    bubble_column,
    bubble_coral,
    bubble_coral_block,
    bubble_coral_fan,
    bubble_coral_wall_fan,
    budding_amethyst,
    bush,
    cactus,
    cactus_flower,
    calcite,
    cave_air,
    cave_vines,
    cave_vines_plant,
    cherry_leaves,
    cherry_log,
    chest,
    chorus_flower,
    chorus_plant,
    cinnabar,
    clay,
    closed_eyeblossom,
    coal_ore,
    coarse_dirt,
    cobblestone,
    cocoa,
    copper_ore,
    cornflower,
    creaking_heart,
    crimson_fungus,
    crimson_nylium,
    crimson_roots,
    crimson_stem,
    dandelion,
    dark_oak_leaves,
    dark_oak_log,
    dead_bush,
    deepslate,
    deepslate_coal_ore,
    deepslate_copper_ore,
    deepslate_diamond_ore,
    deepslate_emerald_ore,
    deepslate_gold_ore,
    deepslate_iron_ore,
    deepslate_lapis_ore,
    deepslate_redstone_ore,
    diamond_ore,
    diorite,
    dirt,
    dripstone_block,
    emerald_ore,
    end_gateway,
    end_stone,
    fern,
    fire,
    firefly_bush,
    fire_coral,
    fire_coral_block,
    fire_coral_fan,
    fire_coral_wall_fan,
    flowering_azalea,
    flowering_azalea_leaves,
    glowstone,
    glow_lichen,
    gold_ore,
    granite,
    grass_block,
    gravel,
    hanging_roots,
    horn_coral,
    horn_coral_block,
    horn_coral_fan,
    horn_coral_wall_fan,
    ice,
    infested_deepslate,
    infested_stone,
    iron_bars,
    iron_ore,
    jungle_leaves,
    jungle_log,
    kelp,
    kelp_plant,
    lapis_ore,
    large_amethyst_bud,
    large_fern,
    lava,
    leaf_litter,
    light_gray_terracotta,
    lilac,
    lily_of_the_valley,
    lily_pad,
    magma_block,
    mangrove_leaves,
    mangrove_log,
    mangrove_propagule,
    mangrove_roots,
    medium_amethyst_bud,
    melon,
    mossy_cobblestone,
    moss_block,
    moss_carpet,
    mud,
    muddy_mangrove_roots,
    mushroom_stem,
    mycelium,
    netherrack,
    nether_gold_ore,
    nether_quartz_ore,
    nether_sprouts,
    nether_wart_block,
    oak_leaves,
    oak_log,
    obsidian,
    orange_terracotta,
    orange_tulip,
    oxeye_daisy,
    packed_ice,
    pale_hanging_moss,
    pale_moss_block,
    pale_moss_carpet,
    pale_oak_leaves,
    pale_oak_log,
    peony,
    pink_petals,
    pink_tulip,
    podzol,
    pointed_dripstone,
    poppy,
    potent_sulfur,
    powder_snow,
    pumpkin,
    raw_copper_block,
    raw_iron_block,
    redstone_ore,
    red_mushroom,
    red_mushroom_block,
    red_sand,
    red_sandstone,
    red_terracotta,
    red_tulip,
    rooted_dirt,
    rose_bush,
    sand,
    sandstone,
    sandstone_slab,
    sculk,
    sculk_catalyst,
    sculk_sensor,
    sculk_shrieker,
    sculk_vein,
    seagrass,
    sea_pickle,
    short_dry_grass,
    short_grass,
    shroomlight,
    small_amethyst_bud,
    small_dripleaf,
    smooth_basalt,
    snow,
    snow_block,
    soul_fire,
    soul_sand,
    soul_soil,
    spawner,
    spore_blossom,
    spruce_leaves,
    spruce_log,
    stone,
    sugar_cane,
    sulfur,
    sulfur_spike,
    sunflower,
    suspicious_sand,
    sweet_berry_bush,
    tall_dry_grass,
    tall_grass,
    tall_seagrass,
    terracotta,
    tube_coral,
    tube_coral_block,
    tube_coral_fan,
    tube_coral_wall_fan,
    tuff,
    twisting_vines,
    twisting_vines_plant,
    vine,
    warped_fungus,
    warped_nylium,
    warped_roots,
    warped_stem,
    warped_wart_block,
    water,
    weeping_vines,
    weeping_vines_plant,
    white_terracotta,
    white_tulip,
    wildflowers,
    yellow_terracotta,
};

pub const Default = struct {
    pub const Block = enum(u8) { overworld = @intFromEnum(Blocks.stone), nether = @intFromEnum(Blocks.netherrack), end = @intFromEnum(Blocks.end_stone) };
    pub const Fluid = enum(u8) { overworld = @intFromEnum(Blocks.water), nether = @intFromEnum(Blocks.lava), end = @intFromEnum(Blocks.air) };
};

// Generation

// =============================================================================
// Block/fluid state declarative types
// =============================================================================

pub const BlockPropertyId = enum(u16) {
    attached,
    berries,
    bloom,
    bottom,
    can_summon,
    conditional,
    disarmed,
    drag,
    enabled,
    extended,
    eye,
    falling,
    hanging,
    has_bottle_0,
    has_bottle_1,
    has_bottle_2,
    has_record,
    has_book,
    inverted,
    in_wall,
    lit,
    locked,
    natural,
    occupied,
    open,
    persistent,
    powered,
    short,
    shrieking,
    signal_fire,
    snowy,
    tip,
    triggered,
    unstable,
    waterlogged,
    horizontal_axis,
    axis,
    up,
    down,
    north,
    east,
    south,
    west,
    facing,
    facing_hopper,
    horizontal_facing,
    flower_amount,
    segment_amount,
    orientation,
    attach_face,
    bell_attachment,
    east_wall,
    north_wall,
    south_wall,
    west_wall,
    east_redstone,
    north_redstone,
    south_redstone,
    west_redstone,
    double_block_half,
    half,
    side_chain_part,
    rail_shape,
    rail_shape_straight,
    age_1,
    age_2,
    age_3,
    age_4,
    age_5,
    age_7,
    age_15,
    age_25,
    bites,
    candles,
    delay,
    distance,
    eggs,
    hatch,
    layers,
    level_cauldron,
    level_composter,
    level_flowing,
    level_honey,
    level,
    moisture,
    note,
    pickles,
    power,
    stage,
    stability_distance,
    respawn_anchor_charges,
    dried_ghast_hydration_levels,
    rotation_16,
    bed_part,
    chest_type,
    mode_comparator,
    door_hinge,
    noteblock_instrument,
    piston_type,
    slab_type,
    stairs_shape,
    structureblock_mode,
    bamboo_leaves,
    tilt,
    vertical_direction,
    speleothem_thickness,
    sculk_sensor_phase,
    slot_0_occupied,
    slot_1_occupied,
    slot_2_occupied,
    slot_3_occupied,
    slot_4_occupied,
    slot_5_occupied,
    dusted,
    cracked,
    crafting,
    trial_spawner_state,
    vault_state,
    creaking_heart_state,
    ominous,
    test_block_mode,
    map,
    copper_golem_pose,
    potent_sulfur_state,
};

pub const BlockPropertyEnumDomain = enum(u8) {
    attach_face,
    bamboo_leaves,
    bed_part,
    bell_attach_type,
    chest_type,
    comparator_mode,
    copper_golem_statue_block_pose,
    creaking_heart_state,
    direction,
    direction_axis,
    door_hinge_side,
    double_block_half,
    front_and_top,
    half,
    note_block_instrument,
    piston_type,
    potent_sulfur_state,
    rail_shape,
    redstone_side,
    sculk_sensor_phase,
    side_chain_part,
    slab_type,
    speleothem_thickness,
    stairs_shape,
    structure_mode,
    test_block_mode,
    tilt,
    trial_spawner_state,
    vault_state,
    wall_side,
};

pub const IntegerPropertyData = struct {
    min_inclusive: i32,
    max_inclusive: i32,
};

pub const EnumPropertyData = struct {
    domain: BlockPropertyEnumDomain,

    // null means every value of the Java enum, in Java enum declaration order.
    // Non-null slices preserve the exact filtered/explicit EnumProperty value order.
    allowed_ordinals: ?[]const i32 = null,
};

pub const BlockPropertyType = union(enum) {
    boolean,
    integer: IntegerPropertyData,
    enumeration: EnumPropertyData,
};

pub const BlockPropertyDefinition = struct {
    property_type: BlockPropertyType,
};

pub const BlockPropertyValue = union(enum) {
    boolean: bool,
    integer: i32,

    // Java EnumProperty<T> stores T. The declarative representation stores T.ordinal();
    // BlockPropertyDefinition.enumeration.domain identifies the concrete Java enum type.
    enumeration: i32,
};

pub const BlockPropertyEntry = struct {
    property: BlockPropertyId,
    value: BlockPropertyValue,
};

// A source-level block-state specification.
// `properties` are overrides applied to the block's Java defaultBlockState(), matching the
// way vanilla worldgen constants are generally written in Java.

pub const BlockStateSpec = struct {
    block: Blocks,
    properties: []const BlockPropertyEntry = &.{},
};

pub const Fluid = enum(u8) {
    empty,
    flowing_water,
    water,
    flowing_lava,
    lava,
};

pub const FluidPropertyId = enum(u8) {
    falling,
    level,
};

pub const FluidPropertyValue = union(enum) {
    boolean: bool,
    integer: i32,
};

pub const FluidPropertyEntry = struct {
    property: FluidPropertyId,
    value: FluidPropertyValue,
};

pub const FluidStateSpec = struct {
    fluid: Fluid,
    properties: []const FluidPropertyEntry = &.{},
};

// Java TagKey<T> is a record with these two stored fields.
// Its global weak interner is runtime infrastructure and is intentionally absent.

pub const TagKey = struct {
    registry: ResourceKey,
    location: Identifier,
};

// Declarative/bound form of HolderSet<T> for vanilla registry-backed worldgen data.
// Java HolderOwner, lazy binding, identity sets, and random selection are runtime concerns.
// `direct` contains registry keys in source order; `tag` is the named tag key.

pub const RegistryHolderSet = union(enum) {
    direct: []const ResourceKey,
    tag: TagKey,
};

pub fn HolderRef(comptime T: type) type {
    return union(enum) {
        reference: ResourceKey,
        direct: *const T,
    };
}

pub fn HolderSetRef(comptime T: type) type {
    return union(enum) {
        direct: []const HolderRef(T),
        tag: TagKey,
    };
}

pub fn InclusiveRange(comptime T: type) type {
    return struct {
        min_inclusive: T,
        max_inclusive: T,
    };
}

// =============================================================================
// Block/fluid state constant data
// =============================================================================

pub const BlockPropertyData = struct {
    pub const attached: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const berries: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const bloom: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const bottom: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const can_summon: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const conditional: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const disarmed: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const drag: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const enabled: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const extended: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const eye: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const falling: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const hanging: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const has_bottle_0: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const has_bottle_1: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const has_bottle_2: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const has_record: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const has_book: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const inverted: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const in_wall: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const lit: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const locked: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const natural: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const occupied: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const open: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const persistent: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const powered: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const short: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const shrieking: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const signal_fire: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const snowy: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const tip: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const triggered: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const unstable: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const waterlogged: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const horizontal_axis: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .direction_axis, .allowed_ordinals = &.{ 0, 2 } } } };
    pub const axis: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .direction_axis } } };
    pub const up: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const down: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const north: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const east: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const south: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const west: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const facing: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .direction, .allowed_ordinals = &.{ 2, 5, 3, 4, 1, 0 } } } };
    pub const facing_hopper: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .direction, .allowed_ordinals = &.{ 0, 2, 3, 4, 5 } } } };
    pub const horizontal_facing: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .direction, .allowed_ordinals = &.{ 2, 5, 3, 4 } } } };
    pub const flower_amount: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 1, .max_inclusive = 4 } } };
    pub const segment_amount: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 1, .max_inclusive = 4 } } };
    pub const orientation: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .front_and_top } } };
    pub const attach_face: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .attach_face } } };
    pub const bell_attachment: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .bell_attach_type } } };
    pub const east_wall: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .wall_side } } };
    pub const north_wall: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .wall_side } } };
    pub const south_wall: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .wall_side } } };
    pub const west_wall: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .wall_side } } };
    pub const east_redstone: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .redstone_side } } };
    pub const north_redstone: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .redstone_side } } };
    pub const south_redstone: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .redstone_side } } };
    pub const west_redstone: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .redstone_side } } };
    pub const double_block_half: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .double_block_half } } };
    pub const half: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .half } } };
    pub const side_chain_part: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .side_chain_part } } };
    pub const rail_shape: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .rail_shape } } };
    pub const rail_shape_straight: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .rail_shape, .allowed_ordinals = &.{ 0, 1, 2, 3, 4, 5 } } } };
    pub const age_1: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 1 } } };
    pub const age_2: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 2 } } };
    pub const age_3: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 3 } } };
    pub const age_4: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 4 } } };
    pub const age_5: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 5 } } };
    pub const age_7: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 7 } } };
    pub const age_15: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 15 } } };
    pub const age_25: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 25 } } };
    pub const bites: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 6 } } };
    pub const candles: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 1, .max_inclusive = 4 } } };
    pub const delay: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 1, .max_inclusive = 4 } } };
    pub const distance: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 1, .max_inclusive = 7 } } };
    pub const eggs: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 1, .max_inclusive = 4 } } };
    pub const hatch: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 2 } } };
    pub const layers: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 1, .max_inclusive = 8 } } };
    pub const level_cauldron: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 1, .max_inclusive = 3 } } };
    pub const level_composter: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 8 } } };
    pub const level_flowing: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 1, .max_inclusive = 8 } } };
    pub const level_honey: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 5 } } };
    pub const level: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 15 } } };
    pub const moisture: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 7 } } };
    pub const note: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 24 } } };
    pub const pickles: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 1, .max_inclusive = 4 } } };
    pub const power: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 15 } } };
    pub const stage: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 1 } } };
    pub const stability_distance: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 7 } } };
    pub const respawn_anchor_charges: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 4 } } };
    pub const dried_ghast_hydration_levels: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 3 } } };
    pub const rotation_16: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 15 } } };
    pub const bed_part: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .bed_part } } };
    pub const chest_type: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .chest_type } } };
    pub const mode_comparator: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .comparator_mode } } };
    pub const door_hinge: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .door_hinge_side } } };
    pub const noteblock_instrument: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .note_block_instrument } } };
    pub const piston_type: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .piston_type } } };
    pub const slab_type: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .slab_type } } };
    pub const stairs_shape: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .stairs_shape } } };
    pub const structureblock_mode: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .structure_mode } } };
    pub const bamboo_leaves: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .bamboo_leaves } } };
    pub const tilt: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .tilt } } };
    pub const vertical_direction: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .direction, .allowed_ordinals = &.{ 1, 0 } } } };
    pub const speleothem_thickness: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .speleothem_thickness } } };
    pub const sculk_sensor_phase: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .sculk_sensor_phase } } };
    pub const slot_0_occupied: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const slot_1_occupied: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const slot_2_occupied: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const slot_3_occupied: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const slot_4_occupied: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const slot_5_occupied: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const dusted: BlockPropertyDefinition = .{ .property_type = .{ .integer = .{ .min_inclusive = 0, .max_inclusive = 3 } } };
    pub const cracked: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const crafting: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const trial_spawner_state: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .trial_spawner_state } } };
    pub const vault_state: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .vault_state } } };
    pub const creaking_heart_state: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .creaking_heart_state } } };
    pub const ominous: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const test_block_mode: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .test_block_mode } } };
    pub const map: BlockPropertyDefinition = .{ .property_type = .boolean };
    pub const copper_golem_pose: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .copper_golem_statue_block_pose } } };
    pub const potent_sulfur_state: BlockPropertyDefinition = .{ .property_type = .{ .enumeration = .{ .domain = .potent_sulfur_state } } };
};

// FlowingFluid's property definitions.

pub const fluid_falling_property: BlockPropertyType = .boolean;

pub const fluid_level_property: BlockPropertyType = .{ .integer = .{
    .min_inclusive = 1,
    .max_inclusive = 8,
} };

// Source-level fluid state constants useful to feature configuration.

pub const empty_fluid_state: FluidStateSpec = .{ .fluid = .empty };

pub const water_fluid_state: FluidStateSpec = .{ .fluid = .water };

pub const lava_fluid_state: FluidStateSpec = .{ .fluid = .lava };
