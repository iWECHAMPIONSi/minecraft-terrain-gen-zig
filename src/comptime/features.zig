//! Immutable feature, carver, provider, predicate, tree, and placement configuration.
//! Placement/sampling/execution remains runtime code.

const core = @import("core.zig");
const blocks = @import("blocks.zig");

const CaveSurface = core.CaveSurface;
const Direction = core.Direction;
const DirectionAxis = core.DirectionAxis;
const HeightmapType = core.HeightmapType;
const HeightProvider = core.HeightProvider;
const Identifier = core.Identifier;
const IntProvider = core.IntProvider;
const FloatProvider = core.FloatProvider;
const NormalNoiseParameters = core.NormalNoiseParameters;
const ResourceKey = core.ResourceKey;
const Rotation = core.Rotation;
const UniformInt = core.UniformInt;
const Vector3i32 = core.Vector3i32;
const VerticalAnchor = core.VerticalAnchor;
const WeightedList = core.WeightedList;

const Blocks = blocks.Blocks;
const BlockPropertyId = blocks.BlockPropertyId;
const BlockStateSpec = blocks.BlockStateSpec;
const FluidStateSpec = blocks.FluidStateSpec;
const HolderRef = blocks.HolderRef;
const HolderSetRef = blocks.HolderSetRef;
const InclusiveRange = blocks.InclusiveRange;
const RegistryHolderSet = blocks.RegistryHolderSet;
const TagKey = blocks.TagKey;

// =============================================================================
// Feature constants
// =============================================================================

pub const huge_mushroom_min_height: i32 = 4;

pub const basalt_columns_clustered_reach: i32 = 5;

pub const basalt_columns_clustered_size: i32 = 50;

pub const basalt_columns_unclustered_reach: i32 = 8;

pub const basalt_columns_unclustered_size: i32 = 15;

pub const delta_rim_spawn_chance: f64 = 0.9;

pub const end_podium_radius: i32 = 4;

pub const end_podium_pillar_height: i32 = 4;

pub const end_podium_rim_radius: i32 = 1;

pub const end_podium_corner_rounding: f32 = 0.5;

pub const end_podium_location: Vector3i32 = vec3i_zero;

pub const end_spike_count: i32 = 10;

pub const end_spike_distance: i32 = 42;

pub const fallen_tree_stump_height: i32 = 1;

pub const fallen_tree_stump_height_plus_empty_space: i32 = 2;

pub const fallen_tree_max_fall_height_to_ground: i32 = 5;

pub const fallen_tree_max_ground_gap: i32 = 2;

pub const fallen_tree_max_space_from_stump: i32 = 2;

pub const fallen_tree_one_in_chance: f32 = 80.0;

pub const huge_fungus_probability: f32 = 0.06;

pub const scattered_ore_max_dist_from_origin: i32 = 7;

pub const void_start_platform_offset: Vector3i32 = .{
    .x = 8,
    .y = 3,
    .z = 8,
};

pub const void_start_platform_radius: i32 = 16;

pub const void_start_platform_radius_chunks: i32 = 1;

pub const feature_size_max_width: i32 = 16;

pub const mangrove_root_width_limit: i32 = 8;

pub const mangrove_root_length_limit: i32 = 15;

pub const fancy_trunk_height_scale: f64 = 0.618;

pub const fancy_trunk_cluster_density_magic: f64 = 1.382;

pub const fancy_trunk_branch_slope: f64 = 0.381;

pub const fancy_trunk_branch_length_magic: f64 = 0.328;

pub const trunk_max_base_height: i32 = 32;

pub const trunk_max_rand: i32 = 24;

pub const trunk_max_height: i32 = 80;

// -----------------------------------------------------------------------------
// Old-world blending / retrogen compatibility constants
// These do not affect a completely fresh world, but are worldgen constants.
// -----------------------------------------------------------------------------

// =============================================================================
// Feature/carver/provider/placement declarative types
// =============================================================================

pub const RuleTestData = union(enum) {
    always_true,
    block_match: Blocks,
    block_state_match: BlockStateSpec,
    random_block_match: struct {
        block: Blocks,
        probability: f32,
    },
    random_block_state_match: struct {
        block_state: BlockStateSpec,
        probability: f32,
    },
    tag_match: TagKey,
};

pub const PosRuleTestData = union(enum) {
    always_true,
    linear: struct {
        min_chance: f32,
        max_chance: f32,
        min_dist: i32,
        max_dist: i32,
    },
    axis_aligned_linear: struct {
        min_chance: f32,
        max_chance: f32,
        min_dist: i32,
        max_dist: i32,
        axis: DirectionAxis,
    },
};

//
// Block predicates
//

pub const BlockPredicateData = union(enum) {
    all_of: []const *const BlockPredicateData,
    any_of: []const *const BlockPredicateData,

    has_sturdy_face: struct {
        offset: Vector3i32,
        direction: Direction,
    },

    inside_world_bounds: Vector3i32,
    matching_biomes: RegistryHolderSet,

    matching_block_tag: struct {
        offset: Vector3i32,
        tag: TagKey,
    },

    matching_blocks: struct {
        offset: Vector3i32,
        blocks: RegistryHolderSet,
    },

    matching_fluids: struct {
        offset: Vector3i32,
        fluids: RegistryHolderSet,
    },

    not: *const BlockPredicateData,
    replaceable: Vector3i32,
    solid: Vector3i32,
    true_value,
    unobstructed: Vector3i32,

    would_survive: struct {
        offset: Vector3i32,
        state: BlockStateSpec,
    },
};

//
// Block-state providers
//

pub const BlockStateProviderRuleData = struct {
    if_true: *const BlockPredicateData,
    then: *const BlockStateProviderData,
};

pub const NoiseProviderBaseData = struct {
    seed: i64,
    parameters: NormalNoiseParameters,
    scale: f32,
};

pub const BlockStateProviderData = union(enum) {
    simple: BlockStateSpec,

    weighted: WeightedList(BlockStateSpec),

    noise_provider: struct {
        seed: i64,
        parameters: NormalNoiseParameters,
        scale: f32,
        states: []const BlockStateSpec,
    },

    dual_noise_provider: struct {
        variety: InclusiveRange(i32),
        slow_noise_parameters: NormalNoiseParameters,
        slow_scale: f32,
        seed: i64,
        parameters: NormalNoiseParameters,
        scale: f32,
        states: []const BlockStateSpec,
    },

    noise_threshold_provider: struct {
        seed: i64,
        parameters: NormalNoiseParameters,
        scale: f32,
        threshold: f32,
        high_chance: f32,
        default_state: BlockStateSpec,
        low_states: []const BlockStateSpec,
        high_states: []const BlockStateSpec,
    },

    // Java also stores a mutable cached IntegerProperty. It is runtime state and omitted.
    randomized_int: struct {
        source: *const BlockStateProviderData,
        property: BlockPropertyId,
        values: IntProvider,
    },

    rotated_block: Blocks,

    rule_based: struct {
        fallback: ?*const BlockStateProviderData,
        rules: []const BlockStateProviderRuleData,
    },
};

//
// Placement modifiers
//

pub const PlacementModifierData = union(enum) {
    biome_filter,
    in_square,

    block_predicate_filter: *const BlockPredicateData,
    count_on_every_layer: IntProvider,
    count: IntProvider,

    environment_scan: struct {
        direction_of_search: Direction,
        target_condition: *const BlockPredicateData,
        allowed_search_condition: *const BlockPredicateData,
        max_steps: i32,
    },

    fixed: []const Vector3i32,
    height_range: HeightProvider,
    heightmap: HeightmapType,

    noise_based_count: struct {
        noise_to_count_ratio: i32,
        noise_factor: f64,
        noise_offset: f64,
    },

    noise_threshold_count: struct {
        noise_level: f64,
        below_noise: i32,
        above_noise: i32,
    },

    random_offset: struct {
        xz_spread: IntProvider,
        y_spread: IntProvider,
    },

    rarity_filter: i32,

    surface_relative_threshold: struct {
        heightmap: HeightmapType,
        min_inclusive: i32,
        max_inclusive: i32,
    },

    surface_water_depth_filter: i32,
};

//
// Carvers
//

pub const CarverDebugSettingsData = struct {
    debug_mode: bool,
    air_state: BlockStateSpec,
    water_state: BlockStateSpec,
    lava_state: BlockStateSpec,
    barrier_state: BlockStateSpec,
};

pub const CarverConfigurationData = struct {
    probability: f32,
    y: HeightProvider,
    y_scale: FloatProvider,
    lava_level: VerticalAnchor,
    debug_settings: CarverDebugSettingsData,
    replaceable: RegistryHolderSet,
};

pub const CaveCarverConfigurationData = struct {
    probability: f32,
    y: HeightProvider,
    y_scale: FloatProvider,
    lava_level: VerticalAnchor,
    debug_settings: CarverDebugSettingsData,
    replaceable: RegistryHolderSet,

    horizontal_radius_multiplier: FloatProvider,
    vertical_radius_multiplier: FloatProvider,
    floor_level: FloatProvider,
};

pub const CanyonShapeConfigurationData = struct {
    distance_factor: FloatProvider,
    thickness: FloatProvider,
    width_smoothness: i32,
    horizontal_radius_factor: FloatProvider,
    vertical_radius_default_factor: f32,
    vertical_radius_center_factor: f32,
};

pub const CanyonCarverConfigurationData = struct {
    probability: f32,
    y: HeightProvider,
    y_scale: FloatProvider,
    lava_level: VerticalAnchor,
    debug_settings: CarverDebugSettingsData,
    replaceable: RegistryHolderSet,

    vertical_rotation: FloatProvider,
    shape: CanyonShapeConfigurationData,
};

pub const ConfiguredWorldCarverData = union(enum) {
    cave: CaveCarverConfigurationData,
    nether_cave: CaveCarverConfigurationData,
    canyon: CanyonCarverConfigurationData,
};

//
// Tree strategy/configuration types
//

pub const StraightTrunkPlacerData = struct {
    base_height: i32,
    height_rand_a: i32,
    height_rand_b: i32,
};

pub const ForkingTrunkPlacerData = StraightTrunkPlacerData;

pub const GiantTrunkPlacerData = StraightTrunkPlacerData;

pub const MegaJungleTrunkPlacerData = StraightTrunkPlacerData;

pub const DarkOakTrunkPlacerData = StraightTrunkPlacerData;

pub const FancyTrunkPlacerData = StraightTrunkPlacerData;

pub const BendingTrunkPlacerData = struct {
    base_height: i32,
    height_rand_a: i32,
    height_rand_b: i32,
    min_height_for_leaves: i32,
    bend_length: IntProvider,
};

pub const UpwardsBranchingTrunkPlacerData = struct {
    base_height: i32,
    height_rand_a: i32,
    height_rand_b: i32,
    extra_branch_steps: IntProvider,
    place_branch_per_log_probability: f32,
    extra_branch_length: IntProvider,
    can_grow_through: RegistryHolderSet,
};

pub const CherryTrunkPlacerData = struct {
    base_height: i32,
    height_rand_a: i32,
    height_rand_b: i32,
    branch_count: IntProvider,
    branch_horizontal_length: IntProvider,
    branch_start_offset_from_top: UniformInt,
    branch_end_offset_from_top: IntProvider,

    // Java derives and stores:
    // secondBranchStartOffsetFromTop = UniformInt.of(min, max - 1).
    // It is intentionally not duplicated in source/config data.
};

pub const TrunkPlacerData = union(enum) {
    straight: StraightTrunkPlacerData,
    forking: ForkingTrunkPlacerData,
    giant: GiantTrunkPlacerData,
    mega_jungle: MegaJungleTrunkPlacerData,
    dark_oak: DarkOakTrunkPlacerData,
    fancy: FancyTrunkPlacerData,
    bending: BendingTrunkPlacerData,
    upwards_branching: UpwardsBranchingTrunkPlacerData,
    cherry: CherryTrunkPlacerData,
};

pub const BasicFoliagePlacerData = struct {
    radius: IntProvider,
    offset: IntProvider,
};

pub const HeightFoliagePlacerData = struct {
    radius: IntProvider,
    offset: IntProvider,
    height: i32,
};

pub const ProviderHeightFoliagePlacerData = struct {
    radius: IntProvider,
    offset: IntProvider,
    height: IntProvider,
};

pub const RandomSpreadFoliagePlacerData = struct {
    radius: IntProvider,
    offset: IntProvider,
    foliage_height: IntProvider,
    leaf_placement_attempts: i32,
};

pub const CherryFoliagePlacerData = struct {
    radius: IntProvider,
    offset: IntProvider,
    height: IntProvider,
    wide_bottom_layer_hole_chance: f32,
    corner_hole_chance: f32,
    hanging_leaves_chance: f32,
    hanging_leaves_extension_chance: f32,
};

pub const FoliagePlacerData = union(enum) {
    blob: HeightFoliagePlacerData,
    spruce: struct {
        radius: IntProvider,
        offset: IntProvider,
        trunk_height: IntProvider,
    },
    pine: ProviderHeightFoliagePlacerData,
    acacia: BasicFoliagePlacerData,
    bush: HeightFoliagePlacerData,
    fancy: HeightFoliagePlacerData,
    mega_jungle: HeightFoliagePlacerData,
    mega_pine: struct {
        radius: IntProvider,
        offset: IntProvider,
        crown_height: IntProvider,
    },
    dark_oak: BasicFoliagePlacerData,
    random_spread: RandomSpreadFoliagePlacerData,
    cherry: CherryFoliagePlacerData,
};

pub const AboveRootPlacementData = struct {
    above_root_provider: *const BlockStateProviderData,
    above_root_placement_chance: f32,
};

pub const MangroveRootPlacementData = struct {
    can_grow_through: RegistryHolderSet,
    muddy_roots_in: RegistryHolderSet,
    muddy_roots_provider: *const BlockStateProviderData,
    max_root_width: i32,
    max_root_length: i32,
    random_skew_chance: f32,
};

pub const MangroveRootPlacerData = struct {
    trunk_offset_y: IntProvider,
    root_provider: *const BlockStateProviderData,
    above_root_placement: ?AboveRootPlacementData,
    mangrove_root_placement: MangroveRootPlacementData,
};

pub const RootPlacerData = union(enum) {
    mangrove: MangroveRootPlacerData,
};

pub const TwoLayersFeatureSizeData = struct {
    limit: i32,
    lower_size: i32,
    upper_size: i32,
    min_clipped_height: ?i32,
};

pub const ThreeLayersFeatureSizeData = struct {
    limit: i32,
    upper_limit: i32,
    lower_size: i32,
    middle_size: i32,
    upper_size: i32,
    min_clipped_height: ?i32,
};

pub const FeatureSizeData = union(enum) {
    two_layers: TwoLayersFeatureSizeData,
    three_layers: ThreeLayersFeatureSizeData,
};

pub const TreeDecoratorData = union(enum) {
    trunk_vine,

    leave_vine: struct {
        probability: f32,
    },

    pale_moss: struct {
        leaves_probability: f32,
        trunk_probability: f32,
        ground_probability: f32,
    },

    creaking_heart: struct {
        probability: f32,
    },

    cocoa: struct {
        probability: f32,
    },

    beehive: struct {
        probability: f32,
    },

    alter_ground: struct {
        provider: *const BlockStateProviderData,
    },

    attached_to_leaves: struct {
        probability: f32,
        exclusion_radius_xz: i32,
        exclusion_radius_y: i32,
        block_provider: *const BlockStateProviderData,
        required_empty_blocks: i32,
        directions: []const Direction,
    },

    place_on_ground: struct {
        tries: i32,
        radius: i32,
        height: i32,
        block_state_provider: *const BlockStateProviderData,
    },

    attached_to_logs: struct {
        probability: f32,
        block_provider: *const BlockStateProviderData,
        directions: []const Direction,
    },
};

//
// Feature configuration records
//

pub const NoneFeatureConfigurationData = struct {};

pub const BlockBlobConfigurationData = struct {
    state: BlockStateSpec,
    can_place_on: *const BlockPredicateData,
};

pub const BlockColumnLayerData = struct {
    height: IntProvider,
    state: *const BlockStateProviderData,
};

pub const BlockColumnConfigurationData = struct {
    layers: []const BlockColumnLayerData,
    direction: Direction,
    allowed_placement: *const BlockPredicateData,
    prioritize_tip: bool,
};

pub const BlockPileConfigurationData = struct {
    state_provider: *const BlockStateProviderData,
};

pub const BlockStateConfigurationData = struct {
    state: BlockStateSpec,
};

pub const ColumnFeatureConfigurationData = struct {
    reach: IntProvider,
    height: IntProvider,
};

pub const CountConfigurationData = struct {
    count: IntProvider,
};

pub const DeltaFeatureConfigurationData = struct {
    contents: BlockStateSpec,
    rim: BlockStateSpec,
    size: IntProvider,
    rim_size: IntProvider,
};

pub const DiskConfigurationData = struct {
    state_provider: *const BlockStateProviderData,
    target: *const BlockPredicateData,
    radius: IntProvider,
    half_height: i32,
};

pub const EndGatewayConfigurationData = struct {
    exit: ?Vector3i32,
    exact: bool,
};

pub const EndSpikeData = struct {
    center_x: i32,
    center_z: i32,
    radius: i32,
    height: i32,
    guarded: bool,

    // Java EndSpike.topBoundingBox is derived from these fields and omitted.
};

pub const EndSpikeConfigurationData = struct {
    crystal_invulnerable: bool,
    spikes: []const EndSpikeData,
    crystal_beam_target: ?Vector3i32,
};

pub const FallenTreeConfigurationData = struct {
    trunk_provider: *const BlockStateProviderData,
    log_length: IntProvider,
    stump_decorators: []const TreeDecoratorData,
    log_decorators: []const TreeDecoratorData,
};

pub const GeodeBlockSettingsData = struct {
    filling_provider: *const BlockStateProviderData,
    inner_layer_provider: *const BlockStateProviderData,
    alternate_inner_layer_provider: *const BlockStateProviderData,
    middle_layer_provider: *const BlockStateProviderData,
    outer_layer_provider: *const BlockStateProviderData,
    inner_placements: []const BlockStateSpec,
    cannot_replace: RegistryHolderSet,
    invalid_blocks: RegistryHolderSet,
};

pub const GeodeLayerSettingsData = struct {
    filling: f64,
    inner_layer: f64,
    middle_layer: f64,
    outer_layer: f64,
};

pub const GeodeCrackSettingsData = struct {
    generate_crack_chance: f64,
    base_crack_size: f64,
    crack_point_offset: i32,
};

pub const GeodeConfigurationData = struct {
    geode_block_settings: GeodeBlockSettingsData,
    geode_layer_settings: GeodeLayerSettingsData,
    geode_crack_settings: GeodeCrackSettingsData,
    use_potential_placements_chance: f64,
    use_alternate_layer_0_chance: f64,
    placements_require_layer_0_alternate: bool,
    outer_wall_distance: IntProvider,
    distribution_points: IntProvider,
    point_offset: IntProvider,
    min_gen_offset: i32,
    max_gen_offset: i32,
    noise_multiplier: f64,
    invalid_blocks_threshold: i32,
};

pub const HugeMushroomFeatureConfigurationData = struct {
    cap_provider: *const BlockStateProviderData,
    stem_provider: *const BlockStateProviderData,
    foliage_radius: i32,
    can_place_on: *const BlockPredicateData,
};

pub const LargeDripstoneConfigurationData = struct {
    replaceable_blocks: RegistryHolderSet,
    floor_to_ceiling_search_range: i32,
    column_radius: IntProvider,
    height_scale: FloatProvider,
    max_column_radius_to_cave_height_ratio: f32,
    stalactite_bluntness: FloatProvider,
    stalagmite_bluntness: FloatProvider,
    wind_speed: FloatProvider,
    min_radius_for_wind: i32,
    min_bluntness_for_wind: f32,
};

pub const LayerConfigurationData = struct {
    height: i32,
    state: BlockStateSpec,
};

pub const MultifaceGrowthConfigurationData = struct {
    place_block: Blocks,
    search_range: i32,
    can_place_on_floor: bool,
    can_place_on_ceiling: bool,
    can_place_on_wall: bool,
    chance_of_spreading: f32,
    can_be_placed_on: RegistryHolderSet,

    // Java validDirections is constructor-derived from the three booleans above.
};

pub const NetherForestVegetationConfigurationData = struct {
    spread_width: i32,
    spread_height: i32,
};

pub const OreTargetBlockStateData = struct {
    target: RuleTestData,
    state: BlockStateSpec,
};

pub const OreConfigurationData = struct {
    target_states: []const OreTargetBlockStateData,
    size: i32,
    discard_chance_on_air_exposure: f32,
};

pub const ProbabilityFeatureConfigurationData = struct {
    probability: f32,
};

pub const ReplaceBlockConfigurationData = struct {
    target_states: []const OreTargetBlockStateData,
};

pub const ReplaceSphereConfigurationData = struct {
    target_state: BlockStateSpec,
    replace_state: BlockStateSpec,
    radius: IntProvider,
};

pub const RootSystemConfigurationData = struct {
    tree_feature: HolderRef(PlacedFeatureData),
    required_vertical_space_for_tree: i32,
    level_test_distance: i32,
    max_level_deviation: i32,
    root_radius: i32,
    root_replaceable: RegistryHolderSet,
    root_state_provider: *const BlockStateProviderData,
    root_placement_attempts: i32,
    root_column_max_height: i32,
    hanging_root_radius: i32,
    hanging_roots_vertical_span: i32,
    hanging_root_state_provider: *const BlockStateProviderData,
    hanging_root_placement_attempts: i32,
    allowed_vertical_water_for_tree: i32,
    allowed_tree_position: *const BlockPredicateData,
};

pub const SculkPatchConfigurationData = struct {
    charge_count: i32,
    amount_per_charge: i32,
    spread_attempts: i32,
    growth_rounds: i32,
    spread_rounds: i32,
    extra_rare_growths: IntProvider,
    catalyst_chance: f32,
};

pub const SimpleBlockConfigurationData = struct {
    to_place: *const BlockStateProviderData,
    schedule_tick: bool,
};

pub const SpeleothemClusterConfigurationData = struct {
    base_block: BlockStateSpec,
    pointed_block: BlockStateSpec,
    replaceable_blocks: RegistryHolderSet,
    floor_to_ceiling_search_range: i32,
    height: IntProvider,
    radius: IntProvider,
    max_stalagmite_stalactite_height_diff: i32,
    height_deviation: i32,
    speleothem_block_layer_thickness: IntProvider,
    density: FloatProvider,
    wetness: FloatProvider,
    chance_of_speleothem_at_max_distance_from_center: f32,
    max_distance_from_edge_affecting_chance_of_speleothem: i32,
    max_distance_from_center_affecting_height_bias: i32,
};

pub const SpeleothemConfigurationData = struct {
    base_block: BlockStateSpec,
    pointed_block: BlockStateSpec,
    replaceable_blocks: RegistryHolderSet,
    chance_of_taller_generation: f32,
    chance_of_directional_spread: f32,
    chance_of_spread_radius_2: f32,
    chance_of_spread_radius_3: f32,
};

pub const SpikeConfigurationData = struct {
    state: BlockStateSpec,
    can_place_on: *const BlockPredicateData,
    can_replace: *const BlockPredicateData,
};

pub const SpringConfigurationData = struct {
    state: FluidStateSpec,
    requires_block_below: bool,
    rock_count: i32,
    hole_count: i32,
    valid_blocks: RegistryHolderSet,
};

pub const TemplateFeatureEntryData = struct {
    template: Identifier,
    rotations: []const Rotation,
};

pub const TemplateFeatureConfigurationData = struct {
    templates: WeightedList(TemplateFeatureEntryData),
};

pub const TreeConfigurationData = struct {
    trunk_provider: *const BlockStateProviderData,
    trunk_placer: TrunkPlacerData,
    foliage_provider: *const BlockStateProviderData,
    foliage_placer: FoliagePlacerData,
    root_placer: ?RootPlacerData,
    minimum_size: FeatureSizeData,
    decorators: []const TreeDecoratorData,
    ignore_vines: bool,
    below_trunk_provider: *const BlockStateProviderData,
};

pub const TwistingVinesConfigurationData = struct {
    spread_width: i32,
    spread_height: i32,
    max_height: i32,
};

pub const UnderwaterMagmaConfigurationData = struct {
    floor_search_range: i32,
    placement_radius_around_floor: i32,
    placement_probability_per_valid_position: f32,
};

pub const VegetationPatchConfigurationData = struct {
    replaceable: RegistryHolderSet,
    ground_state: *const BlockStateProviderData,
    vegetation_feature: HolderRef(PlacedFeatureData),
    surface: CaveSurface,
    depth: IntProvider,
    extra_bottom_block_chance: f32,
    vertical_range: i32,
    vegetation_chance: f32,
    xz_radius: IntProvider,
    extra_edge_column_chance: f32,
};

pub const WeightedPlacedFeatureData = struct {
    feature: HolderRef(PlacedFeatureData),
    chance: f32,
};

pub const RandomFeatureConfigurationData = struct {
    features: []const WeightedPlacedFeatureData,
    default_feature: HolderRef(PlacedFeatureData),
};

pub const WeightedRandomFeatureConfigurationData = struct {
    features: WeightedList(HolderRef(PlacedFeatureData)),
};

pub const CompositeFeatureConfigurationData = struct {
    features: HolderSetRef(PlacedFeatureData),
};

pub const RandomBooleanFeatureConfigurationData = struct {
    feature_true: HolderRef(PlacedFeatureData),
    feature_false: HolderRef(PlacedFeatureData),
};

pub const HugeFungusConfigurationData = struct {
    valid_base_state: BlockStateSpec,
    stem_state: BlockStateSpec,
    hat_state: BlockStateSpec,
    decor_state: BlockStateSpec,
    replaceable_blocks: *const BlockPredicateData,
    planted: bool,
};

pub const LakeConfigurationData = struct {
    fluid: *const BlockStateProviderData,
    barrier: *const BlockStateProviderData,
    can_place_feature: *const BlockPredicateData,
    can_replace_with_air_or_fluid: *const BlockPredicateData,
    can_replace_with_barrier: *const BlockPredicateData,
};

// Vanilla fossil configuration uses bound registry holders for processor lists.
// The Java Holder wrapper is flattened to the processor-list ResourceKey.

pub const FossilFeatureConfigurationData = struct {
    fossil_structures: []const Identifier,
    overlay_structures: []const Identifier,
    fossil_processors: ResourceKey,
    overlay_processors: ResourceKey,
    max_empty_corners_allowed: i32,
};

//
// ConfiguredFeature / PlacedFeature recursion
//

pub const ConfiguredFeatureData = union(enum) {
    no_op: NoneFeatureConfigurationData,
    tree: TreeConfigurationData,
    fallen_tree: FallenTreeConfigurationData,
    block_pile: BlockPileConfigurationData,
    spring: SpringConfigurationData,
    chorus_plant: NoneFeatureConfigurationData,
    replace_single_block: ReplaceBlockConfigurationData,
    void_start_platform: NoneFeatureConfigurationData,
    desert_well: NoneFeatureConfigurationData,
    fossil: FossilFeatureConfigurationData,
    huge_red_mushroom: HugeMushroomFeatureConfigurationData,
    huge_brown_mushroom: HugeMushroomFeatureConfigurationData,
    spike: SpikeConfigurationData,
    glowstone_blob: NoneFeatureConfigurationData,
    freeze_top_layer: NoneFeatureConfigurationData,
    vines: NoneFeatureConfigurationData,
    block_column: BlockColumnConfigurationData,
    vegetation_patch: VegetationPatchConfigurationData,
    waterlogged_vegetation_patch: VegetationPatchConfigurationData,
    root_system: RootSystemConfigurationData,
    multiface_growth: MultifaceGrowthConfigurationData,
    underwater_magma: UnderwaterMagmaConfigurationData,
    monster_room: NoneFeatureConfigurationData,
    blue_ice: NoneFeatureConfigurationData,
    iceberg: BlockStateConfigurationData,
    block_blob: BlockBlobConfigurationData,
    disk: DiskConfigurationData,
    lake: LakeConfigurationData,
    ore: OreConfigurationData,
    end_platform: NoneFeatureConfigurationData,
    end_spike: EndSpikeConfigurationData,
    end_island: NoneFeatureConfigurationData,
    end_gateway: EndGatewayConfigurationData,
    seagrass: ProbabilityFeatureConfigurationData,
    kelp: NoneFeatureConfigurationData,
    coral_tree: NoneFeatureConfigurationData,
    coral_mushroom: NoneFeatureConfigurationData,
    coral_claw: NoneFeatureConfigurationData,
    sea_pickle: CountConfigurationData,
    simple_block: SimpleBlockConfigurationData,
    bamboo: ProbabilityFeatureConfigurationData,
    huge_fungus: HugeFungusConfigurationData,
    nether_forest_vegetation: NetherForestVegetationConfigurationData,
    weeping_vines: NoneFeatureConfigurationData,
    twisting_vines: TwistingVinesConfigurationData,
    basalt_columns: ColumnFeatureConfigurationData,
    delta_feature: DeltaFeatureConfigurationData,
    replace_blobs: ReplaceSphereConfigurationData,
    fill_layer: LayerConfigurationData,
    bonus_chest: NoneFeatureConfigurationData,
    basalt_pillar: NoneFeatureConfigurationData,
    scattered_ore: OreConfigurationData,
    random_selector: RandomFeatureConfigurationData,
    weighted_random_selector: WeightedRandomFeatureConfigurationData,
    simple_random_selector: CompositeFeatureConfigurationData,
    random_boolean_selector: RandomBooleanFeatureConfigurationData,
    sequence: CompositeFeatureConfigurationData,
    template: TemplateFeatureConfigurationData,
    geode: GeodeConfigurationData,
    speleothem_cluster: SpeleothemClusterConfigurationData,
    large_dripstone: LargeDripstoneConfigurationData,
    speleothem: SpeleothemConfigurationData,
    sculk_patch: SculkPatchConfigurationData,
};

pub const PlacedFeatureData = struct {
    feature: HolderRef(ConfiguredFeatureData),
    placement: []const PlacementModifierData,
};

// =============================================================================
// Feature/carver/provider/placement constant data
// =============================================================================

pub const none_feature_configuration: NoneFeatureConfigurationData = .{};

pub const block_predicate_true: BlockPredicateData = .true_value;

pub const placement_biome_filter: PlacementModifierData = .biome_filter;

pub const placement_in_square: PlacementModifierData = .in_square;

pub const trunk_placer_max_base_height: i32 = 32;

pub const trunk_placer_max_rand: i32 = 24;

pub const trunk_placer_max_height: i32 = 80;

pub const end_spike_number_of_spikes: i32 = 10;

pub const beehive_worldgen_facing: Direction = .south;

// Direction.Plane.HORIZONTAL is [north, east, south, west].
// BeehiveDecorator filters out WORLDGEN_FACING.getOpposite() == north.

pub const beehive_spawn_directions: [3]Direction = .{
    .east,
    .south,
    .west,
};

pub const rule_test_always_true: RuleTestData = .always_true;

pub const pos_rule_test_always_true: PosRuleTestData = .always_true;

pub const tree_decorator_trunk_vine: TreeDecoratorData = .trunk_vine;
