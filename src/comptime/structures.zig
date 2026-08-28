//! Immutable structure, placement, pool, alias, and processor configuration.
//! Structure generation/template execution remains runtime code.

const core = @import("core.zig");
const blocks = @import("blocks.zig");
const features = @import("features.zig");
const biomes = @import("biomes.zig");

const Direction = core.Direction;
const GenerationStepDecoration = core.GenerationStepDecoration;
const HeightmapType = core.HeightmapType;
const HeightProvider = core.HeightProvider;
const Identifier = core.Identifier;
const IntProvider = core.IntProvider;
const MobCategory = core.MobCategory;
const ResourceKey = core.ResourceKey;
const Vector3i32 = core.Vector3i32;
const WeightedList = core.WeightedList;

const Blocks = blocks.Blocks;
const BlockStateSpec = blocks.BlockStateSpec;
const HolderRef = blocks.HolderRef;
const RegistryHolderSet = blocks.RegistryHolderSet;

const PlacedFeatureData = features.PlacedFeatureData;
const PosRuleTestData = features.PosRuleTestData;
const RuleTestData = features.RuleTestData;

const MobSpawnerData = biomes.MobSpawnerData;

// =============================================================================
// Structure enums
// =============================================================================

pub const FrontAndTop = enum(i32) {
    down_east = 0,
    down_north = 1,
    down_south = 2,
    down_west = 3,
    up_east = 4,
    up_north = 5,
    up_south = 6,
    up_west = 7,
    west_up = 8,
    east_up = 9,
    north_up = 10,
    south_up = 11,
};

pub const StructureCheckResult = enum(i32) {
    start_present = 0,
    start_not_present = 1,
    chunk_load_needed = 2,
};

pub const StructureSpawnBoundingBoxType = enum(i32) {
    piece = 0,
    structure = 1,
};

pub const TerrainAdjustment = enum(i32) {
    none = 0,
    bury = 1,
    beard_thin = 2,
    beard_box = 3,
    encapsulate = 4,
};

pub const RandomSpreadType = enum(i32) {
    linear = 0,
    triangular = 1,
};

pub const StructureFrequencyReductionMethod = enum(i32) {
    default = 0,
    legacy_type_1 = 1,
    legacy_type_2 = 2,
    legacy_type_3 = 3,
};

pub const StructurePoolProjection = enum(i32) {
    terrain_matching = 0,
    rigid = 1,
};

pub const MineshaftType = enum(i32) {
    normal = 0,
    mesa = 1,
};

pub const OceanRuinType = enum(i32) {
    warm = 0,
    cold = 1,
};

pub const RuinedPortalVerticalPlacement = enum(i32) {
    on_land_surface = 0,
    partly_buried = 1,
    on_ocean_floor = 2,
    in_mountain = 3,
    underground = 4,
    in_nether = 5,
};

pub const StrongholdSmallDoorType = enum(i32) {
    opening = 0,
    wood_door = 1,
    grates = 2,
    iron_door = 3,
};

pub const LiquidSettings = enum(i32) {
    ignore_waterlogging = 0,
    apply_waterlogging = 1,
};

pub const AttachFace = enum(i32) {
    floor = 0,
    wall = 1,
    ceiling = 2,
};

pub const Half = enum(i32) {
    top = 0,
    bottom = 1,
};

pub const RailShape = enum(i32) {
    north_south = 0,
    east_west = 1,
    ascending_east = 2,
    ascending_west = 3,
    ascending_north = 4,
    ascending_south = 5,
    south_east = 6,
    south_west = 7,
    north_west = 8,
    north_east = 9,
};

pub const RedstoneSide = enum(i32) {
    up = 0,
    side = 1,
    none = 2,
};

pub const SlabType = enum(i32) {
    top = 0,
    bottom = 1,
    double = 2,
};

pub const StairsShape = enum(i32) {
    straight = 0,
    inner_left = 1,
    inner_right = 2,
    outer_left = 3,
    outer_right = 4,
};

pub const StructureMode = enum(i32) {
    save = 0,
    load = 1,
    corner = 2,
    data = 3,
};

// =============================================================================
// Structure enum-associated data
// =============================================================================

pub const front_and_top_num_directions: i32 = 6;

pub const front_and_top_front: [12]Direction = .{
    .down,
    .down,
    .down,
    .down,
    .up,
    .up,
    .up,
    .up,
    .west,
    .east,
    .north,
    .south,
};

pub const front_and_top_top: [12]Direction = .{
    .east,
    .north,
    .south,
    .west,
    .east,
    .north,
    .south,
    .west,
    .up,
    .up,
    .up,
    .up,
};

// =============================================================================
// Structure value types
// =============================================================================

pub const BoundingBox = struct {
    min_x: i32,
    min_y: i32,
    min_z: i32,
    max_x: i32,
    max_y: i32,
    max_z: i32,
};

pub const DimensionPadding = struct {
    bottom: i32,
    top: i32,
};

pub const JigsawJunction = struct {
    source_x: i32,
    source_ground_y: i32,
    source_z: i32,
    delta_y: i32,
    destination_projection: StructurePoolProjection,
};

pub const RuinedPortalProperties = struct {
    cold: bool,
    mossiness: f32,
    air_pocket: bool,
    overgrown: bool,
    vines: bool,
    replace_with_blackstone: bool,
};

// =============================================================================
// Structure primitive constants
// =============================================================================

pub const structure_check_no_structure: i32 = -1;

// placement/StructurePlacement.java

pub const structure_placement_highly_arbitrary_random_salt: i32 = 10387320;

// pools/JigsawPlacement.java

pub const jigsaw_placement_unset_height: i32 = -2_147_483_648;

// pools/StructureTemplatePool.java

pub const structure_template_pool_size_unset: i32 = -2_147_483_648;

// structures/DesertPyramidPiece.java

pub const desert_pyramid_piece_width: i32 = 21;

pub const desert_pyramid_piece_depth: i32 = 21;

// structures/EndCityPieces.java

pub const end_city_pieces_max_gen_depth: i32 = 8;

// structures/IglooPieces.java

pub const igloo_pieces_generation_height: i32 = 90;

// structures/JigsawStructure.java

pub const jigsaw_structure_max_total_structure_range: i32 = 128;

pub const jigsaw_structure_min_depth: i32 = 0;

pub const jigsaw_structure_max_depth: i32 = 20;

// structures/JungleTemplePiece.java

pub const jungle_temple_piece_width: i32 = 12;

pub const jungle_temple_piece_depth: i32 = 15;

// structures/MineshaftPieces.java

pub const mineshaft_pieces_default_shaft_width: i32 = 3;

pub const mineshaft_pieces_default_shaft_height: i32 = 3;

pub const mineshaft_pieces_default_shaft_length: i32 = 5;

pub const mineshaft_pieces_max_pillar_height: i32 = 20;

pub const mineshaft_pieces_max_chain_height: i32 = 50;

pub const mineshaft_pieces_max_depth: i32 = 8;

pub const mineshaft_pieces_magic_start_y: i32 = 50;

// structures/NetherFortressPieces.java

pub const nether_fortress_pieces_max_depth: i32 = 30;

pub const nether_fortress_pieces_lowest_y_position: i32 = 10;

pub const nether_fortress_pieces_magic_start_y: i32 = 64;

pub const nether_fortress_pieces_bridge_straight_width: i32 = 5;

pub const nether_fortress_pieces_bridge_straight_height: i32 = 10;

pub const nether_fortress_pieces_bridge_straight_depth: i32 = 19;

pub const nether_fortress_pieces_bridge_end_filler_width: i32 = 5;

pub const nether_fortress_pieces_bridge_end_filler_height: i32 = 10;

pub const nether_fortress_pieces_bridge_end_filler_depth: i32 = 8;

pub const nether_fortress_pieces_bridge_crossing_width: i32 = 19;

pub const nether_fortress_pieces_bridge_crossing_height: i32 = 10;

pub const nether_fortress_pieces_bridge_crossing_depth: i32 = 19;

pub const nether_fortress_pieces_room_crossing_width: i32 = 7;

pub const nether_fortress_pieces_room_crossing_height: i32 = 9;

pub const nether_fortress_pieces_room_crossing_depth: i32 = 7;

pub const nether_fortress_pieces_stairs_room_width: i32 = 7;

pub const nether_fortress_pieces_stairs_room_height: i32 = 11;

pub const nether_fortress_pieces_stairs_room_depth: i32 = 7;

pub const nether_fortress_pieces_monster_throne_width: i32 = 7;

pub const nether_fortress_pieces_monster_throne_height: i32 = 8;

pub const nether_fortress_pieces_monster_throne_depth: i32 = 9;

pub const nether_fortress_pieces_castle_entrance_width: i32 = 13;

pub const nether_fortress_pieces_castle_entrance_height: i32 = 14;

pub const nether_fortress_pieces_castle_entrance_depth: i32 = 13;

pub const nether_fortress_pieces_castle_stalk_room_width: i32 = 13;

pub const nether_fortress_pieces_castle_stalk_room_height: i32 = 14;

pub const nether_fortress_pieces_castle_stalk_room_depth: i32 = 13;

pub const nether_fortress_pieces_castle_small_corridor_piece_width: i32 = 5;

pub const nether_fortress_pieces_castle_small_corridor_piece_height: i32 = 7;

pub const nether_fortress_pieces_castle_small_corridor_piece_depth: i32 = 5;

pub const nether_fortress_pieces_castle_small_corridor_crossing_piece_width: i32 = 5;

pub const nether_fortress_pieces_castle_small_corridor_crossing_piece_height: i32 = 7;

pub const nether_fortress_pieces_castle_small_corridor_crossing_piece_depth: i32 = 5;

pub const nether_fortress_pieces_castle_small_corridor_right_turn_piece_width: i32 = 5;

pub const nether_fortress_pieces_castle_small_corridor_right_turn_piece_height: i32 = 7;

pub const nether_fortress_pieces_castle_small_corridor_right_turn_piece_depth: i32 = 5;

pub const nether_fortress_pieces_castle_small_corridor_left_turn_piece_width: i32 = 5;

pub const nether_fortress_pieces_castle_small_corridor_left_turn_piece_height: i32 = 7;

pub const nether_fortress_pieces_castle_small_corridor_left_turn_piece_depth: i32 = 5;

pub const nether_fortress_pieces_castle_corridor_stairs_piece_width: i32 = 5;

pub const nether_fortress_pieces_castle_corridor_stairs_piece_height: i32 = 14;

pub const nether_fortress_pieces_castle_corridor_stairs_piece_depth: i32 = 10;

pub const nether_fortress_pieces_castle_corridor_t_balcony_piece_width: i32 = 9;

pub const nether_fortress_pieces_castle_corridor_t_balcony_piece_height: i32 = 7;

pub const nether_fortress_pieces_castle_corridor_t_balcony_piece_depth: i32 = 9;

// structures/OceanMonumentPieces.java

pub const ocean_monument_pieces_ocean_monument_piece_do_fill: bool = true;

pub const ocean_monument_pieces_ocean_monument_piece_gridroom_width: i32 = 8;

pub const ocean_monument_pieces_ocean_monument_piece_gridroom_depth: i32 = 8;

pub const ocean_monument_pieces_ocean_monument_piece_gridroom_height: i32 = 4;

pub const ocean_monument_pieces_ocean_monument_piece_grid_width: i32 = 5;

pub const ocean_monument_pieces_ocean_monument_piece_grid_depth: i32 = 5;

pub const ocean_monument_pieces_ocean_monument_piece_grid_height: i32 = 3;

pub const ocean_monument_pieces_ocean_monument_piece_grid_floor_count: i32 = 25;

pub const ocean_monument_pieces_ocean_monument_piece_grid_size: i32 = 75;

pub const ocean_monument_pieces_ocean_monument_piece_gridroom_source_index: i32 = 2;

pub const ocean_monument_pieces_ocean_monument_piece_gridroom_top_connect_index: i32 = 52;

pub const ocean_monument_pieces_ocean_monument_piece_gridroom_leftwing_connect_index: i32 = 25;

pub const ocean_monument_pieces_ocean_monument_piece_gridroom_rightwing_connect_index: i32 = 29;

pub const ocean_monument_pieces_ocean_monument_piece_leftwing_index: i32 = 1001;

pub const ocean_monument_pieces_ocean_monument_piece_rightwing_index: i32 = 1002;

pub const ocean_monument_pieces_ocean_monument_piece_penthouse_index: i32 = 1003;

pub const ocean_monument_pieces_monument_building_width: i32 = 58;

pub const ocean_monument_pieces_monument_building_height: i32 = 22;

pub const ocean_monument_pieces_monument_building_depth: i32 = 58;

pub const ocean_monument_pieces_monument_building_biome_range_check: i32 = 29;

pub const ocean_monument_pieces_monument_building_top_position: i32 = 61;

// structures/RuinedPortalPiece.java

pub const ruined_portal_piece_probability_of_gold_gone: f32 = 0.3;

pub const ruined_portal_piece_probability_of_magma_instead_of_netherrack: f32 = 0.07;

pub const ruined_portal_piece_probability_of_magma_instead_of_lava: f32 = 0.2;

// structures/RuinedPortalStructure.java

pub const ruined_portal_structure_probability_of_giant_portal: f32 = 0.05;

pub const ruined_portal_structure_min_y_index: i32 = 15;

// structures/ShipwreckPieces.java

pub const shipwreck_pieces_number_of_blocks_allowed_in_world_gen_region: i32 = 32;

pub const shipwreck_pieces_pivot: Vector3i32 = .{
    .x = 4,
    .y = 0,
    .z = 15,
};

// structures/StrongholdPieces.java

pub const stronghold_pieces_small_door_width: i32 = 3;

pub const stronghold_pieces_small_door_height: i32 = 3;

pub const stronghold_pieces_max_depth: i32 = 50;

pub const stronghold_pieces_lowest_y_position: i32 = 10;

pub const stronghold_pieces_check_air: bool = true;

pub const stronghold_pieces_magic_start_y: i32 = 64;

pub const stronghold_pieces_stairs_down_width: i32 = 5;

pub const stronghold_pieces_stairs_down_height: i32 = 11;

pub const stronghold_pieces_stairs_down_depth: i32 = 5;

pub const stronghold_pieces_straight_width: i32 = 5;

pub const stronghold_pieces_straight_height: i32 = 5;

pub const stronghold_pieces_straight_depth: i32 = 7;

pub const stronghold_pieces_chest_corridor_width: i32 = 5;

pub const stronghold_pieces_chest_corridor_height: i32 = 5;

pub const stronghold_pieces_chest_corridor_depth: i32 = 7;

pub const stronghold_pieces_straight_stairs_down_width: i32 = 5;

pub const stronghold_pieces_straight_stairs_down_height: i32 = 11;

pub const stronghold_pieces_straight_stairs_down_depth: i32 = 8;

pub const stronghold_pieces_turn_width: i32 = 5;

pub const stronghold_pieces_turn_height: i32 = 5;

pub const stronghold_pieces_turn_depth: i32 = 5;

pub const stronghold_pieces_room_crossing_width: i32 = 11;

pub const stronghold_pieces_room_crossing_height: i32 = 7;

pub const stronghold_pieces_room_crossing_depth: i32 = 11;

pub const stronghold_pieces_prison_hall_width: i32 = 9;

pub const stronghold_pieces_prison_hall_height: i32 = 5;

pub const stronghold_pieces_prison_hall_depth: i32 = 11;

pub const stronghold_pieces_library_width: i32 = 14;

pub const stronghold_pieces_library_height: i32 = 6;

pub const stronghold_pieces_library_tall_height: i32 = 11;

pub const stronghold_pieces_library_depth: i32 = 15;

pub const stronghold_pieces_five_crossing_width: i32 = 10;

pub const stronghold_pieces_five_crossing_height: i32 = 9;

pub const stronghold_pieces_five_crossing_depth: i32 = 11;

pub const stronghold_pieces_portal_room_width: i32 = 11;

pub const stronghold_pieces_portal_room_height: i32 = 8;

pub const stronghold_pieces_portal_room_depth: i32 = 16;

// structures/WoodlandMansionPieces.java

pub const woodland_mansion_pieces_mansion_grid_default_size: i32 = 11;

pub const woodland_mansion_pieces_mansion_grid_clear: i32 = 0;

pub const woodland_mansion_pieces_mansion_grid_corridor: i32 = 1;

pub const woodland_mansion_pieces_mansion_grid_room: i32 = 2;

pub const woodland_mansion_pieces_mansion_grid_start_room: i32 = 3;

pub const woodland_mansion_pieces_mansion_grid_test_room: i32 = 4;

pub const woodland_mansion_pieces_mansion_grid_blocked: i32 = 5;

pub const woodland_mansion_pieces_mansion_grid_room_1x1: i32 = 65536;

pub const woodland_mansion_pieces_mansion_grid_room_1x2: i32 = 131072;

pub const woodland_mansion_pieces_mansion_grid_room_2x2: i32 = 262144;

pub const woodland_mansion_pieces_mansion_grid_room_origin_flag: i32 = 1048576;

pub const woodland_mansion_pieces_mansion_grid_room_door_flag: i32 = 2097152;

pub const woodland_mansion_pieces_mansion_grid_room_stairs_flag: i32 = 4194304;

pub const woodland_mansion_pieces_mansion_grid_room_corridor_flag: i32 = 8388608;

pub const woodland_mansion_pieces_mansion_grid_room_type_mask: i32 = 983040;

pub const woodland_mansion_pieces_mansion_grid_room_id_mask: i32 = 65535;

// templatesystem/BlockAgeProcessor.java

pub const block_age_processor_probability_of_replacing_full_block: f32 = 0.5;

pub const block_age_processor_probability_of_replacing_stairs: f32 = 0.5;

pub const block_age_processor_probability_of_replacing_obsidian: f32 = 0.15;

// =============================================================================
// Structure constant value objects
// =============================================================================

pub const dimension_padding_zero: DimensionPadding = .{
    .bottom = 0,
    .top = 0,
};

// =============================================================================
// Structure/pool/processor declarative types
// =============================================================================

pub const StructureSpawnOverrideData = struct {
    bounding_box: StructureSpawnBoundingBoxType,
    spawns: WeightedList(MobSpawnerData),
};

pub const StructureSpawnOverrideEntryData = struct {
    category: MobCategory,
    override: StructureSpawnOverrideData,
};

pub const StructureSettingsData = struct {
    biomes: RegistryHolderSet,
    spawn_overrides: []const StructureSpawnOverrideEntryData,
    step: GenerationStepDecoration,
    terrain_adjustment: TerrainAdjustment,
};

pub const StructurePlacementExclusionZoneData = struct {
    other_set: HolderRef(StructureSetData),
    chunk_count: i32,
};

pub const StructurePlacementBaseData = struct {
    locate_offset: Vector3i32,
    frequency_reduction_method: StructureFrequencyReductionMethod,
    frequency: f32,
    salt: i32,
    exclusion_zone: ?StructurePlacementExclusionZoneData,
};

pub const ConcentricRingsStructurePlacementData = struct {
    base: StructurePlacementBaseData,
    distance: i32,
    spread: i32,
    count: i32,
    preferred_biomes: RegistryHolderSet,
};

pub const RandomSpreadStructurePlacementData = struct {
    base: StructurePlacementBaseData,
    spacing: i32,
    separation: i32,
    spread_type: RandomSpreadType,
};

pub const StructurePlacementData = union(enum) {
    concentric_rings: ConcentricRingsStructurePlacementData,
    random_spread: RandomSpreadStructurePlacementData,
};

pub const StructureSelectionEntryData = struct {
    structure: HolderRef(StructureData),
    weight: i32,
};

pub const StructureSetData = struct {
    structures: []const StructureSelectionEntryData,
    placement: StructurePlacementData,
};

pub const JigsawMaxDistanceData = struct {
    horizontal: i32,
    vertical: i32,
};

pub const DirectPoolAliasData = struct {
    alias: ResourceKey,
    target: ResourceKey,
};

pub const RandomPoolAliasData = struct {
    alias: ResourceKey,
    targets: WeightedList(ResourceKey),
};

pub const PoolAliasBindingData = union(enum) {
    direct: DirectPoolAliasData,
    random: RandomPoolAliasData,

    // Each weighted entry selects an entire ordered alias-binding group.
    random_group: WeightedList([]const PoolAliasBindingData),
};

pub const JigsawStructureData = struct {
    settings: StructureSettingsData,
    start_pool: HolderRef(StructureTemplatePoolData),
    start_jigsaw_name: ?Identifier,
    max_depth: i32,
    start_height: HeightProvider,
    use_expansion_hack: bool,
    project_start_to_heightmap: ?HeightmapType,
    max_distance_from_center: JigsawMaxDistanceData,
    pool_aliases: []const PoolAliasBindingData,
    dimension_padding: DimensionPadding,
    liquid_settings: LiquidSettings,
};

pub const RuinedPortalSetupData = struct {
    placement: RuinedPortalVerticalPlacement,
    air_pocket_probability: f32,
    mossiness: f32,
    overgrown: bool,
    vines: bool,
    can_be_cold: bool,
    replace_with_blackstone: bool,
    weight: f32,
};

pub const StructureData = union(enum) {
    buried_treasure: StructureSettingsData,
    desert_pyramid: StructureSettingsData,
    end_city: StructureSettingsData,
    igloo: StructureSettingsData,
    jigsaw: JigsawStructureData,
    jungle_temple: StructureSettingsData,

    mineshaft: struct {
        settings: StructureSettingsData,
        mineshaft_type: MineshaftType,
    },

    nether_fortress: StructureSettingsData,

    nether_fossil: struct {
        settings: StructureSettingsData,
        height: HeightProvider,
    },

    ocean_monument: StructureSettingsData,

    ocean_ruin: struct {
        settings: StructureSettingsData,
        biome_type: OceanRuinType,
        large_probability: f32,
        cluster_probability: f32,
    },

    ruined_portal: struct {
        settings: StructureSettingsData,
        setups: []const RuinedPortalSetupData,
    },

    shipwreck: struct {
        settings: StructureSettingsData,
        is_beached: bool,
    },

    stronghold: StructureSettingsData,
    swamp_hut: StructureSettingsData,
    woodland_mansion: StructureSettingsData,
};

//
// Template pools
//

pub const StructurePoolElementData = union(enum) {
    empty: StructurePoolProjection,

    feature: struct {
        feature: HolderRef(PlacedFeatureData),
        projection: StructurePoolProjection,
    },

    // Vanilla serialized pool data refers to templates by Identifier. Java also permits an inline
    // StructureTemplate at runtime; that runtime-only branch is intentionally excluded.
    single: struct {
        template: Identifier,
        processors: HolderRef(StructureProcessorListData),
        projection: StructurePoolProjection,
        override_liquid_settings: ?LiquidSettings,
    },

    legacy_single: struct {
        template: Identifier,
        processors: HolderRef(StructureProcessorListData),
        projection: StructurePoolProjection,
        override_liquid_settings: ?LiquidSettings,
    },

    list: struct {
        elements: []const StructurePoolElementData,
        projection: StructurePoolProjection,
    },
};

pub const WeightedStructurePoolElementData = struct {
    element: StructurePoolElementData,
    weight: i32,
};

pub const StructureTemplatePoolData = struct {
    fallback: HolderRef(StructureTemplatePoolData),

    // Java rawTemplates is the source-defining weighted list.
    // Its expanded `templates` list and `maxSize` are constructor/runtime-derived and omitted.
    raw_templates: []const WeightedStructurePoolElementData,
};

//
// Structure processors
//

pub const ProcessorRuleData = struct {
    input_predicate: RuleTestData,
    location_predicate: RuleTestData,
    position_predicate: PosRuleTestData,
    output_state: BlockStateSpec,

    // Java's RuleBlockEntityModifier is handled separately below.
    block_entity_modifier: RuleBlockEntityModifierData,
};

pub const RuleBlockEntityModifierData = union(enum) {
    passthrough,
    clear,

    append_loot: ResourceKey,

    // AppendStatic stores an NBT CompoundTag. NBT is intentionally deferred until that data model
    // exists, so no append_static variant is provided yet.
};

pub const StructureProcessorData = union(enum) {
    block_ignore: []const Blocks,

    block_rot: struct {
        rottable_blocks: ?RegistryHolderSet,
        integrity: f32,
    },

    gravity: struct {
        heightmap: HeightmapType,
        offset: i32,
    },

    jigsaw_replacement,
    lava_submerged,

    rule: []const ProcessorRuleData,

    nop,

    block_age: struct {
        mossiness: f32,
    },

    blackstone_replace,

    protected_blocks: RegistryHolderSet,

    capped: struct {
        delegate: *const StructureProcessorData,
        limit: IntProvider,
    },
};

pub const StructureProcessorListData = struct {
    processors: []const StructureProcessorData,
};

// =============================================================================
// Structure/pool/processor constant data
// =============================================================================

pub const structure_spawn_overrides_empty: []const StructureSpawnOverrideEntryData = &.{};

pub const structure_pool_element_empty_rigid: StructurePoolElementData = .{
    .empty = .rigid,
};

pub const structure_processor_nop: StructureProcessorData = .nop;

pub const structure_processor_jigsaw_replacement: StructureProcessorData = .jigsaw_replacement;

pub const structure_processor_lava_submerged: StructureProcessorData = .lava_submerged;

pub const structure_processor_blackstone_replace: StructureProcessorData = .blackstone_replace;

pub const rule_block_entity_modifier_passthrough: RuleBlockEntityModifierData = .passthrough;

pub const rule_block_entity_modifier_clear: RuleBlockEntityModifierData = .clear;
